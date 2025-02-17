//
//  ChatScreenVC.swift
//  ask-human
//
//  Created by Ideio Soft on 21/08/24.
//
import UIKit
import AVFoundation
import SocketIO
import AVKit
import IQKeyboardManagerSwift
class ChatScreenVC: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    //MARK: - IBOutlet
    @IBOutlet weak var bottomVw: NSLayoutConstraint!
    @IBOutlet weak var btnAppliedRequest: UIButton!
    @IBOutlet weak var widthUpdateHourSideBtn: NSLayoutConstraint!
    @IBOutlet weak var lblRejected: UILabel!
    @IBOutlet weak var btnContinueChat: UIButton!
    @IBOutlet weak var vwContinueChat: UIView!
    @IBOutlet weak var btnUpdateHour: UIButton!
    @IBOutlet weak var vwUpdateHour: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var btnRefer: UIButton!
    @IBOutlet weak var btnAccept: GradientButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var vwAcceptReject: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtVwMessage: IQTextView!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var vwSendMessage: UIView!
    @IBOutlet weak var heightTimerVw: NSLayoutConstraint!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblVwChat: UITableView!
    @IBOutlet weak var widthBtnMore: NSLayoutConstraint!
    @IBOutlet weak var lblScreenTitle: UILabel!
    //MARK: - variables
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
    private func uiSet(){
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
        tapGesture2.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture2)
        txtVwMessage.delegate = self
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
    private func getSocketData(){
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
        //              if self.sendMessageByMe == false{
        //                  self.getChatListing(messageId: self.messageId, isRead: 0)
        //                  self.getNewMessage()
        //              }
    }
    @objc func dismissKeyboardWhileClick() {
        view.endEditing(true)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwChat.reloadData()
        }
    }
    private func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnAppliedRequest.setImage(UIImage(named: "nextUserwite"), for: .normal)
            btnMore.setImage(UIImage(named: "threedotdark"), for: .normal)
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            btnReject.setTitleColor(UIColor(hex: "#272727"), for: .normal)
            btnReject.backgroundColor = .white
            btnGallary.setImage(UIImage(named: "gallarydark"), for: .normal)
            btnSend.setImage(UIImage(named: "sendmsg"), for: .normal)
            txtVwMessage.textColor = UIColor.white
        }else{
            btnAppliedRequest.setImage(UIImage(named: "nextuser"), for: .normal)
            txtVwMessage.textColor = UIColor.black
            btnMore.setImage(UIImage(named: "more"), for: .normal)
            btnSend.setImage(UIImage(named: "send 1"), for: .normal)
            btnGallary.setImage(UIImage(named: "photos"), for: .normal)
            btnReject.setTitleColor(.white, for: .normal)
            btnReject.backgroundColor = .black
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            txtVwMessage.textColor = UIColor.black
        }
    }
    private func startTimer() {
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
                    self.getChatListing(messageId: self.messageId, isRead: 0)
                }else if  timeDifferenceString.contains("-") == true{
                    self.lblTimer.isHidden = true
                    self.heightTimerVw.constant = 0
                    self.vwSendMessage.isHidden = true
                    self.stopTimer()
                    self.getChatListing(messageId: self.messageId, isRead: 0)
                }
            } else {
                print("Error: Unable to parse start or end time strings.")
            }
        }
    }
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    private func getChatListing(messageId: String, isRead: Int) {
        var param = [String: Any]()
        // Prepare parameters for the API call based on whether the message is read or not
        param = ["messageId": messageId, "userId": Store.userDetail?["userId"] as? String ?? "", "isRead": isRead]
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
            self.sendMessageByMe = false
            Store.userIdRefer = data?[0].senders?.id
            // Handle the UI updates based on whether the user has applied
            if data?[0].isApplied == true {
                self.btnApply.setTitle("Applied", for: .normal)
                self.btnApply.backgroundColor = UIColor(hex: "#02A0E3")
                self.btnApply.setTitleColor(UIColor.white, for: .normal)
                self.btnApply.isUserInteractionEnabled = false
            } else {
                self.btnApply.setTitle("Apply", for: .normal)
                self.btnApply.backgroundColor = UIColor(hex: "#02A0E3")
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor.appPink.cgColor, UIColor.appPurple.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = self.view.bounds
                self.btnApply.layer.insertSublayer(gradientLayer, at: 0)
                self.btnApply.setTitleColor(UIColor.white, for: .normal)
                self.btnApply.isUserInteractionEnabled = true
            }
            // Handle the UI updates based on whether the user is referred
            if data?[0].isRefered == true {
                self.vwApply.isHidden = false
                self.vwApply.isHidden = true
            } else {
                self.vwApply.isHidden = true
                self.vwApply.isHidden = false
            }
            // Clear the previous chat data
            self.arrChat.removeAll()
            self.chatData.removeAll()
            // Update the chat data with the new data received
            self.chatData = data ?? []
            self.arrChat = data?[0].messageList ?? []
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
        self.btnMore.isHidden = true
        self.widthBtnMore.constant = 0
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.receiverId = self.arrChat[0].recipient?.id ?? ""
            self.vwSendMessage.isHidden = true
        } else {
            self.receiverId = self.arrChat[0].senderdetails?.id ?? ""
            self.vwSendMessage.isHidden = true
        }
    }
    private func updateUIForAcceptedStatus(data: [ChatModel]?) {
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
            self.btnMore.isHidden = false
            self.widthBtnMore.constant = 40
        } else {
            self.btnMore.isHidden = true
            self.widthBtnMore.constant = 0
            if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                self.proposalUserId = data?[0].recipients?.id ?? ""
            }else{
                self.proposalUserId = data?[0].senders?.id ?? ""
            }
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
    }
    private func updateUIDefaultStatus(data: [ChatModel]?) {
        if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
            self.vwSendMessage.isHidden = false
            self.vwUpdateHour.isHidden = true
            self.btnMore.isHidden = false
            self.widthBtnMore.constant = 40
            self.vwAcceptReject.isHidden = true
        }else{
            self.vwSendMessage.isHidden = true
            self.vwUpdateHour.isHidden = false
            self.btnMore.isHidden = true
            self.widthBtnMore.constant = 0
            self.vwAcceptReject.isHidden = false
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
                        self.vwAcceptReject.isHidden = true
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
                    self.vwAcceptReject.isHidden = true
                }
            }else if data?[0].isStatus == 2{
                self.vwSendMessage.isHidden = true
                self.vwUpdateHour.isHidden = true
                self.vwContinueChat.isHidden = true
                self.vwAcceptReject.isHidden = true
                self.vwApply.isHidden = true
                if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                    if data?[0].isReferedRequest == true{
                        self.lblRejected.isHidden = false
                        self.lblRejected.text = "You have rejected the invitation."
                    }else{
                        self.lblRejected.isHidden = false
                        self.lblRejected.text = "\(data?[0].recipients?.name ?? "") rejected  your invitation."
                    }
                }else{
                    if data?[0].isReferedRequest == true{
                        self.lblRejected.isHidden = false
                        self.lblRejected.text = "\(data?[0].senders?.name ?? "") rejected  your invitation."
                    }else{
                        self.lblRejected.isHidden = false
                        self.lblRejected.text = "You have rejected the invitation."
                    }
                }
            }else{
                self.vwSendMessage.isHidden = true
                self.vwUpdateHour.isHidden = true
                self.lblRejected.isHidden = true
                if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                    self.proposalUserId = data?[0].recipients?.id ?? ""
                }else{
                    self.proposalUserId = data?[0].senders?.id ?? ""
                }
                if data?[0].isRefered == true{
                    self.lblRejected.isHidden = true
                    self.vwAcceptReject.isHidden = true
                    self.vwApply.isHidden = false
                }else{
                    self.vwApply.isHidden = true
                    if data?[0].isReferedStatus == 0{
                        if data?[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                            self.vwAcceptReject.isHidden = true
                        }else{
                            self.vwAcceptReject.isHidden = false
                        }
                    }else{
                        self.vwAcceptReject.isHidden = true
                        self.lblRejected.isHidden = true
                    }
                }
            }
            self.vwContinueChat.isHidden = true
            //                            self.btnContinueChat.isHidden = true
            self.optionStatus = 1
        }else{
            if data?[0].endContract == 0{
                if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                    self.btnMore.isHidden = false
                    self.widthBtnMore.constant = 40
                    self.vwContinueChat.isHidden = false
                }else{
                    self.btnMore.isHidden = true
                    self.widthBtnMore.constant = 0
                    self.vwContinueChat.isHidden = true
                }
                if data?[0].continueChat == 0{
                    if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                        self.vwContinueChat.isHidden = false
                    }else{
                        self.vwContinueChat.isHidden = true
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
                    //                                    self.btnContinueChat.isHidden = true
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
                //                                self.btnContinueChat.isHidden = true
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
                self.vwAcceptReject.isHidden = true
            }
            self.vwApply.isHidden = true
            self.vwAcceptReject.isHidden = true
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
        self.tblVwChat.reloadData()
        self.tblVwChat.scrollToBottom(animated: true)
        WebService.hideLoader()
    }
    private func sendMessageData() {
        isRead = false
        WebSocketManager.shared.userListnerSuccess = {
            if self.sendMessageByMe == true {
                self.getChatListing(messageId: self.messageId, isRead: 1)
            } else {
                self.getChatListing(messageId: self.messageId, isRead: 0)
            }
        }
    }
    //MARK: - IBAction
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
    @IBAction func actionMore(_ sender: UIButton) {
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
    @IBAction func actionUploadPhotos(_ sender: UIButton) {
        chooseImage()
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
            if chatData[0].senders?.id == Store.userDetail?["userId"] as? String ?? ""{
                showChat = true
            }else{
                showChat = false
            }
            WebSocketManager.shared.sendMessage(dict: jsonObject)
            self.txtVwMessage.text  = ""
        }
    }
    @IBAction func actionPriceBtn(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContinueChatVC") as! ContinueChatVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isComingContinue = false
        vc.amount = self.userHourPrice
        vc.name = self.receiverName
        vc.callBack = {[weak self] in
            guard let self = self else { return }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = "Updated successfully"
            vc.callBack = {[weak self] in
                guard let self = self else { return }
                self.getChatListing(messageId: self.messageId, isRead: 1)
            }
            self.navigationController?.present(vc, animated: false)

            
        }
        self.navigationController?.present(vc, animated: true)
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
    @IBAction func actionAccept(_ sender: GradientButton) {
        viewModel.acceptRejectInvitationApi(messageId: messageId, isStatus: "1") { message in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message ?? ""
            vc.callBack = {[weak self] in
                guard let self = self else { return }
                self.getChatListing(messageId: self.messageId, isRead: 1)
            }
            self.navigationController?.present(vc, animated: false)
        }
    }
    @IBAction func actionReffer(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
        Store.selectReferData = ["notificationId":notificationId,"notesId":notesId,"messageId":messageId]
        Store.selectTabIndex = 0
        vc.isComing = true
        Store.isRefer = true
        self.navigationController?.pushViewController(vc, animated: true)
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
    @IBAction func actionContinueChat(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContinueChatVC") as! ContinueChatVC
        vc.isComingContinue = true
        vc.messageId = self.messageId
        vc.amount = self.anotherUserPrice
        vc.name = self.anotherUserName
        vc.userId = self.receiverId
        vc.modalPresentationStyle = .overFullScreen
        vc.callBack = {[weak self] in
            guard let self = self else { return }
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
    @IBAction func actionAppliedRequest(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedRequestsVC") as! AppliedRequestsVC
        vc.notesId = notesId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func chooseImage() {
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
    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
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
extension ChatScreenVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension ChatScreenVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrChat.count + 1
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
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProposalTVC") as! ProposalTVC
            if chatData.count > 0{
                cell.btnCross.addTarget(self, action: #selector(crossProposal), for: .touchUpInside)
                cell.btnCross.tag = indexPath.row
                cell.btnViewProposal.addTarget(self, action: #selector(viewProposal), for: .touchUpInside)
                cell.btnViewProposal.tag = indexPath.row
                cell.btnAccept.addTarget(self, action: #selector(acceptInvitation), for: .touchUpInside)
                cell.btnAccept.tag = indexPath.row
                cell.btnReject.addTarget(self, action: #selector(rejectInvitation), for: .touchUpInside)
                cell.btnReject.tag = indexPath.row
                if traitCollection.userInterfaceStyle == .dark {
                    cell.lblNameProposal.textColor = .white
                    cell.btnCross.setImage(UIImage(named: "whitecros"), for: .normal)
                    cell.stackVwProposal.cornerRadiusView = 5
                    cell.stackVwProposal.backgroundColor = UIColor(hex: "#161616")
                }else{
                    cell.lblNameProposal.textColor = .black
                    cell.btnCross.setImage(UIImage(named: "crossBlack"), for: .normal)
                    cell.stackVwProposal.cornerRadiusView = 5
                    cell.stackVwProposal.backgroundColor = UIColor(hex: "#5B5B5B").withAlphaComponent(0.07)
                }
                // Handle the UI updates based on whether the user is referred
                if chatData[0].isRefered == true {
                    cell.heightReferView.constant = 110
                    cell.lblReferName.text = chatData[0].referredBY?.name ?? ""
                    cell.lblReferDescription.text = chatData[0].referredBY?.about ?? ""
                    cell.txtVwProposal.text = chatData[0].proposedMessage ?? ""
                    //                                cell.textViewDidChange(self.txtVwProposal)
                    if chatData[0].referredBY?.profileImage == "" || chatData[0].referredBY?.profileImage == nil{
                        cell.imgVwUser.image = UIImage(named: "user")
                    }else{
                        cell.imgVwUser.imageLoad(imageUrl: chatData[0].referredBY?.profileImage ?? "")
                    }
                } else {
                    cell.heightReferView.constant = 0
                }
                if chatData[0].isReferedStatus == 1 {
                    // Check if the sender matches the user ID
                    if arrChat[indexPath.section].sender == (Store.userDetail?["userId"] as? String ?? "") {
                        self.receiverId = self.arrChat.first?.recipient?.id ?? ""
                        cell.lblDescriptionProposal.text = chatData[indexPath.section].senders?.about ?? ""
                        cell.txtVwProposal.text = chatData[indexPath.section].proposedMessage ?? ""
                        // Update background colors and borders
                        let backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                        cell.vwFirst.backgroundColor = backgroundColor
                        cell.vwSecond.backgroundColor = backgroundColor
                        cell.stackVwProposal.borderWid = 1
                        cell.stackVwProposal.borderCol = UIColor(hex: "#02A0E3")
                        cell.vwFirst.isHidden = false
                        cell.heightFirstVw.constant = 70
                        cell.vwSecond.isHidden = false
                        cell.heightAcceptReject.constant = 50
                        cell.btnViewProposal.isHidden = false
                        cell.btnCross.isHidden = true
                        if chatData[0].senders?.profileImage == "" || chatData[0].senders?.profileImage == nil{
                            cell.imgVwUser.image = UIImage(named: "user")
                        }else{
                            cell.imgVwUserProposal.imageLoad(imageUrl: chatData[0].senders?.profileImage ?? "")
                        }
                        cell.lblNameProposal.text = chatData[0].senders?.name ?? ""
                    } else {
                        self.receiverId = self.arrChat.first?.senderdetails?.id ?? ""
                        let backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                        cell.vwFirst.backgroundColor = backgroundColor
                        cell.vwSecond.backgroundColor = backgroundColor
                        cell.stackVwProposal.borderWid = 1
                        cell.stackVwProposal.borderCol = UIColor(hex: "#02A0E3")
                        // Show specific views
                        cell.vwFirst.isHidden = true
                        cell.vwSecond.isHidden = true
                        cell.heightAcceptReject.constant = 0
                        cell.lblAcceptRejectStatus.text = ""
                        cell.heightFirstVw.constant = 0
                        cell.btnViewProposal.isHidden = true
                        cell.btnCross.isHidden = true
                    }
                } else if chatData[0].isReferedStatus == 2 {
                    // Accepted status
                    cell.btnViewProposal.isHidden = false
                    cell.heightAcceptReject.constant = 0
                    cell.txtVwProposal.text = chatData[0].proposedMessage ?? ""
                    if chatData[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
                        cell.lblAcceptRejectStatus.text = ""
                        cell.lblAcceptRejectStatus.textColor = .clear
                        cell.vwFirst.isHidden = true
                        cell.heightFirstVw.constant = 0
                        cell.vwSecond.isHidden = true
                    } else {
                        cell.stackVwProposal.borderWid = 0
                        if showProposal{
                            cell.heightFirstVw.constant = 70
                            cell.vwFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                            cell.vwSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                            cell.stackVwProposal.borderWid = 1
                            cell.stackVwProposal.borderCol = UIColor(hex: "#02A0E3")
                            cell.vwSecond.isHidden = false
                            cell.btnCross.isHidden = false
                            cell.btnViewProposal.isHidden = true
                        }else{
                            cell.heightFirstVw.constant = 90
                            cell.stackVwProposal.borderWid = 0
                            cell.stackVwProposal.borderCol = .clear
                            cell.vwFirst.backgroundColor = UIColor(hex: "#5B5B5B").withAlphaComponent(0.07)
                            cell.vwSecond.backgroundColor = .clear
                            cell.vwSecond.isHidden = true
                            cell.btnCross.isHidden = true
                            cell.btnViewProposal.isHidden = false
                        }
                        if chatData[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                            if chatData[0].senders?.profileImage == "" || chatData[0].senders?.profileImage == nil{
                                cell.imgVwUser.image = UIImage(named: "user")
                            }else{
                                cell.imgVwUserProposal.imageLoad(imageUrl: chatData[0].senders?.profileImage ?? "")
                            }
                            cell.lblNameProposal.text = chatData[0].senders?.name ?? ""
                            cell.lblDescriptionProposal.text = chatData[0].senders?.about ?? ""
                            if chatData[0].senders?.isApproved == true{
                                cell.imgVwTick.isHidden = false
                            }else{
                                cell.imgVwTick.isHidden = true
                            }
                        }else{
                            if chatData[0].recipients?.profileImage == "" || chatData[0].recipients?.profileImage == nil{
                                cell.imgVwUser.image = UIImage(named: "user")
                            }else{
                                cell.imgVwUserProposal.imageLoad(imageUrl: chatData[0].recipients?.profileImage ?? "")
                            }
                            cell.lblNameProposal.text = chatData[0].recipients?.name ?? ""
                            cell.lblDescriptionProposal.text = chatData[0].recipients?.about ?? ""
                            if chatData[0].recipients?.isApproved == true{
                                cell.imgVwTick.isHidden = false
                            }else{
                                cell.imgVwTick.isHidden = true
                            }
                        }
                        cell.lblAcceptRejectStatus.text = "Accepted your refer request"
                        cell.lblAcceptRejectStatus.textColor = UIColor(hex: "#F10B80")
                    }
                } else if chatData[0].isReferedStatus == 3 {
                    cell.btnViewProposal.isHidden = false
                    cell.btnCross.isHidden = true
                    cell.txtVwProposal.text = chatData[0].proposedMessage ?? ""
                    if chatData[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? "" {
                        cell.vwFirst.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
                        cell.vwSecond.backgroundColor = UIColor(red: 0xFF/255.0, green: 0x8B/255.0, blue: 0x8B/255.0, alpha: 0.2)
                        cell.stackVwProposal.borderWid = 0
                        cell.vwFirst.isHidden = true
                        cell.heightFirstVw.constant = 0
                        cell.vwSecond.isHidden = true
                        cell.heightAcceptReject.constant = 0
                        cell.heightAcceptReject.constant = 0
                        if showProposal{
                            cell.lblAcceptRejectStatus.text = "Rejected your refer request"
                            cell.lblAcceptRejectStatus.textColor = UIColor(hex: "#F10B80")
                            cell.heightFirstVw.constant = 70
                            cell.vwFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                            cell.vwSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
                            cell.stackVwProposal.borderWid = 1
                            cell.stackVwProposal.borderCol = UIColor(hex: "#02A0E3")
                            cell.vwSecond.isHidden = false
                            cell.btnCross.isHidden = false
                            cell.btnViewProposal.isHidden = true
                        }else{
                            cell.heightFirstVw.constant = 90
                            cell.stackVwProposal.borderWid = 0
                            cell.stackVwProposal.borderCol = .clear
                            cell.vwFirst.backgroundColor = UIColor(hex: "#5B5B5B").withAlphaComponent(0.07)
                            cell.vwSecond.backgroundColor = .clear
                            cell.vwSecond.isHidden = true
                            cell.btnCross.isHidden = true
                            cell.btnViewProposal.isHidden = false
                            cell.lblAcceptRejectStatus.text = ""
                            cell.lblAcceptRejectStatus.textColor = .clear
                        }
                    } else {
                    }
                    if chatData[0].senders?.id ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                        cell.imgVwUserProposal.imageLoad(imageUrl: chatData[0].senders?.profileImage ?? "")
                        cell.lblNameProposal.text = chatData[0].senders?.name ?? ""
                        cell.lblDescriptionProposal.text = chatData[0].senders?.about ?? ""
                    }else{
                        cell.imgVwUserProposal.imageLoad(imageUrl: chatData[0].recipients?.profileImage ?? "")
                        cell.lblNameProposal.text = chatData[0].recipients?.name ?? ""
                        cell.lblDescriptionProposal.text = chatData[0].recipients?.about ?? ""
                    }
                } else {
                    cell.btnViewProposal.isHidden = false
                    cell.btnCross.isHidden = true
                    cell.vwFirst.isHidden = true
                    cell.vwSecond.isHidden = true
                }
            }
            return cell
        }else{
            let chat = arrChat[indexPath.section-1]
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
                let date = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
                if date == self.todayDate {
                    cell.lblTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                    cell.lblSendTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                }else if date == self.yesterDayDate{
                    cell.lblTime.text = "Yesterday"
                    cell.lblSendTime.text = "Yesterday"
                }else{
                    cell.lblTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                    cell.lblSendTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                }
                if chat.message == nil{
                    cell.vwMessage.isHidden = true
                }else{
                    cell.vwMessage.isHidden = false
                }
                cell.lblMessageTitle.text = chat.message ?? ""
                if chat.media?.count ?? 0 > 0 {
                    if indexPath.section-1 == 0{
                        cell.vwMessage.isHidden = true
                    }else{
                        if chat.message == nil{
                            cell.vwMessage.isHidden = true
                        }else{
                            cell.vwMessage.isHidden = false
                        }
                    }
                    cell.clsnVwMessage.isHidden = false
                    cell.vwImage.isHidden = false
                    cell.arrImage = chat.media ?? [String]()
                    cell.uiSet()
                }else{
                    cell.vwImage.isHidden = true
                    cell.clsnVwMessage.isHidden = true
                }
                cell.lblMessage.text = chat.message ?? ""
                if chat.sender == chat.senderdetails?.id {
                    if chat.senderdetails?.profileImage == "" || chat.senderdetails?.profileImage == nil{
                        cell.imgVwProfile.image = UIImage(named: "user")
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                    }
                    cell.lblName.text = chat.senderdetails?.name ?? ""
                    cell.lblSenderName.text = chat.senderdetails?.name ?? ""
                }else{
                    if chat.recipient?.profileImage == "" || chat.recipient?.profileImage == nil{
                        cell.imgVwProfile.image = UIImage(named: "user")
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                    }
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
                cell.lblMessageTitle.text = chat.message ?? ""
                let date = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
                if date == self.todayDate {
                    cell.lblTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                    cell.lblReceiverTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                }else if date == self.yesterDayDate{
                    cell.lblTime.text = "Yesterday"
                    cell.lblReceiverTime.text = "Yesterday"
                }else{
                    cell.lblTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                    cell.lblReceiverTime.text = self.string_date_ToDate((chat.createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                }
                if chat.media?.count ?? 0 > 0 {
                    cell.vwImage.isHidden = false
                    cell.clsnVwMessage.isHidden = false
                    if indexPath.section-1 == 0{
                        cell.vwMessage.isHidden = true
                    }else{
                        if chat.message == nil{
                            cell.vwMessage.isHidden = true
                        }else{
                            cell.vwMessage.isHidden = false
                        }
                    }
                    cell.arrImage = chat.media ?? [String]()
                    cell.uiSet()
                }else{
                    cell.vwMessage.isHidden = false
                    cell.vwImage.isHidden = true
                    cell.clsnVwMessage.isHidden = true
                }
                cell.lblMessage.text = chat.message ?? ""
                if chat.sender == chat.senderdetails?.id{
                    if chat.senderdetails?.profileImage == "" || chat.senderdetails?.profileImage == nil{
                        cell.imgVwProfile.image = UIImage(named: "user")
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                    }
                    cell.lblName.text = chat.senderdetails?.name ?? ""
                    cell.lblReceiverName.text = chat.senderdetails?.name ?? ""
                    if chat.senderdetails?.name?.contains("Admin") == true{
                        cell.lblName.textColor = UIColor(hex: "005A52")
                        cell.lblReceiverName.textColor = UIColor(hex: "005A52")
                    }else{
                        cell.lblName.textColor = UIColor(hex: "EF0B81")
                        cell.lblReceiverName.textColor = UIColor(hex: "EF0B81")
                    }
                }else{
                    if chat.recipient?.profileImage == "" || chat.recipient?.profileImage == nil{
                        cell.imgVwProfile.image = UIImage(named: "user")
                    }else{
                        cell.imgVwProfile.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                    }
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
    }
    @objc func crossProposal(sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tblVwChat.cellForRow(at: indexPath) as? ProposalTVC {
            if traitCollection.userInterfaceStyle == .dark {
                cell.vwFirst.borderWid = 0
                cell.vwFirst.borderCol = .clear
            }else{
                cell.vwFirst.borderWid = 1
                cell.vwFirst.borderCol = .white
            }
            self.showProposal = false
            cell.btnCross.isHidden = true
            cell.btnViewProposal.isHidden = false
            cell.vwSecond.isHidden = true
            cell.lblAcceptRejectStatus.isHidden = false
            cell.stackVwProposal.borderWid = 0
            cell.heightFirstVw.constant = 90
            cell.vwFirst.backgroundColor = UIColor(hex: "#5B5B5B").withAlphaComponent(0.07)
            cell.vwSecond.backgroundColor = .clear
            self.tblVwChat.reloadData()
        } else {
            print("Error: Could not retrieve the cell at index path \(indexPath)")
        }
    }
    @objc func viewProposal(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tblVwChat.cellForRow(at: indexPath) as? ProposalTVC {
            self.showProposal = true
            cell.btnViewProposal.isHidden = true
            cell.btnCross.isHidden = false
            cell.vwSecond.isHidden = false
            cell.lblAcceptRejectStatus.isHidden = true
            if traitCollection.userInterfaceStyle == .dark {
                cell.vwFirst.borderWid = 0
                cell.vwFirst.borderCol = .clear
                cell.lblDescriptionProposal.textColor = UIColor(hex: "#A7AAAA")
                cell.txtVwProposal.textColor = UIColor(hex: "#A7AAAA")
            } else {
                cell.vwFirst.borderWid = 0
                cell.vwFirst.borderCol = .clear
                cell.lblDescriptionProposal.textColor = UIColor(hex: "#A7AAAA")
                cell.txtVwProposal.textColor = UIColor(hex: "#A7AAAA")
            }
            cell.heightFirstVw.constant = 70
            cell.vwFirst.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            cell.vwSecond.backgroundColor = UIColor(red: 0xB8/255.0, green: 0xF4/255.0, blue: 0xFF/255.0, alpha: 0.34)
            cell.stackVwProposal.borderWid = 1
            cell.stackVwProposal.borderCol = UIColor(hex: "#02A0E3")
            self.tblVwChat.reloadData()
        } else {
            print("Error: Could not retrieve the cell at index path \(indexPath)")
        }
    }
    @objc func acceptInvitation(sender: UIButton) {
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
    @objc func rejectInvitation(sender: UIButton) {
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
}
//MARK: - KEYBOARD HANDLING
extension ChatScreenVC {
    private func keyboardHandling(){
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(MessageVC.self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomVw.constant = 10
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136,1334,1920, 2208:
                    print("1")
                    self.bottomVw.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.scrollToBottom(animated: true)
                case 2436,2688,1792:
                    print("2")
                    self.bottomVw.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.scrollToBottom(animated: true)
                default:
                    print("3")
                    self.bottomVw.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom)
                    self.scrollToBottom(animated: true)
                }
            }
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
    }
    //MARK: - TABLE VIEW SCROLL TO BOTTOM
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
            let numberOfSections = self.tblVwChat.numberOfSections
            let numberOfRows = self.tblVwChat.numberOfRows(inSection: numberOfSections - 1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
                self.tblVwChat.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
}
//MARK: - UITextViewDelegate
extension ChatScreenVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtVwMessage.textColor == UIColor.lightGray {
            txtVwMessage.text = nil
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtVwMessage.text.isEmpty {
            if traitCollection.userInterfaceStyle == .dark{
                txtVwMessage.textColor = UIColor.white
            }else{
                txtVwMessage.textColor = UIColor.lightGray
            }
            txtVwMessage.text = "Answer here..."
        }
    }
}
