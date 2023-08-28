package net.archive.qa

import com.salesforce.flutter.ui.SalesforceFlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.EventChannel

class MainActivity : SalesforceFlutterActivity() , EventChannel.StreamHandler{
    private var messageChannel: EventChannel? = null
    private var eventSink: EventChannel.EventSink? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        messageChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "authSF")
        messageChannel?.setStreamHandler(this)
    }
    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
    override fun onResume() {
        super.onResume()
        eventSink?.success("authSuccess")
    }
}