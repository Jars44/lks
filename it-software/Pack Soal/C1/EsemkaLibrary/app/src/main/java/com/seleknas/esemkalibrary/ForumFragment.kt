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
import com.seleknas.esemkalibrary.databinding.ForumItemBinding
import com.seleknas.esemkalibrary.databinding.FragmentForumBinding
import com.seleknas.esemkalibrary.databinding.FragmentHomeBinding
import com.seleknas.esemkalibrary.databinding.ThreadDetailItemBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL


class ForumFragment : Fragment() {
    private lateinit var binding: FragmentForumBinding
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentForumBinding.inflate(inflater, container, false)

        binding.addBtn.setOnClickListener {
            (requireActivity() as HomeActivity).showFragment(CreateForumFragment())
        }

        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
            val token = getString("token", "")
            lifecycleScope.launch(Dispatchers.IO) {
                val conn1 = URL("http://10.0.2.2:5000/Api/User/Me").openConnection() as HttpURLConnection
                conn1.setRequestProperty("Authorization", "Bearer $token")
                val me = JSONObject(conn1.inputStream.bufferedReader().readText())

                val conn = URL("http://10.0.2.2:5000/Api/Thread").openConnection() as HttpURLConnection
                conn.setRequestProperty("Authorization", "Bearer $token")

                val data = JSONArray(conn.inputStream.bufferedReader().readText())

                lifecycleScope.launch(Dispatchers.Main) {
                    binding.forumRv.layoutManager = LinearLayoutManager(requireContext())
                    class CategoryHolder(val binding: ForumItemBinding) : ViewHolder(binding.root)
                    binding.forumRv.adapter = object : RecyclerView.Adapter<CategoryHolder>() {
                        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryHolder {
                            val binding = ForumItemBinding.inflate(layoutInflater, parent, false)
                            return CategoryHolder(binding)
                        }

                        override fun getItemCount(): Int = data.length()

                        override fun onBindViewHolder(holder: CategoryHolder, position: Int) {
                            val item = data.getJSONObject(position)
                            holder.binding.title.text = item.getString("title")
                            holder.binding.latest.text = item.getString("lastestReply")
                            holder.binding.user.text = item.getJSONObject("createdBy").getString("name")

                            val email = item.getJSONObject("createdBy").getString("email")
                            val meEmail = me.getString("email")
                            if (email != meEmail) holder.binding.delBtn.visibility = View.INVISIBLE;

                            holder.binding.root.setOnClickListener {
                                (requireActivity() as HomeActivity).showFragment(TreadDetailFragment.newInstance(item.getString("id")))
                            }
                        }

                    }
                }
            }
        }

        return binding.root
    }
}