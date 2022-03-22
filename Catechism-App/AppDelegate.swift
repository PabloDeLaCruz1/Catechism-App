
// AppDelegate.swift
import UIKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    func isLoggedIn() -> Bool {
            let accessToken = AccessToken.current
            let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
            return isLoggedIn
        }
    
    //This method is called by iOS whenever a call to registerForRemoteNotifications() succeeds.
    //The code may look cryptic, but it’s simply taking a received deviceToken and converting it to a string.
    //The device token is the fruit of this process. It’s provided by APNs and uniquely identifies this app on this particular device.
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }
    //server uses tokens as “addresses” to deliver to the correct devices
    //Failed to register error. You can ignore on simulator
    //Later, when you run on a real device, you should receive a token in the console output.
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      print("Failed to register: \(error)")
    }
    
}

