//
//  AppDelegate.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignInSwift
import FirebaseMessaging
import NotificationCenter
import Firebase
import Intents



@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var notificationDelegate = UserNotifcations()
 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        GoogleSignIn.shared.clientId = "64784249708-7vs00q0h5ds78f0tnmsgvm4ri5hged3n.apps.googleusercontent.com"
        configureNotification()
        SetMode()
      
     
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("Received userActivity: \(userActivity)")
        if let interaction = userActivity.interaction, let intent = interaction.intent as? INSendMessageIntent {
            // Handle the intent
            let intentHandler = SendMessageIntentHandler()
            intentHandler.handle(intent: intent) { response in
                print("Response--------", response)
                Store.openUrl = "adadaerwtetetetertew5t"
            }
         
    
        }
        return false
    }


    func SetMode() {
        if Store.DarkMode == 0{
            applyUserInterfaceStyle(.dark)
            
            
        } else if Store.DarkMode == 1{
            applyUserInterfaceStyle(.light)
            
            
        }else{
            applyUserInterfaceStyle(.unspecified)
            
        }
    }
    func applyUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        window.overrideUserInterfaceStyle = style
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
   
        Messaging.messaging().apnsToken = deviceToken
        if let token = Messaging.messaging().fcmToken {
            print("APNs fcm token: \(token)")
        }
        

    }
 
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.alert, .sound, .badge]){ (granted, error) in }
            center.delegate = notificationDelegate
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
        
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("APNs fcm token-----: \(fcmToken ?? "")")
     
        Store.deviceToken = fcmToken
    }
}
