package com.example.diwali_rnd

import android.app.Activity
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class NativeActivity : Activity() {

    private lateinit var goToFlutterButton: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)

        goToFlutterButton = findViewById(R.id.back_to_flutter)
        goToFlutterButton.setOnClickListener {
            finish()
        }
    }
}