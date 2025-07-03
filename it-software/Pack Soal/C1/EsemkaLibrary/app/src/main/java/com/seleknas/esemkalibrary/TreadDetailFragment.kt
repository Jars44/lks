package com.seleknas.esemkalibrary

import android.content.Context
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
import com.seleknas.esemkalibrary.databinding.FragmentTreadDetailBinding
import com.seleknas.esemkalibrary.databinding.ThreadDetailItemBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "id"

/**
 * A simple [Fragment] subclass.
 * Use the [TreadDetailFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class TreadDetailFragment : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private lateinit var binding: FragmentTreadDetailBinding

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
        binding = FragmentTreadDetailBinding.inflate(layoutInflater)

        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
            val token = getString("token", "")

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/Api/Thread/$param1").openConnection() as HttpURLConnection
                conn.setRequestProperty("Authorization", "Bearer $token")

                val data = JSONObject(conn.inputStream.bufferedReader().readText())
                val posts = data.getJSONArray("posts")

                launch(Dispatchers.Main) {
                    binding.treadRv.layoutManager = LinearLayoutManager(requireContext())
                    class CategoryHolder(val binding: ThreadDetailItemBinding) : ViewHolder(binding.root)
                    binding.treadRv.adapter = object : RecyclerView.Adapter<CategoryHolder>() {
                        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryHolder {
                            val binding = ThreadDetailItemBinding.inflate(layoutInflater, parent, false)
                            return CategoryHolder(binding)
                        }

                        override fun getItemCount(): Int = posts.length()

                        override fun onBindViewHolder(holder: CategoryHolder, position: Int) {
                            val item = posts.getJSONObject(position)
                            holder.binding.body.text = item.getString("content")
                            holder.binding.user.text = item.getJSONObject("createdBy").getString("name")
                        }

                    }
                }

            }
        }

        return binding.root
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String, ) =
            TreadDetailFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                }
            }
    }
}