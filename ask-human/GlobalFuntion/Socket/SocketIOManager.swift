//
//  SocketIOManager.swift
//  ask-human
//
//  Created by meet sharma on 19/01/24.
//



import Foundation
import SocketIO

class WebSocketManager {
    
    //MARK: - VARIABLES
    
    static let shared = WebSocketManager()
    private var manager: SocketManager?
    var socket: SocketIOClient?
    private var userId: String = ""
    var chatData: (([ChatModel]?)->())?
    var userListnerSuccess: (()->())?
    var inboxList: (([GetRealTimeMsgModel]?)->())?
    var notificationCount: (([GetNotificationCountModel]?)->())?
    
    private init() {}
    
    func initialize(userId: String) {
        if socket != nil {
            print("WebSocketManager: Socket already initialized.")
            return
        }
        
        self.userId = userId
        
        let urlString = socketKeys.socketBaseUrl.instance
        print("WebSocketManager: Socket disconnected and reset \(urlString)")
        guard let url = URL(string: urlString) else {
            print("WebSocketManager: Invalid URL format.")
            return
        }
        
        manager = SocketManager(socketURL: url, config: [.log(true), .forceNew(true)])
        socket = manager?.defaultSocket
        
        socket?.on(clientEvent: .connect) { [weak self] data, ack in
            guard let self = self else { return }
            print("WebSocketManager: Connected to the socket server \(self.userId)")
            self.socket?.emit("addUser", self.userId)
        }
        
        socket?.on(clientEvent: .disconnect) { data, ack in
            print("WebSocketManager: Disconnected from the socket server")
        }
        
        socket?.on(clientEvent: .error) { data, ack in
            let errorDescription = data.map { "\($0)" }.joined(separator: ", ")
            print("WebSocketManager: Connection error: \(errorDescription)")
        }
        socket?.on(socketListeners.messageListListener.instance) { (data, emitter) in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let messages = try JSONDecoder().decode([ChatModel].self, from: jsonData)
                self.chatData?(messages)
                
            } catch {
                print("Error decoding message: \(error)")
            }
            print("GetMessageListener")
        }
        
        socket?.on(socketListeners.getUserRealtimeMsgListener.instance) { (data, emitter) in
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let usersList = try JSONDecoder().decode([GetRealTimeMsgModel].self, from: jsonData)
                self.inboxList?(usersList)
                
                if showChat == true{
                    NotificationCenter.default.post(name: Notification.Name("getChat"), object: nil)
                }
                showChat = false
            } catch {
                print("Error decoding message: \(error)")
            }
            
            print("GetRealTimeMessage")
        }
        
        socket?.on(socketListeners.getNotifcationCountListener.instance) { (data, emitter) in
            print("getNotifcationCountListener data received: \(data)")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let notification = try JSONDecoder().decode([GetNotificationCountModel].self, from: jsonData)
                self.notificationCount?(notification)
                
                
            } catch {
                print("Error decoding notification count: \(error)")
            }
            print("Get notification count listener")
        }
        
        socket?.on(socketListeners.sendMessageListener.instance) { (data, emitter) in
            showChat = false
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let messages = try JSONDecoder().decode([ChatModel].self, from: jsonData)
                print("MEssage-----",messages)
                
            } catch {
                print("Error decoding message: \(error)")
            }
            self.userListnerSuccess?()
            //            NotificationCenter.default.post(name: Notification.Name("getChat"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("sendMessageListener"), object: nil)
            print("SendMessageListener")
        }
        
        socket?.on(socketListeners.addMediaListener.instance) { (data, emitter) in
            showChat = false
            //            NotificationCenter.default.post(name: Notification.Name("getChat"), object: nil)
            self.userListnerSuccess?()
            NotificationCenter.default.post(name: Notification.Name("sendMessageListener"), object: nil)
            print("AddMediaListener")
        }
        
        socket?.on(socketListeners.addUser.instance) { (data, emitter) in
            Store.addUser = true
            DispatchQueue.main.asyncAfter(deadline: .now()){
                NotificationCenter.default.post(name: Notification.Name("sendMessageListener"), object: nil)
            }
            
            print("addUser Listener")
        }
        
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
        socket = nil
        print("WebSocketManager: Socket disconnected and reset")
    }
    
    // Add more methods as needed, like handling specific events
}


// MARK: - Custom functions
extension WebSocketManager {
    func getNotificationCount(dict: [String: Any]) {
        socket?.emit(socketEmitters.getNotifcationCount.instance, dict)
    }
    
    func getUserList(dict: [String: Any]) {
        socket?.emit(socketEmitters.getUserRealtimeMessages.instance, dict)
        
    }
    
    func getChatListing(dict: [String: Any]) {
        
        socket?.emit(socketEmitters.messageList.instance, dict)
        
    }
    
    func sendMessage(dict: [String: Any]) {
        socket?.emit(socketEmitters.sendMessage.instance, dict)
    }
    
    func sendImgVideo(dict: [String: String]) {
        socket?.emit(socketEmitters.eventVideo.instance, dict)
    }
    
    func addUser(dict: String) {
        print(dict)
        socket?.emit(socketEmitters.addUser.instance, dict)
        
    }
    
    func joinRoom(dict: [String: Any]) {
        socket?.emit(socketEmitters.joinroom.instance, dict)
    }
    
    func addFav(dict: [String: Any]) {
        socket?.emit(socketEmitters.addFav.instance, dict)
    }
    
    func deleteChat(dict: [String: Any]) {
        socket?.emit(socketEmitters.deleteChat.instance, dict)
    }
}
