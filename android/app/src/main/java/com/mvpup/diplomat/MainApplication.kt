package com.mvpup.***REMOVED***

import com.salesforce.androidsdk.app.SalesforceSDKManager
import com.salesforce.androidsdk.rest.ClientManager
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.EventChannel

class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        SalesforceSDKManager.initNative(applicationContext, MainActivity::class.java)
    }
}