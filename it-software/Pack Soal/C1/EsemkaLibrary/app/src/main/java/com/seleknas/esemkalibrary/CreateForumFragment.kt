package com.seleknas.esemkalibrary

import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.lifecycleScope
import com.seleknas.esemkalibrary.databinding.FragmentCreateForumBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.io.DataOutputStream
import java.net.HttpURLConnection
import java.net.URL

class CreateForumFragment : Fragment() {
    private lateinit var binding: FragmentCreateForumBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentCreateForumBinding.inflate(layoutInflater, container, false)

        binding.addBtn.setOnClickListener {
            requireContext().getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                val token = getString("token", "")

                lifecycleScope.launch(Dispatchers.IO) {
                    val data = JSONObject().apply {
                        put("subject", binding.subjectEt.text.toString())
                        put("body", binding.bodyEt.text.toString())
                    }

                    val conn = URL("http://10.0.2.2:5000/Api/Thread").openConnection() as HttpURLConnection
                    conn.setRequestProperty("Authorization", "Bearer $token")
                    conn.setRequestProperty("Content-Type", "application/json")
                    conn.doOutput = true
                    conn.requestMethod = "POST"

                    DataOutputStream(conn.outputStream).use {
                        it.writeBytes(data.toString())
                        it.flush()
                    }

                    if (conn.responseCode in 200..299) {
                        launch(Dispatchers.Main) {
                            (requireActivity() as HomeActivity).showFragment(ForumFragment())
                        }
                    } else {
                        val res = conn.errorStream.bufferedReader().readText()
                        launch(Dispatchers.Main) {
                            Toast.makeText(requireContext(), "Subject and Body must be at least 10 chars long", Toast.LENGTH_SHORT).show()
                        }
                    }
                }
            }
        }

        return binding.root
    }
}