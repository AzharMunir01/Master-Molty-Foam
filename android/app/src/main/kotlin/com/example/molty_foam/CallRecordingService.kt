//package molty.com.molty
//
//import android.accessibilityservice.AccessibilityService
//import android.content.Context
//import android.media.AudioManager
//import android.media.MediaRecorder
//import android.os.Environment
//import android.util.Log
//import android.view.accessibility.AccessibilityEvent
//import android.widget.Toast
//import androidx.core.content.PackageManagerCompat.LOG_TAG
//import java.io.File
//import java.text.SimpleDateFormat
//import java.util.*
//
//var audioPath="";
//class CallRecordingService : AccessibilityService() {
//    private var recorder: MediaRecorder? = null
//    private var isRecording = false
//    private lateinit  var audioManager: AudioManager
//
//    override fun onCreate() {
//        super.onCreate()
//        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
//    }
//
//    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
//        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
//            val className = event.className?.toString()
//            if (className != null && (className.contains("com.android.dialer") || className
//                    .contains("com.samsung.android.incallui") || className.contains("com.android.incallui.InCallActivity"))) {
//                // Dialer or in-call UI is active
//                if (!isRecording) {
//                    startRecording()
//                }
//            } else {
//                // Not in dialer or in-call UI
//                if (isRecording) {
//                    stopRecording()
//                }
//            }
//        }
//    }
//
//    override fun onInterrupt() {
//        // Handle interruption
//    }
//
///*    private fun startRecording() {
//        val path = "/storage/emulated/0/Download"
//        Log.d("path",path.toString())
//        val directory = File(path)
//        if (!directory.exists()) {
//            directory.mkdirs()
//        }
//        val fileName = "CallRecording_${SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())}.mp3"
//        val filePath = "$path/$fileName"
//
//        Log.d("filepath",filePath.toString())
//
//
//        recorder = MediaRecorder().apply {
//            setAudioSource(MediaRecorder.AudioSource.VOICE_COMMUNICATION)
//            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
//            setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
//            setOutputFile(filePath)
//            prepare()
//            start()
//        }
//
//        isRecording = true
//        Toast.makeText(this, "Call recording started", Toast.LENGTH_SHORT).show()
//    }*/
//
//
//    private fun startRecording() {
//        val path = "${Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)?.absolutePath}/molty"
//
//        Log.d("Initialpath",path.toString())
//        Log.d("Initialpath",path.toString())
//        Log.d("Initialpath",path.toString())
//        Log.d("Initialpath",path.toString())
//        Log.d("Initialpath",path.toString())
//        Log.d("Initialpath",path.toString())
//
//
////        path = "/storage/emulated/0/Download/molty";
//        val directory = File(path)
//        if (!directory.exists()) {
//            directory.mkdirs()
//        }
//        val fileName = "CallRecording_${SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())}.mp3"
//        val filePath = "$path/$fileName"
//        audioPath=filePath
//        Log.d("filepath",filePath.toString())
//        recorder = MediaRecorder().apply {
//            setAudioSource(MediaRecorder.AudioSource.VOICE_COMMUNICATION)
//            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)  // Use MPEG-4 for MP3 compatibility
//            setAudioEncoder(MediaRecorder.AudioEncoder.AAC)     // Use AAC for MP3 encoding
//            setOutputFile(filePath)
//            prepare()
//            start()
//        }
//
//        isRecording = true
//        Toast.makeText(this, "Call recording started", Toast.LENGTH_SHORT).show()
//        enableSpeakerphone(true);
//
//    }
//
//
//    private fun stopRecording() {
//        recorder?.apply {
//            stop()
//            release()
//        }
//        recorder = null
//        isRecording = false
//        Toast.makeText(this, "Call recording stopped", Toast.LENGTH_SHORT).show()
//        enableSpeakerphone(false);
//    }
//
//    private fun enableSpeakerphone(enable: Boolean) {
//        if (audioManager != null) {
//            audioManager.mode = AudioManager.MODE_IN_CALL
//            audioManager.isSpeakerphoneOn = enable
//        }
//    }
//
//}
