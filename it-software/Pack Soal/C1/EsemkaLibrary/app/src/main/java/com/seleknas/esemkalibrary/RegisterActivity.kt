package com.seleknas.esemkalibrary

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import com.seleknas.esemkalibrary.databinding.ActivityRegisterBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.io.DataOutputStream
import java.net.HttpURLConnection
import java.net.URL

class RegisterActivity : AppCompatActivity() {
    private lateinit var binding: ActivityRegisterBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        binding.signupBtn.setOnClickListener {
            val name = binding.nameEt.text.toString()
            val password = binding.passwordEt.text.toString()
            val confirmPassword = binding.confirmpwEt.text.toString()
            val email = binding.emailEt.text.toString()


            if (name.isEmpty()) {
                Toast.makeText(this, "Name is required", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }


            if (email.isEmpty()) {
                Toast.makeText(this, "Email is required", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (password.length < 8) {
                Toast.makeText(this, "Password must be at least 8 chars long", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (confirmPassword != password) {
                Toast.makeText(this, "Password confirmation failed", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }


            val data = JSONObject().apply {
                put("name", name)
                put("email", email)
                put("password", password)
            }

            lifecycleScope.launch(Dispatchers.IO) {
                val conn = URL("http://10.0.2.2:5000/Api/Users").openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.doOutput = true
                conn.setRequestProperty("Content-Type", "application/json")

                DataOutputStream(conn.outputStream).use {
                    it.writeBytes(data.toString())
                    it.flush()
                }


                if (conn.responseCode in 200..299) {
                    runOnUiThread {
                        startActivity(Intent(this@RegisterActivity, MainActivity::class.java))
                    }
                } else {
                    runOnUiThread {
                        Toast.makeText(this@RegisterActivity, "Register failed", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }
}