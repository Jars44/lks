package com.seleknas.esemkalibrary

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.lifecycleScope
import com.seleknas.esemkalibrary.databinding.FragmentBookDetailBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.net.URL

private const val ARG_PARAM1 = "id"

/**
 * A simple [Fragment] subclass.
 * Use the [BookDetailFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class BookDetailFragment : Fragment() {
    private var param1: String? = null
    private lateinit var binding: FragmentBookDetailBinding

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
        binding = FragmentBookDetailBinding.inflate(layoutInflater, container, false)

        lifecycleScope.launch(Dispatchers.IO) {
            val res = URL("http://10.0.2.2:5000/Api/Book/$param1").openStream().bufferedReader().readText()
            val data = JSONObject(res)

            try {
                val bitmap = BitmapFactory.decodeStream(URL("http://10.0.2.2:5000/Api/Book/${data.getString("id")}/Photo").openStream())
                launch(Dispatchers.Main) {
                    binding.bookImg.setImageBitmap(bitmap)
                }
            } catch(_: Throwable) {}

            launch(Dispatchers.Main) {
                binding.bookTitle.text = data.getString("name")
                binding.bookAuthor.text = data.getString("authors")
                binding.bookIsbn.text = "ISBN: ${data.getString("isbn")}"
                binding.bookDesc.text = data.getString("description")
                binding.bookPublisher.text = "PUBLISHER: ${data.getString("publisher")}"
                binding.bookAvailable.text = "AVAILABLE: ${data.getString("available")}"

                binding.addBtn.setOnClickListener {
                    if (data.getInt("available") > 0) {
                        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                            val cart = JSONArray(getString("cart", "[]"))

                            var isAdded = false
                            for (i in 0..<cart.length()) {
                                val item = cart.getJSONObject(i)
                                isAdded = isAdded || item.getString("id") == param1
                            }

                            if (isAdded) {
                                Toast.makeText(requireContext(), "This book already added to cart", Toast.LENGTH_SHORT).show()
                            } else {
                                cart.put(data)
                                edit().apply {
                                    putString("cart", cart.toString())
                                }.apply()
                                Toast.makeText(requireContext(), "Added to cart", Toast.LENGTH_SHORT).show()
                            }
                        }
                    } else {
                        Toast.makeText(requireContext(), "Book is not available", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }

        return binding.root
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String) =
            BookDetailFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                }
            }
    }
}