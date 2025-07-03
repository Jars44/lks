package com.seleknas.tiks09

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import com.seleknas.tiks09.databinding.ActivityMainBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.io.DataOutputStream
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        binding.email.setText("alice.johnson@example.com")
        binding.password.setText("password123")

        binding.loginBtn.setOnClickListener {
            val data = JSONObject().apply {
                put("email", binding.email.text.toString())
                put("password", binding.password.text.toString())
            }

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("${Constant.URL}/Login").openConnection() as HttpURLConnection
                conn.setRequestProperty("Content-Type", "application/json")
                conn.requestMethod = "POST"
                conn.doOutput = true

                DataOutputStream(conn.outputStream).use {
                    it.writeBytes(data.toString())
                    it.flush()
                }

                if (conn.responseCode in 200..299) {
                    val data = JSONObject(conn.inputStream.bufferedReader().readText())
                    Constant.User = data.getInt("id")
                    runOnUiThread {
                        startActivity(Intent(this@MainActivity, HomeActivity::class.java))
                    }
                } else {
                    runOnUiThread {
                        Toast.makeText(this@MainActivity, "Email or Password is not correct", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }
}