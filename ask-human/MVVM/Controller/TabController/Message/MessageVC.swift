//
//  MessageVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//


import UIKit
import AVFoundation
import SocketIO
import AVKit
import IQKeyboardManagerSwift

enum ImageProcessingError: Error {
    case imageNotFound
}

enum VideoProcessingError: Error {
    case videoURLNotFound
}

class MessageVC: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    //MARK: - OUTLET
    
    @IBOutlet var heightTxtVwProposal: NSLayoutConstraint!
    @IBOutlet var txtVwProposal: UITextView!
    @IBOutlet var lblrejected: UILabel!
    @IBOutlet var widthUpdateHourSideBtn: NSLayoutConstraint!
    @IBOutlet var btnAppliedRequests: UIButton!
    
    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet weak var heightTblVw: NSLayoutConstraint!
    @IBOutlet var widthBtnMore: NSLayoutConstraint!
    @IBOutlet var btnViewProposal: UIButton!
    @IBOutlet var heightVIewFirst: NSLayoutConstraint!
    @IBOutlet var lblAcceptRejectStatus: UILabel!
    @IBOutlet var btnRejectProposal: UIButton!
    @IBOutlet var btnAcceptProposal: UIButton!
    @IBOutlet var heightStackVwAccepReject: NSLayoutConstraint!
    @IBOutlet var lblNameProposal: UILabel!
    @IBOutlet var lblDesciprionProposal: UILabel!
    @IBOutlet var imgVwUserProposal: UIImageView!
    @IBOutlet var viewReferSecond: UIView!
    @IBOutlet var viewReferFirst: UIView!
    @IBOutlet var heightReferView: NSLayoutConstraint!
    @IBOutlet var btnGallary: UIButton!
    @IBOutlet var btnRefer: UIButton!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var vwBtnAcceptReject: UIView!
    @IBOutlet weak var btnAccept: GradientButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var vwSendMessage: UIView!
    @IBOutlet weak var txtVwMessage: UITextView!
    @IBOutlet weak var tblVwMessage: UITableView!
    @IBOutlet weak var vwReferBy: UIView!
    @IBOutlet weak var lblReferName: UILabel!
    @IBOutlet weak var lblReferDescription: UILabel!
    @IBOutlet weak var heightReferVw: NSLayoutConstraint!
    @IBOutlet weak var imgVwRefer: UIImageView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var heightTimerVw: NSLayoutConstraint!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet var bottomView: NSLayoutConstraint!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet var vwContinueChat: UIView!
    @IBOutlet var btnCross: UIButton!
    @IBOutlet var stackVwRefer: UIStackView!
    @IBOutlet var vwUpdateHour: UIView!
    @IBOutlet var btnContinueChat: GradientButton!
    @IBOutlet var heightAcceptRejectVw: NSLayoutConstraint!
    @IBOutlet var btnUpdateHour: GradientButton!
    @IBOutlet var imgVwTick: UIImageView!
    
    var isComing = false
    var messageId = ""
    var viewModel = InvitationVM()
    var viewModelMessage = MessageVM()
    var isComingDispute = ""
    var chatData = [ChatModel]()
    var arrChat = [MessageListChat]()
    var param = [String:Any]()
    var receiverId = ""
    let imagePickerController = UIImagePickerController()
    var notificationId = ""
    var optionStatus = 1
    var receiverName = ""
    var receiverPrice = 0
    var currentTime = ""
    var endTime = ""
    var notesId = ""
    var refered = false
    var isSendingMessage = false
    var timer : Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    var todayDate = ""
    var yesterDayDate = ""
    var keyboardHeight: CGFloat = 0.0
    var connectSocket = false
    var viewModelRefer = ReferVM()
    var proposalUserId = ""
    var userHourPrice = 0
    var anotherUserPrice = 0
    var anotherUserName = ""
    var showProposal = false
    var firstTblHeight = CGFloat()
    var secondTblHeight = CGFloat()
    var isLoad = false
    var gradientLayer: CAGradientLayer?
    var sendMessageByMe:Bool = false
    var scrollTbl:Bool = false
    private var hasScrolledToBottom: Bool = false

    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
       uiSet()
    }
    func uiSet(){
      
        txtVwProposal.delegate = self
    
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
        tapGesture2.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture2)
        
        stackVwRefer.layer.cornerRadius = 5
       
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tblVwMessage.addGestureRecognizer(tapGesture)
        
        let date = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let todayDates = dateFormatter.string(from: date)
        let yesterdayDates = dateFormatter.string(from: yesterday)
        self.todayDate = todayDates
        self.yesterDayDate = yesterdayDates
        
        getSocketData()
        darkMode()
        keyboardHandling()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedGetChat(notification:)), name: Notification.Name("getChat"), object: nil)
    }
    
   

    
    func getSocketData(){
        showChat = true
        
        if  Store.authKey != "" {
            
            if  WebSocketManager.shared.socket?.status == .connected{
                self.socketData()
              
            }else{
                WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
                WebService.showLoader()
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                    WebService.hideLoader()
                    self.socketData()
                }
            }
            
        }
  
     
    }
    private func socketData(){
        
        if self.isComingDispute == "Dispute"{
            WebService.hideLoader()
          
            WebSocketManager.shared.joinRoom(dict: ["messageId":self.messageId])
            self.getChatListing(messageId: self.messageId, isRead: 1)
            self.getNewMessage()
            self.sendMessageData()
           
        }else if self.isComingDispute == "userList"{

            WebSocketManager.shared.joinRoom(dict: ["messageId":self.messageId])
          
            self.getChatListing(messageId: self.messageId, isRead: 1)
            self.getNewMessage()
            self.sendMessageData()
        }else if self.isComingDispute == "Notification"{
            WebService.hideLoader()
            if WebSocketManager.shared.socket?.status == .connected{
                WebSocketManager.shared.joinRoom(dict: ["messageId":self.messageId])
               
                self.getChatListing(messageId: self.messageId, isRead: 1)
                self.getNewMessage()
                self.sendMessageData()
                
            }else{
                WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
                DispatchQueue.main.asyncAfter(deadline: .now()+4.0){

                    WebSocketManager.shared.joinRoom(dict: ["messageId":self.messageId])
                  
                    self.getChatListing(messageId: self.messageId, isRead: 1)
                    self.getNewMessage()
                    self.sendMessageData()
                    WebService.hideLoader()
                    
          
                }
            }
         
            
        }else{
            self.viewModelMessage.getMessageId(messageId: self.notificationId) { data in

                WebSocketManager.shared.joinRoom(dict: ["messageId":data?.messageID ?? ""])
            
                self.getChatListing(messageId: data?.messageID ?? "", isRead: 1)
                self.getNewMessage()
                self.sendMessageData()
                self.messageId = data?.messageID ?? ""
                
              
                
            }
        }

    }
    @objc func methodOfReceivedGetChat(notification: Notification) {
        self.getChatListing(messageId: self.messageId, isRead: 1)
    }
   
    @objc func dismissKeyboardWhileClick() {
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwMessage.reloadData()
        }
    }
    
    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            btnAppliedRequests.setImage(UIImage(named: "nextUserwite"), for: .normal)
            viewReferFirst.backgroundColor = .clear
            btnMore.setImage(UIImage(named: "threedotdark"), for: .normal)
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            btnReject.setTitleColor(UIColor(hex: "#272727"), for: .normal)
            btnReject.backgroundColor = .white
            btnGallary.setImage(UIImage(named: "gallarydark"), for: .normal)
            btnSend.setImage(UIImage(named: "sendmsg"), for: .normal)
            txtVwMessage.textColor = UIColor.white
            lblNameProposal.textColor = UIColor.white
            stackVwRefer.backgroundColor = UIColor(hex: "#00516157").withAlphaComponent(0.34)
            btnCross.setImage(UIImage(named: "whitecros"), for: .normal)
            
        }else{
            btnAppliedRequests.setImage(UIImage(named: "nextuser"), for: .normal)
            btnCross.setImage(UIImage(named: "crossBlack"), for: .normal)
            lblNameProposal.textColor = UIColor.black
            txtVwMessage.textColor = UIColor.black
            btnMore.setImage(UIImage(named: "more"), for: .normal)
            btnSend.setImage(UIImage(named: "send 1"), for: .normal)
            btnGallary.setImage(UIImage(named: "photos"), for: .normal)
            btnReject.setTitleColor(.white, for: .normal)
            btnReject.backgroundColor = .black
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
    }


  
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.bottomView.constant = 10
//        view.endEditing(true)
//    }
//    
//    @objc func handleTap() {
//        self.bottomView.constant = 10
//        view.endEditing(true)
//    }
//    
    func startTimer() {
        stopTimer()
        guard self.timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateTimer() {
        WebService.hideLoader()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let formattedDate = dateFormatter.string(from: date)
        self.currentTime = formattedDate
        
        if let startTime = dateFormatter.date(from: self.currentTime),
           let endTime = dateFormatter.date(from: self.endTime) {
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: startTime, to: endTime)
            
            if let minutes = components.minute, let seconds = components.second {
                let timeDifferenceString = String(format: "%02d:%02d", minutes, seconds)

                self.lblTimer.text = timeDifferenceString
                
                if timeDifferenceString.contains("00:00") == true{
                    self.lblTimer.isHidden = true
                    self.heightTimerVw.constant = 0
                    self.vwSendMessage.isHidden = true
                    self.stopTimer()
                    self.getChatListing(messageId: self.messageId, isRead: 1)
                    
                    
                    
                    
                }else if  timeDifferenceString.contains("-") == true{
                    self.lblTimer.isHidden = true
                    self.heightTimerVw.constant = 0
                    self.vwSendMessage.isHidden = true
                    self.stopTimer()
                    self.getChatListing(messageId: self.messageId, isRead: 1)
                    
                }
            } else {
                print("Error: Unable to parse start or end time strings.")
            }
            
        }
    }
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func getChatListing(messageId: String, isRead: Int) {
        
        var param = [String: Any]()
        // Prepare parameters for the API call based on whether the message is read or not
        if isRead == 1 {
            param = ["messageId": messageId, "userId": Store.userDetail?["userId"] as? String ?? "", "isRead": isRead]
        } else {
            param = ["messageId": messageId, "userId": Store.userDetail?["userId"] as? String ?? ""]
        }
        if isLoad == false{
            isLoad = true
            WebService.showLoader()
        }
        
        print("Param---------",param)
        WebSocketManager.shared.getChatListing(dict: param)

                
    }
    
    private func getNewMessage(){
        WebSocketManager.shared.chatData = { data in
            // Update user reference ID
            sendByMe = false
            Store.userIdRefer = data?[0].senders?.id
           
            // Handle the UI updates based on whether the user has applied
            if data?[0].isApplied == true {
                self.btnApply.setTitle("Applied", for: .normal)
                self.btnApply.backgroundColor = UIColor(hex: "#02A0E3")
                self.btnApply.setTitleColor(UIColor.white, for: .normal)
                self.btnApply.isUserInteractionEnabled = false
            } else {
                self.btnApply.setTitle("Apply", for: .normal)
//                if let startColor = UIColor(named: "AppPinkColor"),
//                      let endColor = UIColor(named: "AppPurpleColor") {
//                    self.gradientLayer = self.btnApply.applyGradient(colours: [startColor, endColor])
//                   }
                self.btnApply.setTitleColor(UIColor.white, for: .normal)
                self.btnApply.isUserInteractionEnabled = true
            }


            // Handle the UI updates based on whether the user is referred
            if data?[0].isRefered == true {
                print("data?[0].referredBY?.name:--\(data?[0].referredBY?.name ?? "")")
                
                self.btnApply.isHidden = false
                self.heightReferVw.constant = 110
                self.vwApply.isHidden = true
                self.lblReferName.text = data?[0].referredBY?.name ?? ""
                self.lblReferDescription.text = data?[0].referredBY?.about ?? ""
                self.txtVwProposal.text = data?[0].proposedMessage ?? ""
                self.textViewDidChange(self.txtVwProposal)
                self.imgVwRefer.imageLoad(imageUrl: data?[0].referredBY?.profileImage ?? "")
            } else {
                self.btnApply.isHidden = true
                self.heightReferVw.constant = 0
                self.vwApply.isHidden = false
            }

            // Clear the previous chat data
            self.arrChat.removeAll()
            self.chatData.removeAll()
            
            // Update the chat data with the new data received
            self.chatData = data ?? []
            self.arrChat = data?[0].messageList ?? []
            
          

            // Scroll to the bottom of the message table view
          

            // Handle the UI updates based on the referral status
            if data?[0].isReferedStatus == 1 {
                // Pending status
                self.updateUIForPendingStatus(data: data)
            } else if data?[0].isReferedStatus == 2 {
                // Accepted status
            
                
                self.updateUIForAcceptedStatus(data: data)
            } else if data?[0].isReferedStatus == 3 {
                // Rejected status
                self.updateUIForRejectedStatus(data: data)
            } else {
                // Default status
                self.updateUIDefaultStatus(data: data)
            }
            
            // Additional UI updates based on chat data
            self.updateUIWithChatData(data: data)
         
        }

    }

    // Additional helper methods to update the UI for different statuses and chat data
    private func updateUIForPendingStatus(data: [ChatModel]?) {
        self.btnViewProposal.isHidden = true
        self.btnCross.isHidden = true
        self.btnMore.isHidden = true
        self.widthBtnMore.constant = 0
      
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.receiverId = self.arrChat[0].recipient?.id ?? ""
            self.viewReferFirst.isHidden = true
            self.viewReferSecond.isHidden = true
            self.vwSendMessage.isHidden = true
            self.vwBtnAcceptReject.isHidden = true
            self.lblDesciprionProposal.text = data?[0].senders?.about ?? ""
            self.txtVwProposal.text = data?[0].proposedMessage ?? ""
            self.textViewDidChange(self.txtVwProposal)
            self.viewReferFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            self.viewReferSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            self.stackVwRefer.borderWid = 1
            self.stackVwRefer.borderCol = UIColor(hex: "#02A0E3")
            
        } else {
            self.receiverId = self.arrChat[0].senderdetails?.id ?? ""
            self.viewReferFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            self.viewReferSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            self.stackVwRefer.borderWid = 1
            self.stackVwRefer.borderCol = UIColor(hex: "#02A0E3")
            self.viewReferFirst.isHidden = false
            self.viewReferSecond.isHidden = false
            self.lblAcceptRejectStatus.text = ""
            self.vwSendMessage.isHidden = true
            
        }
    }

    private func updateUIForAcceptedStatus(data: [ChatModel]?) {
        self.btnViewProposal.isHidden = false
      
        self.txtVwProposal.text = data?[0].proposedMessage ?? ""
        self.textViewDidChange(self.txtVwProposal)
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.lblAcceptRejectStatus.text = ""
            self.lblAcceptRejectStatus.textColor = .clear
            self.viewReferFirst.isHidden = true
            self.heightVIewFirst.constant = 0
            self.viewReferSecond.isHidden = true
            self.heightStackVwAccepReject.constant = 0
            self.btnMore.isHidden = false
            self.widthBtnMore.constant = 40
   
        } else {
            self.stackVwRefer.borderWid = 0

            if showProposal{
                self.heightVIewFirst.constant = 70
                self.viewReferFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                self.viewReferSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                self.stackVwRefer.borderWid = 1
                self.stackVwRefer.borderCol = UIColor(hex: "#02A0E3")
                self.viewReferSecond.isHidden = false
                self.btnCross.isHidden = false
                self.btnViewProposal.isHidden = true
            }else{
                self.heightVIewFirst.constant = 90
                self.stackVwRefer.borderWid = 0
                self.stackVwRefer.borderCol = .clear
                self.viewReferFirst.backgroundColor = UIColor(red: 0x5B/255.0, green: 0x5B/255.0, blue: 0x5B/255.0, alpha: 0.07)
                self.viewReferSecond.backgroundColor = UIColor(red: 0x5B/255.0, green: 0x5B/255.0, blue: 0x5B/255.0, alpha: 0.07)
                self.viewReferSecond.isHidden = true
                self.btnCross.isHidden = true
                self.btnViewProposal.isHidden = false

            }

            self.heightStackVwAccepReject.constant = 0
            self.btnMore.isHidden = true
            self.widthBtnMore.constant = 0
          
            
            if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                self.imgVwUserProposal.imageLoad(imageUrl: data?[0].recipients?.profileImage ?? "")
                self.lblNameProposal.text = data?[0].recipients?.name ?? ""
                self.lblDesciprionProposal.text = data?[0].recipients?.about ?? ""
                self.proposalUserId = data?[0].recipients?.id ?? ""
               
                
            }else{
                self.imgVwUserProposal.imageLoad(imageUrl: data?[0].senders?.profileImage ?? "")
                self.lblNameProposal.text = data?[0].senders?.name ?? ""
                self.lblDesciprionProposal.text = data?[0].senders?.about ?? ""
                self.proposalUserId = data?[0].senders?.id ?? ""
               
                
            }
            self.lblAcceptRejectStatus.text = "Accepted your refer request"
            self.lblAcceptRejectStatus.textColor = UIColor(hex: "#F10B80")
        }

        self.vwApply.isHidden = true
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.vwSendMessage.isHidden = true
            self.vwUpdateHour.isHidden = false
           
         
        } else {
            self.vwSendMessage.isHidden = false
            self.vwUpdateHour.isHidden = true
           
        }
    }

    private func updateUIForRejectedStatus(data: [ChatModel]?) {
        self.btnMore.isHidden = true
        self.widthBtnMore.constant = 0
        self.vwSendMessage.isHidden = true
        self.vwUpdateHour.isHidden = false
        self.btnViewProposal.isHidden = false
        self.btnCross.isHidden = true
        self.txtVwProposal.text = data?[0].proposedMessage ?? ""
        self.textViewDidChange(self.txtVwProposal)
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.lblAcceptRejectStatus.text = ""
            self.lblAcceptRejectStatus.textColor = .clear
            self.viewReferFirst.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
            self.viewReferSecond.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
            self.stackVwRefer.borderWid = 0
            self.viewReferFirst.isHidden = false
            self.heightVIewFirst.constant = 90
            self.viewReferSecond.isHidden = true
            self.heightStackVwAccepReject.constant = 0
        } else {
            self.lblAcceptRejectStatus.text = "Rejected your refer request"
            self.lblAcceptRejectStatus.textColor = UIColor(hex: "#F10B80")
            self.viewReferFirst.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
            self.viewReferSecond.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
            self.stackVwRefer.borderWid = 0
            self.viewReferFirst.isHidden = false
            self.heightVIewFirst.constant = 90
            self.viewReferSecond.isHidden = false
            self.heightStackVwAccepReject.constant = 50
        }
    }
    private func updateUIDefaultStatus(data: [ChatModel]?) {
        self.btnViewProposal.isHidden = false
        self.btnCross.isHidden = true
 
        self.viewReferFirst.isHidden = true
        self.viewReferSecond.isHidden = true
        
 
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
            self.vwSendMessage.isHidden = false
            self.vwUpdateHour.isHidden = true
            self.btnMore.isHidden = false
            self.widthBtnMore.constant = 40
           
         
        }else{
            self.vwSendMessage.isHidden = true
            self.vwUpdateHour.isHidden = false
            self.btnMore.isHidden = true
            self.widthBtnMore.constant = 0
       
        }
    }
    private func updateUIWithChatData(data: [ChatModel]?) {
        if data?[0].messageList?.count ?? 0 == 1{
                      
                      
                      
                      if data?[0].isStatus == 1 {
                          
                          if data?[0].isReferedStatus  == 2{
                              
                              if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                  self.vwSendMessage.isHidden = true
                                  
                              }else{
                                  self.vwSendMessage.isHidden = false
                                  
                              }
                              
                              self.vwApply.isHidden = true
                              if data?[0].endContract == 0{
                                  
                                  if data?[0].continueChat == 0{
                                      
                                      if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                          self.widthUpdateHourSideBtn.constant = 0
                                          self.vwSendMessage.isHidden = false

                                          
                                      }
                                      
                                      self.heightTimerVw.constant = 0
                                      if data?[0].isDispute == 0{
                                          
                                          if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                              
                                              self.widthUpdateHourSideBtn.constant = 0

                                                  self.vwSendMessage.isHidden = true
                                                  self.vwUpdateHour.isHidden = true
                                              
                                          }else{
                                              
                                              
                                              self.vwSendMessage.isHidden = false
                                              self.vwUpdateHour.isHidden = true
                                              
                                          }
                                          
                                          self.optionStatus = 1
                                      }else{
                                          self.lblTimer.isHidden = true
                                          self.heightTimerVw.constant = 0
                                      
                                          self.vwSendMessage.isHidden = false
                                          self.vwUpdateHour.isHidden = true
                                          self.vwApply.isHidden = true
                                          self.optionStatus = 2
                                      }
                                      print("Continue Chat not start.")
                                      self.stopTimer()
                                  }else{
                                      
                                      
                                      self.optionStatus = 3
                                      self.lblTimer.isHidden = false
                                      self.heightTimerVw.constant = 50
                                      self.vwSendMessage.isHidden = false
                                      self.vwUpdateHour.isHidden = true
                                      self.vwApply.isHidden = true
                                      let continueEndTime = self.string_date_ToDate((data?[0].endTime ?? ""), currentFormat: .BackEndFormat, requiredFormat: .hh_mm)
                                      self.endTime = continueEndTime
                                      self.startTimer()
                                      print("Continue Chat  start")
                                  }
                              }else{
                                  self.stopTimer()
                                  self.optionStatus = 4
                                  
                                  self.vwSendMessage.isHidden = true
                                  self.vwBtnAcceptReject.isHidden = true
                                  self.vwUpdateHour.isHidden = false
                              }
                          }else{
                              
                              if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
      
                                    self.vwSendMessage.isHidden = true
        
                                  self.widthUpdateHourSideBtn.constant = 0
                                  self.vwApply.isHidden = true
                              }else{
                                  
                                  self.vwSendMessage.isHidden = false
                                  self.vwUpdateHour.isHidden = true
                                  self.vwApply.isHidden = true
                              }
                              
                              self.vwBtnAcceptReject.isHidden = true
                          }
                      }else if data?[0].isStatus == 2{
                          
                          self.heightVIewFirst.constant = 0
                          self.vwSendMessage.isHidden = true
                          self.vwUpdateHour.isHidden = true
                          self.vwContinueChat.isHidden = true
                          self.btnContinueChat.isHidden = true
                          self.heightStackVwAccepReject.constant = 0
                          self.vwBtnAcceptReject.isHidden = true
                        
                          if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                              
                              self.viewReferFirst.isHidden = true
                              self.viewReferSecond.isHidden = true
                              
                              if data?[0].isReferedRequest == true{
                                  self.lblrejected.isHidden = false
                                  self.lblrejected.text = "You have rejected the invitation request."
                                  
                              }else{
                                  self.lblrejected.isHidden = false
                                  self.lblrejected.text = "\(data?[0].recipients?.name ?? "") rejected  your invitation."
                              }
                          }else{
                              if data?[0].isReferedRequest == true{
                                  self.lblrejected.isHidden = false
                                  self.lblrejected.text = "\(data?[0].senders?.name ?? "") rejected  your invitation."
                                  
                              }else{
                                  self.lblrejected.isHidden = false
                                  self.lblrejected.text = "You have rejected the invitation request."
                                  
                              }
                              self.viewReferFirst.isHidden = false
                              self.heightVIewFirst.constant = 0
                              self.lblAcceptRejectStatus.text = ""
                              self.viewReferSecond.isHidden = true
                              
                          }
                      }else{
                          
                          if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                              self.imgVwUserProposal.imageLoad(imageUrl: data?[0].recipients?.profileImage ?? "")
                              self.lblNameProposal.text = data?[0].recipients?.name ?? ""
                              self.lblDesciprionProposal.text = data?[0].recipients?.about ?? ""
                              self.proposalUserId = data?[0].recipients?.id ?? ""
                              self.vwSendMessage.isHidden = true
                              self.vwUpdateHour.isHidden = true
                              self.lblrejected.isHidden = true
                              
                              
                          }else{
                              self.imgVwUserProposal.imageLoad(imageUrl: data?[0].senders?.profileImage ?? "")
                              self.lblNameProposal.text = data?[0].senders?.name ?? ""
                              self.lblDesciprionProposal.text = data?[0].senders?.about ?? ""
                              self.proposalUserId = data?[0].senders?.id ?? ""
                              self.vwSendMessage.isHidden = true
                              self.vwUpdateHour.isHidden = true
                              self.lblrejected.isHidden = true
                              
                          }
                          
                          
                          
                          if data?[0].isRefered == true{
                              
                              self.lblrejected.isHidden = true
                              self.vwBtnAcceptReject.isHidden = true
                              self.vwApply.isHidden = false
                              
                              
                              if data?[0].isReferedStatus == 1{
                                  self.viewReferFirst.isHidden = true
                                  self.viewReferSecond.isHidden = true
                                  
                                  
                              }
                          }else{
                              
                              
                              self.vwApply.isHidden = true
                              if data?[0].isReferedStatus == 0{
                                  self.vwBtnAcceptReject.isHidden = false
                                  
                                  
                                  
                              }else  if data?[0].isReferedStatus == 1{
                                  self.viewReferFirst.isHidden = false
                                  self.heightVIewFirst.constant = 70
                                  self.viewReferSecond.isHidden = false
                                  
                                  
                              }else{
                                  self.vwBtnAcceptReject.isHidden = true
                                  self.lblrejected.isHidden = true
                                  
                              }
                          }
                          
                      }
                      self.vwContinueChat.isHidden = true
                      self.btnContinueChat.isHidden = true
                      self.optionStatus = 1
                  }else{
                      if data?[0].endContract == 0{
                          
                          if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                              self.btnMore.isHidden = false
                              self.widthBtnMore.constant = 40
                              self.vwContinueChat.isHidden = false
                              self.btnContinueChat.isHidden = false
                          }else{
                              self.btnMore.isHidden = true
                              self.widthBtnMore.constant = 0
                              self.vwContinueChat.isHidden = true
                              self.btnContinueChat.isHidden = true
                              
                          }
                          if data?[0].continueChat == 0{
                              if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                  self.vwContinueChat.isHidden = false
                                  self.btnContinueChat.isHidden = false
                              }else{
                                  self.vwContinueChat.isHidden = true
                                  self.btnContinueChat.isHidden = true
                              }
                              
                              self.heightTimerVw.constant = 0
                              if data?[0].isDispute == 0{
                                  self.vwSendMessage.isHidden = true
                                  if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                      self.vwUpdateHour.isHidden = true
                                  }else{
                                      self.vwUpdateHour.isHidden = false
                                  }
                                  self.optionStatus = 1
                                  
                              }else{
                                  self.lblTimer.isHidden = true
                                  self.heightTimerVw.constant = 0
                                  self.vwSendMessage.isHidden = false
                                  self.vwUpdateHour.isHidden = true
                                  self.vwApply.isHidden = true
                                  self.optionStatus = 2
                                  self.btnContinueChat.isHidden = true
                                  self.vwContinueChat.isHidden = true
                              }
                              print("Continue Chat not start.")
                              self.stopTimer()
                          }else{
                              if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                                  self.widthUpdateHourSideBtn.constant = 0
                                  
                              }else{
                                  self.widthUpdateHourSideBtn.constant = 50
                                  
                              }
                              self.vwContinueChat.isHidden = true
                              self.btnContinueChat.isHidden = true
                              self.optionStatus = 3
                              
                              self.vwSendMessage.isHidden = false
                              self.vwUpdateHour.isHidden = true
                              if data?[0].isDispute == 0{
                                  self.vwSendMessage.isHidden = false
                                  self.vwUpdateHour.isHidden = true
                                  self.optionStatus = 1
                                  self.lblTimer.isHidden = false
                                  self.heightTimerVw.constant = 50
                                  
                              }else{
                                  self.vwSendMessage.isHidden = false
                                  self.vwUpdateHour.isHidden = true
                                  self.vwApply.isHidden = true
                                  self.optionStatus = 2
                                  self.lblTimer.isHidden = true
                                  self.heightTimerVw.constant = 0
                                  
                              }
                              self.vwApply.isHidden = true
                              let continueEndTime = self.string_date_ToDate((data?[0].endTime ?? ""), currentFormat: .BackEndFormat, requiredFormat: .hh_mm)
                              self.endTime = continueEndTime
                              self.startTimer()
                              print("Continue Chat  start")
                          }
                      }else{
                          
                          self.vwContinueChat.isHidden = true
                          self.btnContinueChat.isHidden = true
                          if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                              self.vwUpdateHour.isHidden = true
                              
                          }else{
                              self.vwUpdateHour.isHidden = true
                              
                          }
                          
                          self.stopTimer()
                          self.optionStatus = 4
                          self.btnMore.isHidden = false
                          self.widthBtnMore.constant = 40
                          self.vwSendMessage.isHidden = true
                          self.lblTimer.isHidden = true
                          self.heightTimerVw.constant = 0
                          self.vwBtnAcceptReject.isHidden = true
                      }
                      
                  }
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
            self.receiverId = self.arrChat[0].recipient?.id ?? ""
            
            self.userHourPrice = data?[0].senders?.hoursPrice ?? 0
            self.anotherUserPrice = data?[0].recipients?.hoursPrice ?? 0
            self.anotherUserName = data?[0].recipients?.name ?? ""
          
            
            
        }else{
            self.receiverId = self.arrChat[0].senderdetails?.id ?? ""
            self.userHourPrice = data?[0].recipients?.hoursPrice ?? 0
            self.anotherUserPrice = data?[0].senders?.hoursPrice ?? 0
            self.anotherUserName = data?[0].senders?.name ?? ""
            
        }
        
        self.tblVwMessage.reloadData()
      
        WebService.hideLoader()
    }

    private func sendMessageData() {
      
          isRead = false
          WebSocketManager.shared.userListnerSuccess = {
              if self.isLoad == true {
                  self.getChatListing(messageId: self.messageId, isRead: 1)
              } else {
                  self.getChatListing(messageId: self.messageId, isRead: 0)
              }
            
          }
      }
    //MARK: - ACTION
    
    @IBAction func actionAppliedrequests(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedRequestsVC") as! AppliedRequestsVC
        vc.notesId = notesId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionCrossBtn(_ sender: UIButton) {
        if traitCollection.userInterfaceStyle == .dark {
            viewReferFirst.borderWid = 0
            viewReferFirst.borderCol = .clear
        }else{
            viewReferFirst.borderWid = 1
            viewReferFirst.borderCol = .white
        }
        self.showProposal = false
        self.btnCross.isHidden = true
        self.btnViewProposal.isHidden = false
        self.viewReferSecond.isHidden = true
        self.lblAcceptRejectStatus.isHidden = false
        self.stackVwRefer.borderWid = 0
        self.heightVIewFirst.constant = 90
        self.viewReferFirst.backgroundColor = UIColor(red: 0x5B/255.0, green: 0x5B/255.0, blue: 0x5B/255.0, alpha: 0.07)
        self.viewReferSecond.backgroundColor = UIColor(red: 0x5B/255.0, green: 0x5B/255.0, blue: 0x5B/255.0, alpha: 0.07)
        self.tblVwMessage.reloadData()
    }
    @IBAction func actionViewProposal(_ sender: UIButton) {
        self.showProposal = true
        self.btnViewProposal.isHidden = true
        self.btnCross.isHidden = false
        self.viewReferSecond.isHidden = false
        self.lblAcceptRejectStatus.isHidden = true
        if traitCollection.userInterfaceStyle == .dark {
            viewReferFirst.borderWid = 0
            viewReferFirst.borderCol = .clear
            lblDesciprionProposal.textColor = UIColor(hex: "#A7AAAA")
            
            txtVwProposal.textColor = UIColor(hex: "#A7AAAA")
        }else{
            viewReferFirst.borderWid = 0
            viewReferFirst.borderCol = .clear
            lblDesciprionProposal.textColor = UIColor(hex: "#A7AAAA")
            txtVwProposal.textColor = UIColor(hex: "#A7AAAA")
        }
        self.heightVIewFirst.constant = 70
        self.viewReferFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
        self.viewReferSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
        self.stackVwRefer.borderWid = 1
        self.stackVwRefer.borderCol = UIColor(hex: "#02A0E3")
        self.tblVwMessage.reloadData()
    }
    
    @IBAction func actionPriceBtn(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContinueChatVC") as! ContinueChatVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isComingContinue = false
        vc.amount = self.userHourPrice
        vc.name = self.receiverName
        vc.callBack = {
            self.getChatListing(messageId: self.messageId, isRead: 1)
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func actionAcceptProposal(_ sender: UIButton) {
        
        viewModelRefer.acceptRejectRefer(notesId: notesId, userId: proposalUserId, status: "2") { message in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message ?? ""
            vc.callBack = {
                self.getChatListing(messageId: self.messageId, isRead: 1)
                
            }
            self.navigationController?.present(vc, animated: false)
        }
    }
    @IBAction func actionRejectProposal(_ sender: UIButton) {
        viewModelRefer.acceptRejectRefer(notesId: notesId, userId: proposalUserId, status: "3") { message in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message ?? ""
            vc.callBack = {
                self.getChatListing(messageId: self.messageId, isRead: 1)
                
            }
            self.navigationController?.present(vc, animated: false)
        }
        
    }
    
    @IBAction func actionRefer(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        Store.selectReferData = ["notificationId":notificationId,"notesId":notesId,"messageId":messageId]
        
        Store.selectTabIndex = 0
        vc.isComing = true
        Store.isRefer = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func actionAccept(_ sender: UIButton) {
        viewModel.acceptRejectInvitationApi(messageId: messageId, isStatus: "1") { message in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message ?? ""
            vc.callBack = {
                self.getChatListing(messageId: self.messageId, isRead: 1)
            }
            self.navigationController?.present(vc, animated: false)
        }
        
    }
    
    @IBAction func actionReject(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageAcceptPopUpVC") as! MessageAcceptPopUpVC
        vc.status = "reject"
        vc.messageId = messageId
        vc.callBackReject = { message in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message
            vc.callBack = {
                SceneDelegate().notificationsRoot(selectTab:1)
            }
            self.navigationController?.present(vc, animated: false)
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
    }
    
    @IBAction func actionThreeDot(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        vc.modalPresentationStyle = .popover
        vc.isStatus = optionStatus
        if optionStatus == 1{
            vc.preferredContentSize = CGSize(width: 200, height: 82)
        }else if optionStatus == 2{
            vc.preferredContentSize = CGSize(width: 200, height: 82)
        }else if optionStatus == 3{
            vc.preferredContentSize = CGSize(width: 200, height: 41)
        }else if optionStatus == 4{
            vc.preferredContentSize = CGSize(width: 200, height: 41)
        }
        
        vc.callBack = { (index) in
            if index == "Add Dispute"{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddDisputeVC") as! AddDisputeVC
                vc.messageId = self.messageId
                vc.callBack = { message in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.message = message
                    vc.callBack = {
                        let jsonObject: [String: String] = [
                            "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                            "messageId": "\(self.messageId)",
                            "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                            "receiverId": "\(self.receiverId)",
                            "message": "Dispute Created."
                        ]
                        print(jsonObject)
                        
                        WebSocketManager.shared.sendMessage(dict: jsonObject)
                    }
                    self.navigationController?.present(vc, animated: false)
                    
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: true)
            }else if index == "Add Review"{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as! AddReviewVC
                
                vc.messageId = self.messageId
                vc.userId = self.receiverId
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: true)
            }else if index == "Continue Chat"{
                
                
            }else if index == "End Dispute"{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageAcceptPopUpVC") as! MessageAcceptPopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.status = "endDispute"
                vc.callBack = {
                    self.viewModel.endDispute(messageId: self.messageId) { data in
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = data
                        vc.callBack = {
                            let jsonObject: [String: String] = [
                                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                                "messageId": "\(self.messageId)",
                                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                                "receiverId": "\(self.receiverId)",
                                "message": "Dispute Resolve."
                            ]
                            print(jsonObject)
                            
                            WebSocketManager.shared.sendMessage(dict: jsonObject)
                        }
                        
                        self.navigationController?.present(vc, animated: false)
                    }
                }
                self.navigationController?.present(vc, animated: false)
                //                self.showAlert(message: "Are your sure you want to end dispute.", status: 1)
            }else{
                
                //                self.showAlert(message: "Are you sure you want to end contract.", status: 0)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageAcceptPopUpVC") as! MessageAcceptPopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.status = "endContract"
                vc.callBack = {
                    self.viewModel.acceptRejectInvitationApi(messageId: self.messageId, isStatus: "3") { message in
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = message ?? ""
                        vc.callBack = {
                            let jsonObject: [String: String] = [
                                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                                "messageId": "\(self.messageId)",
                                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                                "receiverId": "\(self.receiverId)",
                                "message": "End Contract."
                            ]
                            print(jsonObject)
                            
                            WebSocketManager.shared.sendMessage(dict: jsonObject)
                        }
                        self.navigationController?.present(vc, animated: false)
                        
                        //                       self.navigationController?.popViewController(animated: true)
                    }
                }
                self.navigationController?.present(vc, animated: false)
                
            }
        }
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        self.present(vc, animated: false)
    }
    
    
    @IBAction func actionSend(_ sender: UIButton) {
        if !(self.txtVwMessage.text?.isEmpty ?? true) {
            
            let jsonObject: [String: Any] = [
//                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                "messageId": "\(messageId)",
                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                "receiverId": "\(receiverId)",
                "message": "\(txtVwMessage.text ?? "")"
            ]
            print(jsonObject)
            self.sendMessageByMe = true
            sendByMe = true
            WebSocketManager.shared.sendMessage(dict: jsonObject)
            
            self.txtVwMessage.text  = ""
        }
        
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        showChat = false
        stopTimer()
        if isComingDispute == "Dispute"{
            self.navigationController?.popViewController(animated: true)
        }else if isComingDispute == "userList"{
            SceneDelegate().notificationsRoot(selectTab: 0)
        }else if isComingDispute == "Notification"{
            SceneDelegate().notificationsRoot(selectTab: 0)
        }else{
            //            SceneDelegate().notificationsRoot(selectTab: 1)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionApply(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferMessageVC") as! ReferMessageVC
        vc.messageId = self.messageId
        vc.notesId = notesId
        vc.modalPresentationStyle = .overFullScreen
        vc.callBack = { message in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.message = message ?? ""
            vc.isComing = false
            vc.modalPresentationStyle = .overFullScreen
            vc.callBack = {
                self.navigationController?.popViewController(animated: true)
            }
            self.navigationController?.present(vc, animated:false)
            
            
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func actionContinueChat(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContinueChatVC") as! ContinueChatVC
        vc.isComingContinue = true
        vc.messageId = self.messageId
        vc.amount = self.anotherUserPrice
        vc.name = self.anotherUserName
        vc.userId = self.receiverId
        vc.modalPresentationStyle = .overFullScreen
        vc.callBack = {
            
            let jsonObject: [String: String] = [
                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                "messageId": "\(self.messageId)",
                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                "receiverId": "\(self.receiverId)",
                "message": "Continue Chat Start."
            ]
            print(jsonObject)
            
            WebSocketManager.shared.sendMessage(dict: jsonObject)
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    
    @IBAction func actionPhotos(_ sender: UIButton) {
        chooseImage()
    }
    func chooseImage() {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.showImagePicker(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        
        // Add Photo Library option
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        alertController.addAction(photoLibraryAction)
        
        // Add Cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        do {
            if let mediaType = info[.mediaType] as? String {
                if mediaType == "public.image" {
                    try processImage(info: info)
                } else if mediaType == "public.movie" as String {
                    try processVideo(info: info)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func processImage(info: [UIImagePickerController.InfoKey: Any]) throws {
        guard let image = info[.originalImage] as? UIImage else {
            throw ImageProcessingError.imageNotFound
        }
        
        image.jpegData(compressionQuality: 0.5)
        viewModelMessage.fileUpload(image: image) { data in
            print(data?.imageUrl ?? "")
            let jsonObject: [String: String] = [
                //                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                "messageId": "\(self.messageId)",
                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                "receiverId": "\(self.receiverId)",
                "media": "\(data?.imageUrl ?? "")"
            ]
            print(jsonObject)
            WebSocketManager.shared.sendImgVideo(dict: jsonObject)
            
        }
    }
    
    
    func processVideo(info: [UIImagePickerController.InfoKey: Any]) throws {
        guard let videoURL = info[.mediaURL] as? URL else {
            throw VideoProcessingError.videoURLNotFound
        }
        
        viewModelMessage.fileUploadVideo(video: videoURL) { data in
            let jsonObject: [String: String] = [
                //                "user": "\(Store.userDetail?["userName"] as? String ?? "")",
                "messageId": "\(self.messageId)",
                "senderId": "\(Store.userDetail?["userId"] as? String ?? "")",
                "receiverId": "\(self.receiverId)",
                "media": "\(data?.imageUrl ?? "")"
            ]
            print(jsonObject)
            WebSocketManager.shared.sendImgVideo(dict: jsonObject)
        }
        
        
    }
    
    
    func generateThumbnail(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            do {
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
                let thumbnail = UIImage(cgImage: thumbnailCGImage)
                
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
                print("Error generating thumbnail: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

// MARK: - Popup

extension MessageVC : UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
        
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension MessageVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrChat.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = arrChat[indexPath.section]
        let sentByMe = (chat.sender ?? "") == (Store.userDetail?["userId"] as? String ?? "")
      
            if sentByMe{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SendMessageTVC") as! SendMessageTVC
          
                    if self.traitCollection.userInterfaceStyle == .dark {
                        cell.viewSendMsgWithImg.backgroundColor = UIColor(hex: "#161616")
                        cell.viewSendMessageBAck.backgroundColor = UIColor(hex: "#161616")
                        
                    }else{
                        
                        
                        cell.viewSendMsgWithImg.backgroundColor = UIColor(hex: "#EF0B81").withAlphaComponent(0.07)
                        cell.viewSendMessageBAck.backgroundColor = UIColor(hex: "#EF0B81").withAlphaComponent(0.07)
                    }
                    
                    
                    let date = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
                    if date == self.todayDate {
                        cell.lblTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                        
                        cell.lblSendTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                    }else if date == self.yesterDayDate{
                        cell.lblTime.text = "Yesterday"
                        
                        cell.lblSendTime.text = "Yesterday"
                    }else{
                        cell.lblTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                        
                        cell.lblSendTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                    }
                    
                    if self.arrChat[indexPath.section].message == nil{
                        cell.vwMessage.isHidden = true
                    }else{
                        cell.vwMessage.isHidden = false
                    }
                    cell.lblMessageTitle.text = self.arrChat[indexPath.section].message ?? ""
                    if self.arrChat[indexPath.section].media?.count ?? 0 > 0 {
                        
                        
                        
                        if indexPath.section == 0{
                            cell.vwMessage.isHidden = true
                        }else{
                            if self.arrChat[indexPath.section].message == nil{
                                cell.vwMessage.isHidden = true
                            }else{
                                cell.vwMessage.isHidden = false
                            }
                        }
                        
                        
                        cell.clsnVwMessage.isHidden = false
                        cell.vwImage.isHidden = false
                        
                        cell.arrImage = self.arrChat[indexPath.section].media ?? [String]()
                        cell.uiSet()
                    }else{
                        cell.vwImage.isHidden = true
                        cell.clsnVwMessage.isHidden = true
                    }
                    ///
                    ///
                    ///
                    cell.lblMessage.text = self.arrChat[indexPath.section].message ?? ""
                    if chat.sender == chat.senderdetails?.id {
                        cell.imgVwProfile.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                        cell.lblName.text = chat.senderdetails?.name ?? ""
                        cell.lblSenderName.text = chat.senderdetails?.name ?? ""
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                        cell.lblName.text = chat.recipient?.name ?? ""
                        cell.lblSenderName.text = chat.recipient?.name ?? ""
                    }
                    cell.callBack = { (isSelect,url)  in
                        if isSelect == "image"{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
                            vc.uploadImg = url
                            vc.modalPresentationStyle = .overFullScreen
                            self.navigationController?.present(vc, animated: false)
                        }else{
                            let videoURL = url
                            let url = URL(string: videoURL as? String ?? "")
                            let player = AVPlayer(url: url!)
                            let playerViewController = AVPlayerViewController()
                            playerViewController.player = player
                            self.present(playerViewController, animated: false) {
                                playerViewController.player!.play()
                            }
                        }
                    }
                    
                
                return cell
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveMessageTVC") as! ReceiveMessageTVC
               
                    if self.traitCollection.userInterfaceStyle == .dark {
                        cell.vwReceiverImg.backgroundColor = UIColor(hex: "#161616")
                        cell.vwReceiverMsg.backgroundColor = UIColor(hex: "#161616")
                    }else{
                        cell.vwReceiverImg.backgroundColor = UIColor(hex: "#46B1FF").withAlphaComponent(0.07)
                        cell.vwReceiverMsg.backgroundColor = UIColor(hex: "#46B1FF").withAlphaComponent(0.07)
                    }
                    cell.lblMessageTitle.text = self.arrChat[indexPath.section].message ?? ""
                    let date = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
                    if date == self.todayDate {
                        cell.lblTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                        
                        cell.lblReceiverTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                    }else if date == self.yesterDayDate{
                        cell.lblTime.text = "Yesterday"
                        
                        cell.lblReceiverTime.text = "Yesterday"
                    }else{
                        cell.lblTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                        
                        cell.lblReceiverTime.text = self.string_date_ToDate((self.arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                    }
                    if self.arrChat[indexPath.section].media?.count ?? 0 > 0 {
                        cell.vwImage.isHidden = false
                        cell.clsnVwMessage.isHidden = false
                        if indexPath.section == 0{
                            cell.vwMessage.isHidden = true
                        }else{
                            if self.arrChat[indexPath.section].message == nil{
                                cell.vwMessage.isHidden = true
                            }else{
                                cell.vwMessage.isHidden = false
                            }
                        }
                        cell.arrImage = self.arrChat[indexPath.section].media ?? [String]()
                        cell.uiSet()
                    }else{
                        cell.vwMessage.isHidden = false
                        cell.vwImage.isHidden = true
                        cell.clsnVwMessage.isHidden = true
                    }
                    
                    cell.lblMessage.text = self.arrChat[indexPath.section].message ?? ""
                    if chat.sender == chat.senderdetails?.id{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                        cell.lblName.text = chat.senderdetails?.name ?? ""
                        cell.lblReceiverName.text = chat.senderdetails?.name ?? ""
                        if self.arrChat[indexPath.section].senderdetails?.name?.contains("Admin") == true{
                            //                    cell.vwReceiverMsg.backgroundColor = UIColor(hex: "1F009688").withAlphaComponent(0.07)
                            cell.lblName.textColor = UIColor(hex: "005A52")
                            //                    cell.vwReceiverImg.backgroundColor = UIColor(hex: "1F009688").withAlphaComponent(0.07)
                            cell.lblReceiverName.textColor = UIColor(hex: "005A52")
                        }else{
                            //                    cell.vwReceiverMsg.backgroundColor = UIColor(hex: "EF0B81").withAlphaComponent(0.07)
                            cell.lblName.textColor = UIColor(hex: "EF0B81")
                            //                    cell.vwReceiverImg.backgroundColor = UIColor(hex: "EF0B81").withAlphaComponent(0.07)
                            cell.lblReceiverName.textColor = UIColor(hex: "EF0B81")
                        }
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                        cell.lblName.text = chat.recipient?.name ?? ""
                        cell.lblReceiverName.text = chat.recipient?.name ?? ""
                    }
                    
                    cell.callBack = { (isSelect,url)  in
                        if isSelect == "image"{
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
                            vc.uploadImg = url
                            
                            vc.modalPresentationStyle = .overFullScreen
                            self.navigationController?.present(vc, animated: false)
                        }else{
                            
                            let videoURL = url
                            let url = URL(string: videoURL as? String ?? "")
                            let player = AVPlayer(url: url!)
                            let playerViewController = AVPlayerViewController()
                            
                            playerViewController.player = player
                            
                            self.present(playerViewController, animated: false) {
                                playerViewController.player!.play()
                            }
                        }
                    }
                    
                
                return cell
                
           
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Ensure table view layout updates are completed
        tableView.layoutIfNeeded()
        
        // Calculate contentHeight
        var contentHeight: CGFloat
        if arrChat[indexPath.section].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            contentHeight = tableView.contentSize.height + 205
        } else {
            if showProposal {
                contentHeight = tableView.contentSize.height + heightTxtVwProposal.constant + heightVIewFirst.constant + 205
            } else {
                contentHeight = tableView.contentSize.height + heightVIewFirst.constant + 205
            }
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        if contentHeight < screenHeight {
            let height = showProposal ? heightTxtVwProposal.constant + heightVIewFirst.constant + 205 : heightVIewFirst.constant + 250
            heightTblVw.constant = screenHeight - height
            scrollVw.isScrollEnabled = true
            scrollVw.layoutIfNeeded()
            scrollToBottom(indexPath: indexPath)
        } else {
            DispatchQueue.main.async {
                self.scrollVw.isScrollEnabled = true
                self.heightTblVw.constant = tableView.contentSize.height + 20
                self.scrollVw.layoutIfNeeded()
                self.scrollToBottom(indexPath: indexPath)
            }
        }
    }


    private func scrollToBottom(indexPath: IndexPath) {
        scrollVw.layoutIfNeeded()  // Ensure layout is up to date

        let contentHeight = tblVwMessage.contentSize.height
        var scrollViewHeight = scrollVw.bounds.height
        var bottomOffset = CGPoint()

        if arrChat[indexPath.section].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            // When the user is the sender
            let extraSpace: CGFloat = 60
            bottomOffset = CGPoint(x: 0, y: max(contentHeight - scrollViewHeight - extraSpace, 0))
        } else {
            // When the user is not the sender
            scrollVw.layoutIfNeeded()
            
            if showProposal {
                scrollViewHeight -= heightVIewFirst.constant + heightTxtVwProposal.constant
                bottomOffset = CGPoint(x: 0, y: max(contentHeight - scrollViewHeight + 80, 0))
            } else {
                scrollViewHeight -= heightVIewFirst.constant
                bottomOffset = CGPoint(x: 0, y: max(contentHeight - scrollViewHeight + 20, 0))
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Adjusted delay
                self.scrollVw.setContentOffset(bottomOffset, animated: true)
            }
        }
    }

}

//MARK: - UITextViewDelegate
extension MessageVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtVwMessage.textColor == UIColor.lightGray {
            txtVwMessage.text = nil
            
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        heightTxtVwProposal.constant = min(newSize.height, 250)
        
        txtVwProposal.sizeToFit()
        heightTxtVwProposal.constant = CGFloat(txtVwProposal.contentSize.height)
    
        view.layoutIfNeeded()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if traitCollection.userInterfaceStyle == .dark{
            txtVwMessage.textColor = UIColor.white
        }else{
            txtVwMessage.textColor = UIColor.lightGray
        }
        if txtVwMessage.text.isEmpty {
          
            txtVwMessage.text = "Answer here..."
            
        }
    }
}


//MARK: - KEYBOARD HANDLING
extension MessageVC {
    
    private func keyboardHandling(){
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(MessageVC.self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomView.constant = 10
        
    }
    @objc func keyboardWillShow(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136,1334,1920, 2208:
                    print("1")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.tableViewScrollToBottom()
                case 2436,2688,1792:
                    print("2")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.tableViewScrollToBottom()
                default:
                    print("3")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.tableViewScrollToBottom()
                }
            }
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
    }
    
    //MARK: - TABLE VIEW SCROLL TO BOTTOM
    func tableViewScrollToBottom() {
        DispatchQueue.main.async {
            let contentHeight = self.scrollVw.contentSize.height
            let boundsHeight = self.scrollVw.bounds.size.height
            
            if contentHeight > boundsHeight {
                let bottomOffset = CGPoint(x: 0, y: contentHeight - boundsHeight + self.scrollVw.contentInset.bottom)
              self.scrollVw.setContentOffset(bottomOffset, animated: true)
               
              
            }
        }
    }
  
}


extension ImageStructInfo {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["fileName"] = fileName
        dictionary["type"] = type
        dictionary["data"] = data
        dictionary["key"] = key
        
        return dictionary
    }
}


