package com.nscspl.mbanking.hpscb

import android.content.Context
import android.provider.Settings
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val USB_DEBUGGING_CHANNEL = "com.nscspl.mbanking.hpscb.usb_debugging_detection/debugging"
    private val SUSPICIOUS_APPS_CHANNEL = "com.nscspl.mbanking.hpscb/suspicious_apps"
    private val SECURE_SCREEN_CHANNEL = "com.nscspl.mbanking.hpscb.securescreen"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // USB Debugging Detection Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, USB_DEBUGGING_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "isUsbDebuggingEnabled") {
                    val isEnabled = isUsbDebuggingEnabled()
                    result.success(isEnabled)
                } else {
                    result.notImplemented()
                }
            }

        // Suspicious Apps Detection Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SUSPICIOUS_APPS_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getInstalledApps") {
                    val apps = getInstalledApps()
                    result.success(apps)
                } else {
                    result.notImplemented()
                }
            }

        // Secure Screen Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SECURE_SCREEN_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enableSecureScreen" -> {
                        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(null)
                    }
                    "disableSecureScreen" -> {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun isUsbDebuggingEnabled(): Boolean {
        return Settings.Secure.getInt(contentResolver, Settings.Secure.ADB_ENABLED, 0) == 1
    }

    private fun getInstalledApps(): List<String> {
        val packageManager: PackageManager = packageManager
        val packages: List<PackageInfo> = packageManager.getInstalledPackages(0)
        return packages.map { it.packageName }
    }
}
