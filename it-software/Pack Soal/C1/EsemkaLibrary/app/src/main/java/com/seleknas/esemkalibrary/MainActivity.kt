package com.seleknas.esemkalibrary

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import com.seleknas.esemkalibrary.databinding.ActivityMainBinding
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
        binding.emailEt.setText("iclarricoates3@clickbank.net")
        binding.passwordEt.setText("fTa9aI71rEm")

        binding.signupBtn.setOnClickListener {
            startActivity(Intent(this, RegisterActivity::class.java))
        }

        binding.loginBtn.setOnClickListener {
            val data = JSONObject().apply {
                put("email", binding.emailEt.text.toString())
                put("password", binding.passwordEt.text.toString())
            }

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/api/Auth").openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.doOutput = true
                conn.setRequestProperty("Content-Type", "application/json")


                conn.outputStream.write(data.toString().toByteArray())

                val isSuccess = conn.responseCode in 200..299

                if (isSuccess) {
                    val dt = JSONObject(conn.inputStream.bufferedReader().readText())
                    getSharedPreferences("ESEMKALIBRARY", Context.MODE_PRIVATE).apply {
                        edit().apply {
                            putString("token", dt.getString("token"))
                        }.apply()
                    }
                    runOnUiThread {
                        Intent(this@MainActivity, HomeActivity::class.java).apply {
                            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                        }.let {
                            startActivity(it)
                        }
                    }
                } else {
                    val res = conn.errorStream.bufferedReader().readText()
                    Log.d("RESPONSE", "onCreate: $res")
                    runOnUiThread {
                        Toast.makeText(this@MainActivity, "Login Failed", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }
}