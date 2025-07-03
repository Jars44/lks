package com.seleknas.esemkalibrary

import android.app.DatePickerDialog
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.seleknas.esemkalibrary.databinding.BookItemBinding
import com.seleknas.esemkalibrary.databinding.CartItemBinding
import com.seleknas.esemkalibrary.databinding.FragmentCartBinding
import com.seleknas.esemkalibrary.databinding.FragmentHomeBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.io.DataOutputStream
import java.net.HttpRetryException
import java.net.HttpURLConnection
import java.net.URL
import java.time.LocalDate
import java.time.format.DateTimeFormatter


class CartFragment : Fragment() {
    private lateinit var binding: FragmentCartBinding
    private var start = LocalDate.now()
    private var end = start.plusDays(3)

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentCartBinding.inflate(inflater, container, false)

        binding.startBtn.text = start.format(DateTimeFormatter.ofPattern("dd MMM yyyy"))
        binding.endBtn.text = end.format(DateTimeFormatter.ofPattern("dd MMM yyyy"))

        binding.startBtn.setOnClickListener {
            DatePickerDialog(requireContext()).apply {
                updateDate(start.year, start.monthValue - 1, start.dayOfMonth)
                setOnDateSetListener { _, i, i2, i3 ->
                    start = LocalDate.of(i, i2 + 1, i3)

                    end = start.plusDays(3)
                    binding.startBtn.text = start.format(DateTimeFormatter.ofPattern("dd MMM yyyy"))
                    binding.endBtn.text = end.format(DateTimeFormatter.ofPattern("dd MMM yyyy"))
                }
            }.show()
        }

        showCart()

        binding.bookingBtn.setOnClickListener {
            val data = JSONObject().apply {
                put("startAt", start.toString())
                put("endAt", end.toString())
                put("bookIds", JSONArray().apply {
                    requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                        val cart = JSONArray(getString("cart", "[]"))
                        for (i in 0..<cart.length()) {
                            val item = cart.getJSONObject(i)
                            put(item.getString("id"))
                        }
                    }
                })
            }


            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/Api/Borrowing").openConnection() as HttpURLConnection

                requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                    val token = getString("token", "")
                    conn.setRequestProperty("Authorization", "Bearer $token")
                }

                conn.requestMethod = "POST"
                conn.setRequestProperty("Content-Type", "application/json")
                conn.doOutput = true

                DataOutputStream(conn.outputStream).use {
                    it.writeBytes(data.toString())
                    it.flush()
                }

                if (conn.responseCode in 200..299) {
                    launch(Dispatchers.Main) {
                        Toast.makeText(requireContext(), "Booking success", Toast.LENGTH_SHORT).show()
                        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                            edit().apply {
                                putString("cart", "[]")
                            }.apply()
                        }
                        showCart()
                    }
                } else if (conn.responseCode == 401) {
                    launch(Dispatchers.Main) {
                        Intent(requireContext(), MainActivity::class.java).apply {
                            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                        }.let {
                            startActivity(it)
                        }
                    }
                } else {
                    Toast.makeText(requireContext(), "Booking failed", Toast.LENGTH_SHORT).show()
                }
            }
        }

        return binding.root
    }

    private fun showCart() {
        requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
            val cart = JSONArray(getString("cart", "[]"))

            binding.cartRv.layoutManager = LinearLayoutManager(requireContext())
            class ViewHolder(val binding: CartItemBinding) : RecyclerView.ViewHolder(binding.root)
            binding.cartRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                    val binding = CartItemBinding.inflate(layoutInflater, parent, false)
                    return ViewHolder(binding)
                }

                override fun getItemCount(): Int = cart.length()

                override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                    val item = cart.getJSONObject(position)
                    holder.binding.cartTitle.text = item.getString("name")
                    holder.binding.cartIsbn.text = item.getString("isbn")
                    holder.binding.cartAvailable.text = item.getString("available")
                    holder.binding.cartAuthor.text = item.getString("authors")

                    holder.binding.delBtn.setOnClickListener {
                        cart.remove(position)
                        edit().apply {
                            putString("cart", cart.toString())
                        }.apply()
                        Toast.makeText(requireContext(), "Removed from cart", Toast.LENGTH_SHORT).show()
                        showCart()
                    }

                    lifecycleScope.launch(Dispatchers.IO) {
                        try {
                            val bitmap = BitmapFactory.decodeStream(URL("http://10.0.2.2:5000/Api/Book/${item.getString("id")}/Photo").openStream())
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