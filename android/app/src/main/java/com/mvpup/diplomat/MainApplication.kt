package com.mvpup.***REMOVED***

import com.salesforce.androidsdk.app.SalesforceSDKManager
import com.salesforce.androidsdk.rest.ClientManager
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.EventChannel
import com.salesforce.androidsdk.push.PushNotificationInterface
import android.util.Log

class MainApplication : FlutterApplication() , PushNotificationInterface {

    override fun onCreate() {
        super.onCreate()
        SalesforceSDKManager.initNative(applicationContext, MainActivity::class.java)
        SalesforceSDKManager.getInstance().setPushNotificationReceiver(this)
    }
    override fun onPushMessageReceived(data: Map<String, String>) {
        Log.d("PUSH NOTY", data.toString())

    }
}