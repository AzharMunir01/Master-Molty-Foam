package molty.com.molty

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
//import android.Manifest
//import android.content.Intent
//import android.content.pm.PackageManager
//import android.net.Uri
//import android.os.Bundle
//import android.util.Log
//import androidx.core.content.ContextCompat
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel

//class MainActivity : FlutterActivity()
//{
//    private val CHANNEL = "molty.com.molty/channel"
//    private val REQUEST_CODE_PERMISSIONS = 1001
//    private val REQUIRED_PERMISSIONS = arrayOf(
//        Manifest.permission.RECORD_AUDIO,
//        Manifest.permission.WRITE_EXTERNAL_STORAGE,
//        Manifest.permission.READ_EXTERNAL_STORAGE,
//        Manifest.permission.CALL_PHONE,
//        Manifest.permission.BIND_ACCESSIBILITY_SERVICE
//    )
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        if (allPermissionsGranted()) {
//            // Permissions are already granted, proceed
//        } else {
//            androidx.core.app.ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, REQUEST_CODE_PERMISSIONS)
//        }
//    }
//
//    private fun allPermissionsGranted() = REQUIRED_PERMISSIONS.all {
//        ContextCompat.checkSelfPermission(baseContext, it) == PackageManager.PERMISSION_GRANTED
//    }
//
//    override fun onRequestPermissionsResult(
//        requestCode: Int,
//        permissions: Array<out String>,
//        grantResults: IntArray
//    ) {
//        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
//        if (requestCode == REQUEST_CODE_PERMISSIONS) {
//            if (allPermissionsGranted()) {
//                // Permissions are granted
//            } else {
//                // Handle the case where permissions are not granted
//            }
//        }
//    }
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            when (call.method) {
//                "openDialerAndRecord" -> {
//                    val phoneNumber = call.arguments<String>()
//                    if (phoneNumber != null) {
//                        openDialerAndRecord(phoneNumber) { callbackResult ->
//                            result.success(callbackResult)}
//                    }
//                    result.success(audioPath)
//                }
//                else -> result.notImplemented()
//            }
//        }
//    }
////    .ACTION_CALL
//    private fun openDialerAndRecord(phoneNumber: String, callback: (String) -> Unit) {
//        Log.d("here","working");
//        var check = allPermissionsGranted()
//        if (true) {
//            val intent = Intent(Intent.ACTION_DIAL).apply {
//                data = Uri.parse("tel:")
////                data = Uri.parse("tel:$phoneNumber")
//            }
//            if (androidx.core.app.ActivityCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED) {
//                startActivity(intent)
//                startCallRecordingService()
//                callback(audioPath)
//            }
//        } else {
//            androidx.core.app.ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, REQUEST_CODE_PERMISSIONS)
//        }
//    }
//
//    private fun startCallRecordingService() {
//        val intent = Intent(this, CallRecordingService::class.java)
//        startService(intent)
//    }
//}
