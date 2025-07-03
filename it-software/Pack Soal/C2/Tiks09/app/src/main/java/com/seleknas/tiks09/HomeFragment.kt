package com.seleknas.tiks09

import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.seleknas.tiks09.databinding.FragmentHomeBinding
import com.seleknas.tiks09.databinding.MovieItemLayoutBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.net.URL

class HomeFragment : Fragment() {
    private lateinit var  binding: FragmentHomeBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(layoutInflater)

        lifecycleScope.launch(Dispatchers.IO) {
            val mov = JSONObject(URL("${Constant.URL}/Home/PreviewMovie").openStream().bufferedReader().readText())

            try {
                val bitmap = BitmapFactory.decodeStream(URL("${Constant.URL}/Movie/${mov.getString("id")}/Photo").openStream())
                launch(Dispatchers.Main) {
                    binding.movImg.setImageBitmap(bitmap)
                }
            } catch (_: Throwable) {}

            launch(Dispatchers.Main) {
                binding.movTitle.text = mov.getString("title")
                binding.movDetail.text = mov.getString("genre") + mov.getString("duration") + " Minutes"
            }


            val movies = JSONArray(URL("${Constant.URL}/Home/NewMovies").openStream().bufferedReader().readText())
            launch(Dispatchers.Main) {
                binding.movRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                class ViewHolder(val binding: MovieItemLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                binding.movRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                        val binding = MovieItemLayoutBinding.inflate(layoutInflater, parent, false)
                        return ViewHolder(binding)
                    }

                    override fun getItemCount(): Int = movies.length()

                    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                        val item = movies.getJSONObject(position)

                        lifecycleScope.launch(Dispatchers.IO) {
                            try {
                                val bitmap = BitmapFactory.decodeStream(URL("${Constant.URL}/Movie/${item.getString("id")}/Photo").openStream())
                                launch(Dispatchers.Main) {
                                    holder.binding.movImg.setImageBitmap(bitmap)
                                }
                            } catch (_: Throwable) {}
                        }

                        holder.binding.movTitle.text = item.getString("title")
                        holder.binding.movDetail.text = item.getString("genre") + item.getString("duration") + " Minutes"

                        holder.binding.root.setOnClickListener {
                            (requireActivity() as HomeActivity).showFragment(MovieDetailFragment.newInstance(item.getString("id")))
                        }
                    }

                }
            }
        }

        return binding.root
    }
}