package com.seleknas.esemkalibrary

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayout.OnTabSelectedListener
import com.seleknas.esemkalibrary.databinding.ActivityHomeBinding
import com.seleknas.esemkalibrary.databinding.FragmentHomeBinding

class HomeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityHomeBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        supportFragmentManager
            .beginTransaction()
            .replace(binding.containerFl.id, HomeFragment())
            .commit()

        val menus = listOf("Home", "Forum", "My Cart", "My Profile")
        for (menu in menus) {
           val tab = binding.tablayout.newTab()
           tab.text = menu
           binding.tablayout.addTab(tab)
        }

        binding.tablayout.addOnTabSelectedListener(object : OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab?) {
                tab?.let {
                    when (it.text) {
                        "Home" -> {
                            supportFragmentManager
                                .beginTransaction()
                                .replace(binding.containerFl.id, HomeFragment())
                                .commit()
                        }
                        "Forum" -> {
                            supportFragmentManager
                                .beginTransaction()
                                .replace(binding.containerFl.id, ForumFragment())
                                .commit()
                        }
                        "My Cart" -> {
                            supportFragmentManager
                                .beginTransaction()
                                .replace(binding.containerFl.id, CartFragment())
                                .commit()
                        }
                        "My Profile" -> {
                            supportFragmentManager
                                .beginTransaction()
                                .replace(binding.containerFl.id, ProfileFragment())
                                .commit()
                        }

                        else -> {}
                    }
                }
            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {
            }

            override fun onTabReselected(tab: TabLayout.Tab?) {
            }
        });
    }

    fun showFragment(fragment: Fragment) {
        supportFragmentManager
            .beginTransaction()
            .replace(binding.containerFl.id, fragment)
            .commit()
    }
}