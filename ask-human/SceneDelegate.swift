//
//  SceneDelegate.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit
import SocketIO
import Intents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
  
    var bgTask: UIBackgroundTaskIdentifier = .invalid
    var wasOpenedBySiri = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
        Store.isComingDraft = false
        if Store.userDetail?["userId"] as? String ?? "" != ""{
            WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
        }
//        requestSiriAuthorization()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
      
    }
    
    func requestSiriAuthorization() {
        INPreferences.requestSiriAuthorization { status in
            if status == .authorized {
                print("Siri is authorized")
            } else {
                print("Siri is not authorized")
            }
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity)  {
        print("Received userActivity: \(userActivity)")
        if let interaction = userActivity.interaction, let intent = interaction.intent as? INSendMessageIntent {
            // Handle the intent
            let intentHandler = SendMessageIntentHandler()
            intentHandler.handle(intent: intent) { response in
                print("Response--------", response)
                Store.openUrl = "adadaerwtetetetertew5t"
            }
            wasOpenedBySiri = true // Set flag to true
    
        }
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let myObject = notification.object {
              print("Received object value: \(myObject)")
            DispatchQueue.main.asyncAfter(deadline: .now()){
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let rootViewController = UIApplication.shared.windows.first?.rootViewController
                rootViewController?.dismiss(animated: false)
                   if let vcPop = mainStoryboard.instantiateViewController(withIdentifier: "ResponsePopUpVC") as? ResponsePopUpVC {
                       vcPop.modalPresentationStyle = .overFullScreen
                       vcPop.message = myObject as? String ?? ""
                       rootViewController?.present(vcPop, animated: false, completion: nil)
                   }
            }
          } else {
              print("No object value found in the notification")
          }
    }
 

    func sceneDidDisconnect(_ scene: UIScene) {
        print("Resign Dissconnect")
        Store.addUser = false
        WebSocketManager.shared.disconnect()

        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
           print("Will Enter Foreground")
       
       }
   
    func sceneDidBecomeActive(_ scene: UIScene) {
   
        if  Store.authKey != "" {
//            SocketIOManager.sharedInstance.connectMySocket()
            AppDelegate().configureNotification()
           
         }
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Resign Active")
        
       
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Resign Did Enter")
        
      
    }
    func chatScreenVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }

    func tabBarProfileVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        Store.selectTabIndex = 2
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func verifiedVCRootToHome(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "IdVerifiedVC") as! IdVerifiedVC
        nextVC.isComing = true
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func verifiedVCRootToProfile(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "IdVerifiedVC") as! IdVerifiedVC
        nextVC.isComing = false
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }

    func loginConfirmVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginConfirmVC") as! LoginConfirmVC
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func UserListVCRootisReferFalse(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
        Store.isRefer = false
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func SearchNoteVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchNoteVC") as! SearchNoteVC
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func tabBarHomeVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        Store.selectTabIndex = 1
        nextVC.isComing = false
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func loginVCRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func userListRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        nextVC.isComing = true
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func notificationsRoot(selectTab:Int){
        isReload = true
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        Store.selectTabIndex = selectTab
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func userListRootneww(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
        
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    func userListBackRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        nextVC.isComing = true
        let nav = UINavigationController.init(rootViewController: nextVC)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
  
          }
          
    
      
import UIKit

extension UIWindow {

    func showAlert(title: String, message: String) {
        guard let rootViewController = self.rootViewController else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.backgroundColor = .red
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
