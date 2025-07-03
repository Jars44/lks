package com.seleknas.esemkalibrary

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.seleknas.esemkalibrary.databinding.CategoryItemBinding
import com.seleknas.esemkalibrary.databinding.FragmentHistoryDetailBinding
import com.seleknas.esemkalibrary.databinding.HistoryDetailItemBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

private const val ARG_PARAM1 = "id"

class HistoryDetailFragment : Fragment() {
    private var param1: String? = null
    private lateinit var binding: FragmentHistoryDetailBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHistoryDetailBinding.inflate(inflater, container, false)

        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
            val token = getString("token", "")

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/Api/Borrowing/${param1}").openConnection() as HttpURLConnection
                conn.setRequestProperty("Authorization", "Bearer $token")
                val data = JSONObject(conn.inputStream.bufferedReader().readText())

                launch(Dispatchers.Main) {
                    binding.date.text = "${
                        LocalDateTime.parse(data.getString("startAt")).format(
                            DateTimeFormatter.ofPattern("dd MMM yyy"))} - ${
                        LocalDateTime.parse(data.getString("endAt")).format(
                            DateTimeFormatter.ofPattern("dd MMM yyy"))}"
                    binding.status.text = data.getString("status")

                    binding.bookRv.layoutManager = LinearLayoutManager(requireContext())
                    class CategoryHolder(val binding: HistoryDetailItemBinding) : ViewHolder(binding.root)
                    binding.bookRv.adapter = object : RecyclerView.Adapter<CategoryHolder>() {
                        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryHolder {
                            val binding = HistoryDetailItemBinding.inflate(layoutInflater, parent, false)
                            return CategoryHolder(binding)
                        }

                        override fun getItemCount(): Int = data.getJSONArray("bookBorrowings").length()

                        override fun onBindViewHolder(holder: CategoryHolder, position: Int) {
                            val item = data.getJSONArray("bookBorrowings").getJSONObject(position)
                            val book = item.getJSONObject("book")

                            holder.binding.cartTitle.text = book.getString("name")
                            holder.binding.cartAuthor.text = book.getString("authors")
                            holder.binding.cartIsbn.text = book.getString("isbn")

                            launch(Dispatchers.IO) {
                                try {
                                    val bitmap = BitmapFactory.decodeStream(URL("http://10.0.2.2:5000/Api/Book/${item.getString("bookId")}/Photo").openStream())
                                    launch(Dispatchers.Main) {
                                        holder.binding.cartImg.setImageBitmap(bitmap)
                                    }
                                } catch(_: Throwable) {}
                            }
                        }

                    }
                }
            }
        }


        return binding.root
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String) =
            HistoryDetailFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                }
            }
    }
}