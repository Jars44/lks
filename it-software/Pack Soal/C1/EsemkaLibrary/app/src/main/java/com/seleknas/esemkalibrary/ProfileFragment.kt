package com.seleknas.esemkalibrary

import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.seleknas.esemkalibrary.databinding.CartItemBinding
import com.seleknas.esemkalibrary.databinding.FragmentHomeBinding
import com.seleknas.esemkalibrary.databinding.FragmentProfileBinding
import com.seleknas.esemkalibrary.databinding.HistoryItemBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter


class ProfileFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding

    private val launcher = registerForActivityResult(ActivityResultContracts.GetContent()) {
        binding.profileImg.setImageURI(it!!)
    }
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false)

        binding.logoutBtn.setOnClickListener {
            Intent(requireContext(), MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }.let {
                startActivity(it)
            }
        }

        binding.uploadBtn.setOnClickListener {
            launcher.launch("image/*")
        }

        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
            val token = getString("token", "")

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/Api/User/Me").openConnection() as HttpURLConnection
                conn.setRequestProperty("Authorization", "Bearer $token")

                try {
                    val conn2 = URL("http://10.0.2.2:5000/Api/User/Me/Photo").openConnection() as HttpURLConnection
                    conn2.setRequestProperty("Authorization", "Bearer $token")

                    val bitmap = BitmapFactory.decodeStream(conn2.inputStream)
                    launch(Dispatchers.Main) {
                        binding.profileImg.setImageBitmap(bitmap)
                    }
                } catch(_: Throwable) {}

                val data = JSONObject(conn.inputStream.bufferedReader().readText())

                launch(Dispatchers.Main) {
                    binding.userName.text = data.getString("name")
                    binding.userEmail.text = data.getString("email")
                }

                val conn3 = URL("http://10.0.2.2:5000/Api/Borrowing").openConnection() as HttpURLConnection
                conn3.setRequestProperty("Authorization", "Bearer $token")

                val data2 = JSONArray(conn3.inputStream.bufferedReader().readText())
                launch(Dispatchers.Main) {
                    binding.historyRv.layoutManager = LinearLayoutManager(requireContext())
                    class ViewHolder(val binding: HistoryItemBinding) : RecyclerView.ViewHolder(binding.root)
                    binding.historyRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                            val binding = HistoryItemBinding.inflate(layoutInflater, parent, false)
                            return ViewHolder(binding)
                        }

                        override fun getItemCount(): Int = data2.length()

                        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                            val item = data2.getJSONObject(position)
                            holder.binding.date.text = "${LocalDateTime.parse(item.getString("startAt")).format(
                                DateTimeFormatter.ofPattern("dd MMM yyy"))} - ${LocalDateTime.parse(item.getString("endAt")).format(
                                DateTimeFormatter.ofPattern("dd MMM yyy"))}"

                            holder.binding.status.text = item.getString("status")
                            holder.binding.count.text = "${item.getString("bookCount")} Books"

                            holder.binding.root.setOnClickListener {
                                (requireActivity() as HomeActivity).showFragment(HistoryDetailFragment.newInstance(item.getString("id")))
                            }
                        }

                    }
                }
            }



        }



        return binding.root
    }
}