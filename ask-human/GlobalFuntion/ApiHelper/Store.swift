//
//  Store.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation
import UIKit

class Store {

    class var hashtagForSearchUser: [String]?{
        set{
            Store.saveValue(newValue, .hashtagForSearchUser)
        }get{
            return Store.getValue(.hashtagForSearchUser) as? [String]
        }
    }
    class var Hashtags:ProfileDetailModel? {
        set{
            Store.saveUserDetails(newValue, .Hashtags)
        }
        get{
            return Store.getUserDetails(.Hashtags)
        }
        }
    class var DarkMode: Int?{
        set{
            Store.saveValue(newValue, .DarkMode)
        }get{
            return Store.getValue(.DarkMode) as? Int
        }
    }

    class var userIdRefer: String?{
        set{
            Store.saveValue(newValue, .userIdRefer)
        }get{
            return Store.getValue(.userIdRefer) as? String
        }
    }
    class var notifyCount: Int?{
        set{
            Store.saveValue(newValue, .notifyCount)
        }
        get{
            return Store.getValue(.notifyCount) as? Int ?? 0
        }
    }

    class var isRefer: Bool?{
        set{
            Store.saveValue(newValue, .isRefer)
        }
        get{
            return Store.getValue(.isRefer) as? Bool
        }
    }
    class var openSiri: Bool?{
        set{
            Store.saveValue(newValue, .openSiri)
        }
        get{
            return Store.getValue(.openSiri) as? Bool  ?? false
        }
    }
    class var openUrl: String?{
        set{
            Store.saveValue(newValue, .openUrl)
        }
        get{
            return Store.getValue(.openUrl) as? String  ?? ""
        }
    }
    class var addUser: Bool?{
        set{
            Store.saveValue(newValue, .addUser)
        }
        get{
            return Store.getValue(.addUser) as? Bool ?? false
        }
    }
    
    class var filterAgeSelect: [String:Any]?{
        set{
            Store.saveValue(newValue, .filterAgeSelect)
        }
        get{
            return Store.getValue(.filterAgeSelect) as? [String:Any] ?? [:]
        }
    }
    class var getMessageData: [ChatModel]?{
        set{
            Store.saveUserDetails(newValue, .getMessageData)
        }
        get{
            return Store.getUserDetails(.getMessageData)
        }
    }
    class var getNotificationData: [Notificationss]?{
        set{
            Store.saveUserDetails(newValue, .getNotificationData)
        }
        get{
            return Store.getUserDetails(.getNotificationData)
        }
    }
    
    class var storeNotificationData: Bool?{
        set{
            Store.saveValue(newValue, .storeNotificationData)
        }
        get{
            return Store.getValue(.storeNotificationData) as? Bool ?? false
        }
    }
    
    class var filterDetail: [String:[String]]?{
        set{
            Store.saveValue(newValue, .filterDetail)
        }get{
            return Store.getValue(.filterDetail) as? [String:[String]] ?? [:]
        }
    }
 
    class var selectFilter: [[String:Any]]?{
        set{
            Store.saveValue(newValue, .selectFilter)
        }get{
            return Store.getValue(.selectFilter) as? [[String:Any]] 
        }
    }
    
    class var selectReferData: [String:Any]?{
        set{
            Store.saveValue(newValue, .selectReferData)
        }get{
            return Store.getValue(.selectReferData) as? [String:Any]
        }
    }
    
    class var selectTabIndex: Int?{
        set{
            Store.saveValue(newValue, .selectTabIndex)
        }
        get{
            return Store.getValue(.selectTabIndex) as? Int
        }
    }
    class var notificationCount: Int?{
        set{
            Store.saveValue(newValue, .notificationCount)
        }
        get{
            return Store.getValue(.notificationCount) as? Int ?? 0
        }
    }
    class var totalEarning: Int?{
        set{
            Store.saveValue(newValue, .totalEarning)
        }
        get{
            return Store.getValue(.totalEarning) as? Int ?? 0
        }
    }
    class var isSocialLogin: Bool?{
        set{
            Store.saveValue(newValue, .isSocialLogin)
        }
        get{
            return Store.getValue(.isSocialLogin) as? Bool ?? false
        }
    }
    class var userDetail: [String:Any]?{
        set{
            Store.saveValue(newValue, .userDetail)
        }get{
            return Store.getValue(.userDetail) as? [String:Any] ?? [:]
        }
    }
    class var notesId: String?{
        set{
            Store.saveValue(newValue, .notesId)
        }get{
            return Store.getValue(.notesId) as? String
        }
    }
    class var autoLogin: String?{
        set{
            Store.saveValue(newValue, .autoLogin)
        }get{
            return Store.getValue(.autoLogin) as? String
        }
    }
    class var isComingDraft: Bool{
        set{
            Store.saveValue(newValue, .isComingDraft)
        }get{
            return Store.getValue(.isComingDraft) as? Bool ?? false
        }
    }
    class var isFilterAge: Bool{
        set{
            Store.saveValue(newValue, .isFilterAge)
        }get{
            return Store.getValue(.isFilterAge) as? Bool ?? false
        }
    }
  
    class var authKey: String?{
        set{
            Store.saveValue(newValue, .authKey)
        }get{
            return Store.getValue(.authKey) as? String
        }
    }
  
  
    class var deviceToken: String?{
        set{
            Store.saveValue(newValue, .deviceToken)
        }
        get{
            return Store.getValue(.deviceToken) as? String
        }
    }
    
    class var comingOtp: Int?{
        set{
            Store.saveValue(newValue, .comingOtp)
        }
        get{
            return Store.getValue(.comingOtp) as? Int
        }
    }
    static var remove: DefaultKeys!{
        didSet{
            Store.removeKey(remove)
        }
    }
    
    //MARK:-  Private Functions
    
    private class func removeKey(_ key: DefaultKeys){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        if key == .userDetails{
            UserDefaults.standard.removeObject(forKey: DefaultKeys.authKey.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
    
    private class func saveValue(_ value: Any? ,_ key:DefaultKeys){
        var data: Data?
        if let value = value{
//            data = NSKeyedArchiver.archivedData(withRootObject: value)
            data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
        }
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    
 
    
    private class func saveUserDetails<T: Codable>(_ value: T?, _ key: DefaultKeys){
        var data: Data?
        if let value = value{
            data = try? PropertyListEncoder().encode(value)
        }
        Store.saveValue(data, key)
    }
    
    private class func getUserDetails<T: Codable>(_ key: DefaultKeys) -> T?{
        if let data = self.getValue(key) as? Data{
            let loginModel = try? PropertyListDecoder().decode(T.self, from: data)
            return loginModel
        }
        return nil
    }
    
    private class func getValue(_ key: DefaultKeys) -> Any{
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
            if let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            {
                return value
            }
            else{
                return ""
            }
        }else{
            return ""
        }
    }
}
