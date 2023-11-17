package com.example.diwali_rnd

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val methodChannelName = "com.example.diwali_rnd/methodChannel"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "askForPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        val intent = Intent(
                            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                            Uri.parse("package:" + BuildConfig.APPLICATION_ID)
                        )
                        startActivityForResult(intent, 2990)
                    }
                    result.success("success");
                }

                "goToNextActivity" -> {
                    val intent = Intent(applicationContext, NativeActivity::class.java)
                    startActivity(intent)
                    result.success("success");
                }

                "startApp" -> {
                    Log.d("App Start", "Data")
                    val intent = Intent(applicationContext, MainActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
                    startActivity(intent)
                    result.success("success");
                }
            }
        }
    }

}
