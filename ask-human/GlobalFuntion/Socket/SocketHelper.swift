//
//  SocketHelper.swift
//  ask-human
//
//  Created by meet sharma on 27/02/24.
//


//import UIKit
//import Foundation
//import SocketIO
//let kHost = "http://3.14.81.244:8081"
//let kConnectUser = "connectUser"
//let kUserList = "userList"
//let kExitUser = "exitUser"
//class SocketHelper {
//    static let shared = SocketHelper()
//    static var socket: SocketIOClient!
//    let manager = SocketManager(socketURL: URL(string: "http://3.144.134.55:8081")!, config: [.log(true), .compress, .forceNew(true), .forcePolling(false), .reconnects(true)])
//    private init() {
//       
//        SocketHelper.socket = manager.defaultSocket
//    }
//    func connectSocket(completion: @escaping(Bool) -> ()) {
//        disconnectSocket()
//        SocketHelper.socket.on(clientEvent: .connect) { [weak self] (data, ack) in
//            print("socket connected")
//            SocketHelper.socket.removeAllHandlers()
//            completion(true)
//        }
//        // Check if the socket is connected before emitting events
//        if SocketHelper.socket.status == .connected {
//            SocketHelper.socket.on("getMessageList") { [weak self] (data, ack) in
//                print("get message Listener")
//                // Handle the data received from the server
//            }
//        } else {
//            // Handle the case when the socket is not connected
//            print("Socket is not connected.")
//        }
//        SocketHelper.socket.connect()
//    }
//    func disconnectSocket() {
//        SocketHelper.socket.removeAllHandlers()
//        SocketHelper.socket.disconnect()
//        print("socket Disconnected")
//    }
//    func checkConnection() -> Bool {
//        if SocketHelper.socket.manager?.status == .connected {
//            return true
//        }
//        return false
//    }
//    func getChatListing(dict: String) {
//     
//            SocketHelper.socket.emit(socketEmitters.messageList.instance, dict)
//            print("Socket Status: ",SocketHelper.socket.status)
// 
//    }
//}
//
//
//
