package com.seleknas.tiks09

import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.SpinnerAdapter
import android.widget.Toast
import androidx.core.content.res.ResourcesCompat
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.navigation.NavigationBarView.OnItemSelectedListener
import com.seleknas.tiks09.databinding.FragmentMovieDetailBinding
import com.seleknas.tiks09.databinding.GenreItemLayoutBinding
import com.seleknas.tiks09.databinding.GenreItemVerticalLayoutBinding
import com.seleknas.tiks09.databinding.MovieItemLayoutBinding
import com.seleknas.tiks09.databinding.SectionItemLayoutBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import java.io.DataOutputStream
import java.net.HttpURLConnection
import java.net.URL

private const val ARG_PARAM1 = "param1"

class MovieDetailFragment : Fragment() {
    private lateinit var binding: FragmentMovieDetailBinding
    private var param1: String? = null

    var selectedSeats = mutableListOf<String>()
    var scheduleId: Int? = null
    var totalPrice = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentMovieDetailBinding.inflate(layoutInflater, container, false)

        binding.buyBtn.setOnClickListener {
            val data = JSONObject().apply {
                put("user", Constant.User)
                put("schedule", scheduleId)
                put("seats", JSONArray().apply {
                    for (dt in selectedSeats) {
                        put(dt)
                    }
                })
            }

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("${Constant.URL}/Buy").openConnection() as HttpURLConnection
                conn.doOutput = true
                conn.requestMethod = "POST"
                conn.setRequestProperty("Content-Type", "application/json")

                DataOutputStream(conn.outputStream).use {
                    it.writeBytes(data.toString())
                    it.flush()
                }

                if (conn.responseCode in 200..299) {
                    launch(Dispatchers.Main) {
                        Toast.makeText(requireContext(), "Your ticket was bougth succesfully", Toast.LENGTH_SHORT).show()
                    }
                } else {
                    launch(Dispatchers.Main) {
                        Toast.makeText(requireContext(), "Failed to buy your ticket", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }

        lifecycleScope.launch(Dispatchers.IO) {
            val mov = JSONObject(URL("${Constant.URL}/Movie/${param1}").openStream().bufferedReader().readText())

            try {
                val bitmap = BitmapFactory.decodeStream(URL("${Constant.URL}/Movie/${mov.getString("id")}/Photo").openStream())
                launch(Dispatchers.Main) {
                    binding.movImg.setImageBitmap(bitmap)
                }
            } catch (_: Throwable) {}

            launch(Dispatchers.Main) {
                binding.movTitle.text = mov.getString("title")
                binding.movDetail.text = mov.getString("year") + mov.getString("duration") + " Minutes"
                binding.movDesc.text = mov.getString("description")

                val genres = mov.getJSONArray("genres")
                binding.genreRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                class ViewHolder(val binding: GenreItemLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                binding.genreRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                        val binding = GenreItemLayoutBinding.inflate(layoutInflater, parent, false)
                        return ViewHolder(binding)
                    }

                    override fun getItemCount(): Int = genres.length()

                    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                        holder.binding.genre.text = genres.getString(position)
                    }
                }

                val schedules = mov.getJSONArray("schedule");
                val theaters = mutableListOf<String>()

                for (i in 0..<schedules.length()) {
                    val theater = schedules.getJSONObject(i).getJSONObject("theater")
                    val name = theater.getString("name")
                    if (!theaters.contains(name)) {
                        theaters.add(name)
                    }
                }

                binding.theaterSpinner.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, theaters)

                binding.theaterSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                    override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                        val dates = mutableListOf<String>()
                        for (i in 0..<schedules.length()) {
                            val schedule = schedules.getJSONObject(i)
                            val theater = schedule.getJSONObject("theater")
                            val theaterName = theater.getString("name")

                            if (theaterName == theaters[p2]) {
                                dates.add(schedule.getString("date"))
                            }
                        }

                        binding.datesRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                        class ViewHolder(val binding: GenreItemLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                        binding.datesRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                            fun loadTimes(pos: Int) {
                                val times = mutableListOf<String>()
                                for (i in 0..<schedules.length()) {
                                    val schedule = schedules.getJSONObject(i)
                                    val theater = schedule.getJSONObject("theater")
                                    val theaterName = theater.getString("name")
                                    val date = schedule.getString("date")

                                    if (theaterName == theaters[p2] && date == dates[pos]) {
                                        times.add(schedule.getString("time"))
                                    }
                                }

                                binding.timesRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                                class ViewHolder(val binding: GenreItemLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                                binding.timesRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                                    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                                        val binding = GenreItemLayoutBinding.inflate(layoutInflater, parent, false)
                                        if (times.size > 0) loadSeats(pos, 0)
                                        return ViewHolder(binding)
                                    }

                                    fun loadSeats(datePos: Int, timePos: Int) {
                                        scheduleId = null
                                        selectedSeats.clear()
                                        totalPrice = 0
                                        for (i in 0..<schedules.length()) {
                                            val schedule = schedules.getJSONObject(i)
                                            val theater = schedule.getJSONObject("theater")
                                            val theaterName = theater.getString("name")
                                            val date = schedule.getString("date")
                                            val time = schedule.getString("time")

                                            if (theaterName == theaters[p2] && date == dates[datePos] && time == times[timePos]) {
                                                val section = theater.getInt("section")
                                                val column = theater.getInt("column")
                                                val row = theater.getInt("row")

                                                binding.seatRv.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
                                                class ViewHolder(val binding: SectionItemLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                                                binding.seatRv.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                                                    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                                                        val binding = SectionItemLayoutBinding.inflate(layoutInflater, parent, false)
                                                        return ViewHolder(binding)
                                                    }

                                                    override fun getItemCount(): Int = section

                                                    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                                                        holder.binding.root.layoutManager = GridLayoutManager(requireContext(), column)
                                                        class ViewHolder(val binding: GenreItemVerticalLayoutBinding) : RecyclerView.ViewHolder(binding.root)
                                                        holder.binding.root.adapter = object : RecyclerView.Adapter<ViewHolder>() {
                                                            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                                                                val binding = GenreItemVerticalLayoutBinding.inflate(layoutInflater, parent, false)
                                                                return ViewHolder(binding)
                                                            }

                                                            override fun getItemCount(): Int = row * column

                                                            override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                                                                holder.binding.genre.text = (65 + (position % column)).toChar().toString()
                                                                holder.binding.genre.setOnClickListener {
                                                                    holder.binding.genre.background = ResourcesCompat.getDrawable(resources, R.color.black, null)
                                                                    scheduleId = schedule.getInt("id")
                                                                    selectedSeats.add((65 + ((column - position) % column)).toChar().toString())
                                                                    totalPrice += schedule.getInt("price")
                                                                    this@MovieDetailFragment.binding.buyBtn.text = "$totalPrice -> Buy"
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    override fun getItemCount(): Int = times.size

                                    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                                        holder.binding.genre.text = times[position]
                                        holder.binding.genre.setOnClickListener {
                                            loadSeats(pos, 0)
                                        }
                                    }
                                }
                            }

                            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
                                val binding = GenreItemLayoutBinding.inflate(layoutInflater, parent, false)
                                if (dates.size > 0) loadTimes(0)
                                return ViewHolder(binding)
                            }

                            override fun getItemCount(): Int = dates.size

                            override fun onBindViewHolder(holder: ViewHolder, position: Int) {
                                holder.binding.genre.text = dates[position]


                                holder.binding.genre.setOnClickListener {
                                    loadTimes(position)
                                }
                            }
                        }
                    }

                    override fun onNothingSelected(p0: AdapterView<*>?) {
                    }
                }
            }
        }

        return binding.root
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String) =
            MovieDetailFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                }
            }
    }
}