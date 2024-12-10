//
//  SocketConstant.swift
//  ask-human
//
//  Created by meet sharma on 19/01/24.
//

import Foundation


import Foundation

enum socketKeys : String {
//    case socketBaseUrl = "http://3.144.134.55:8081"
//    case socketBaseUrl = "http://3.14.81.244:8081"
//    case socketBaseUrl = "http://18.217.10.216:8081"
//    case socketBaseUrl = "http://13.59.239.2:8081"
    case socketBaseUrl = "https://ws.askhuman.ai"
    var instance : String {
        return self.rawValue
    }
}
enum socketEmitters:String {
    //MARK: EMITTERS
    case sendMessage = "message"
    case messageList = "getMessage"
    case imageUpload = "imageUpload"
    case eventVideo = "addMedia"
    case addUser = "addUser"
    case joinroom = "joinRoom"
    case getUserRealtimeMessages = "getUserRealtimeMessages"
    case getNotifcationCount = "getNotifcationCount"
    case addFav = "favoriteBy"
    case deleteChat = "deletedBy"
    var instance : String {
        return self.rawValue
    }
}
enum socketListeners : String{
    //MARK: - LISTNER
    case messageListListener = "getMessage"
    case sendMessageListener = "message"
    case addMediaListener = "addMedia"
    case imageUploadListener = "imageUpload"
    case getUserRealtimeMsgListener = "getUserRealtimeMessages"
    case getNotifcationCountListener = "getNotifcationCount"
    case addFavListener = "favoriteBy"
    case deleteChatListener = "deletedBy"
    case addUser = "addUser"
    var instance : String {
        return self.rawValue
    }
}

