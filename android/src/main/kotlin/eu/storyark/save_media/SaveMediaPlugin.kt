package eu.storyark.save_media

import android.annotation.TargetApi
import android.content.ContentValues
import android.content.Context
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.io.File
import java.io.FileOutputStream
import java.net.URL

class SaveMediaPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "save_media")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.getApplicationContext()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "saveMediaAssets") {
            val paths = (call.arguments as List<Map<String, Any>>)
                .map {
                    File(it["filePath"] as String)
                } as Iterable<File>

            paths.forEach {
                if (context.getVersionCode() < Build.VERSION_CODES.Q) {
                    saveFileToExternalStorage(it)
                } else {
                    saveFileUsingMediaStore(it)
                }
            }
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun saveFileToExternalStorage(file: File) {
        val target = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
            file.name
        )
        URL(file.toURI().toString()).openStream().use { input ->
            FileOutputStream(target).use { output ->
                input.copyTo(output)
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.Q)
    private fun saveFileUsingMediaStore(file: File) {
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, file.name)
            put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
        }
        val resolver = context.contentResolver
        val downloadsUri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)
        if (downloadsUri != null) {
            file.toURI().toURL().openStream().use { input ->
                resolver.openOutputStream(downloadsUri).use { output ->
                    input.copyTo(output!!, DEFAULT_BUFFER_SIZE)
                }
            }
        }
    }
}

fun Context.getVersionCode(): Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
    packageManager.getPackageInfo(packageName, 0).longVersionCode.toInt()
} else {
    packageManager.getPackageInfo(packageName, 0).versionCode
}
