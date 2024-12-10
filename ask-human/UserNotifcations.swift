//
//  UserNotifcations.swift
//  ask-human
//
//  Created by meet sharma on 13/03/24.
//

import Foundation
import UserNotifications
import UserNotificationsUI
import CoreLocation

class UserNotifcations: NSObject , UNUserNotificationCenterDelegate {
    var window: UIWindow?
    var timer: Timer?
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        NotificationCenter.default.post(name: Notification.Name("GetNotificationCount"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("sendMessageListener"), object: nil)
        completionHandler([.alert,.sound, .badge])
    }
    
    @available(iOS 10.0, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
       print("did Receive----")
            let userInfo = response.notification.request.content.userInfo
           
            print("userInfo:--\(userInfo)")
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
            didRecieveBackgroundPushNotificaion(response: response)
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        completionHandler()
    }
   

    private  func didRecieveBackgroundPushNotificaion(response: UNNotificationResponse){

        let userInfo = response.notification.request.content.userInfo
        let apsDict = userInfo["aps"] as? NSDictionary
        let alert = apsDict?["alert"] as? NSDictionary
        let type = userInfo["type"] as? String ?? ""
        let messageIds = userInfo["messageId"] as? String
        let notesId = userInfo["notesId"] as? String
        let notificationId = userInfo["notificationId"] as? String
        print("userInfo:--\(userInfo)")
        
        if type == "1"{
            
            
            let topController = UIApplication.topViewController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: ChatScreenVC = storyboard.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
            vc.messageId = messageIds ?? ""
            vc.notesId = notesId ?? ""
            vc.notificationId = notificationId ?? ""
            vc.isComingDispute = "Notification"
            vc.hidesBottomBarWhenPushed = false
            vc.tabBarController?.selectedIndex = 2
            topController?.navigationController?.pushViewController(vc, animated: true)
        }else if type == "3"{
            let topController = UIApplication.topViewController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: ContractDetailVC = storyboard.instantiateViewController(withIdentifier: "ContractDetailVC") as! ContractDetailVC
            vc.isComingNotification = false
            vc.messageId = messageIds ?? ""
            vc.hidesBottomBarWhenPushed = false
        
            topController?.navigationController?.pushViewController(vc, animated: true)
        
        }else{
           SceneDelegate().tabBarHomeVCRoot()
        }
       
        print(userInfo)
    }
  
    func getCityNameFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (_ city:String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion("")
            } else if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    completion(city)
                } else {
                    print("City not found for the given coordinates.")
                    completion("")
                }
            } else {
                print("No placemarks found for the given coordinates.")
                completion("")
            }
        }
    }
}



