package com.seleknas.esemkalibrary

import android.graphics.BitmapFactory
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.seleknas.esemkalibrary.databinding.BookItemBinding
import com.seleknas.esemkalibrary.databinding.CategoryItemBinding
import com.seleknas.esemkalibrary.databinding.FragmentHomeBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import java.net.URL


class HomeFragment : Fragment() {
    private lateinit var binding: FragmentHomeBinding
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false)

        load()

        binding.searchEt.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                load()
            }

            override fun afterTextChanged(p0: Editable?) {
            }

        })

        return binding.root
    }

    private fun load() {
        lifecycleScope.launch(Dispatchers.IO) {
            val res = URL("http://10.0.2.2:5000/Api/Book?searchText=${binding.searchEt.text}").openStream().bufferedReader().readText()
            val data = JSONArray(res)

            launch(Dispatchers.Main) {
                showBooks(data.getJSONObject(0).getJSONArray("books"))

                binding.categoryRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                class CategoryHolder(val binding: CategoryItemBinding) : ViewHolder(binding.root)
                binding.categoryRv.adapter = object : RecyclerView.Adapter<CategoryHolder>() {
                    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryHolder {
                        val binding = CategoryItemBinding.inflate(layoutInflater, parent, false)
                        return CategoryHolder(binding)
                    }

                    override fun getItemCount(): Int = data.length()

                    override fun onBindViewHolder(holder: CategoryHolder, position: Int) {
                        val item = data.getJSONObject(position)
                        holder.binding.categoryBtn.text = item.getString("name")
                        holder.binding.categoryBtn.setOnClickListener {
                            showBooks(item.getJSONArray("books"))
                        }
                    }

                }
            }
        }
    }


    fun showBooks(data: JSONArray) {
        binding.bookRv.layoutManager = GridLayoutManager(requireContext(), 2)
        class ViewHolder(val binding: BookItemBinding) : RecyclerView.ViewHolder(binding.root)
        binding.bookRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                val binding = BookItemBinding.inflate(layoutInflater, parent, false)
                return ViewHolder(binding)
            }

            override fun getItemCount(): Int = data.length()

            override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                val item = data.getJSONObject(position)
                holder.binding.bookTitle.text = item.getString("name")
                holder.binding.bookAuthor.text = item.getString("authors")

                holder.binding.root.setOnClickListener {
                    (requireActivity() as HomeActivity).showFragment(BookDetailFragment.newInstance(item.getString("id")))
                }

                lifecycleScope.launch(Dispatchers.IO) {
                    try {
                        val bitmap = BitmapFactory.decodeStream(URL("http://10.0.2.2:5000/Api/Book/${item.getString("id")}/Photo").openStream())
                        launch(Dispatchers.Main) {
                            holder.binding.bookImg.setImageBitmap(bitmap)
                        }
                    } catch(_: Throwable) {}
                }
            }

        }
    }
}