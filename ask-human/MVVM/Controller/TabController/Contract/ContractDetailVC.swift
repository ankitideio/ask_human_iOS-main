//
//  ContractDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 27/11/23.
//

import UIKit
import AVFoundation
import AVKit

class ContractDetailVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet var viewRequestsBack: UIView!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnThreeDot: UIButton!
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblVwMessage: UITableView!
    @IBOutlet weak var imgVwtick: UIImageView!
    
    @IBOutlet var lblRequestCount: UILabel!
    @IBOutlet var btnRequests: UIButton!
    
    //MARK: - VARIABLES
    var index = 0
    var messageId = ""
    var receiverId = ""
    var notificationId = ""
    var profileImg = ""
    var userName = ""
    var viewModel = InvitationVM()
    var callBack:(()->())?
    var chatData = [ChatModel]()
    var arrChat = [MessageListChat]()
    var isVerify = 0
    var receiverName = ""
    var receiverPrice = 0
    var optionStatus = 1
    var todayDate = ""
    var yesterDayDate = ""
    var isComingNotification = false
    var viewModelMessage = MessageVM()
    var getUserName = false
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
        let date = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let todayDates = dateFormatter.string(from: date)
        let yesterdayDates = dateFormatter.string(from: yesterday)
        self.todayDate = todayDates
        self.yesterDayDate = yesterdayDates
        print("Today's Date: \(todayDates)")
        print("Yesterday's Date: \(yesterdayDates)")
        
        lblUserName.text = userName
        imgVwUser.imageLoad(imageUrl: profileImg)
        if isComingNotification == true{
            self.viewModelMessage.getMessageId(messageId: self.notificationId) { data in
                self.getChatListing(messageId: data?.messageID ?? "")
                self.sendMessageData()
            
                WebSocketManager.shared.joinRoom(dict: ["messageId":data?.messageID ?? ""])
                self.messageId = data?.messageID ?? ""
                
            }
        }else{
            if Store.authKey != "" {
                
                self.getChatListing(messageId: messageId)
                self.sendMessageData()
               
                WebSocketManager.shared.joinRoom(dict: ["messageId": messageId])
            }

        }
            
        if isVerify == 1{
            imgVwtick.isHidden = false
        }else{
            imgVwtick.isHidden = true
        }
    
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnThreeDot.setImage(UIImage(named: "threedotdark"), for: .normal)
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblUserName.textColor = .white
            btnRequests.setImage(UIImage(named: "requestDark"), for: .normal)
            
        }else{
            btnRequests.setImage(UIImage(named: "request"), for: .normal)
            lblUserName.textColor = .black
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            btnThreeDot.setImage(UIImage(named: "more"), for: .normal)
        }
    }
    private func getChatListing(messageId:String){
        let param:parameters = ["messageId":messageId,"userId":Store.userDetail?["userId"] as? String ?? ""]
        WebSocketManager.shared.getChatListing(dict:param)
        WebSocketManager.shared.chatData = { data in
            
            self.chatData.removeAll()
            self.chatData = data ?? []
            self.arrChat = data?[0].messageList ?? []
            self.tblVwMessage.reloadData()
            self.tblVwMessage.scrollToBottom(animated: true)
            if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                self.receiverId = self.arrChat[0].recipient?.id ?? ""
                self.receiverName = data?[0].recipients?.name ?? ""
                self.receiverPrice = data?[0].recipients?.hoursPrice ?? 0
                
            }else{
                self.receiverId = self.arrChat[0].senderdetails?.id ?? ""
                self.receiverName = data?[0].senders?.name ?? ""
                self.receiverPrice = data?[0].senders?.hoursPrice ?? 0
            }
            
            
            if data?[0].messageList?.count ?? 0 == 1{
                if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                    self.btnThreeDot.isHidden = false
                    
                }else{
                    self.btnThreeDot.isHidden = true
               
                }
             
                self.optionStatus = 1
            }else{
                if data?[0].endContract == 0{
                    if data?[0].messageList?[0].sender ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                        self.btnThreeDot.isHidden = false
                    }else{
                        self.btnThreeDot.isHidden = true
                        
                    }
                    if data?[0].continueChat == 0{
                       
                        if data?[0].isDispute == 0{
    
                            self.optionStatus = 1
                        }else{
                            self.optionStatus = 2
                        }
                   
                      
                    }else{
                        self.optionStatus = 3
                      
                    }
                }else{
                    self.optionStatus = 4
                    self.btnThreeDot.isHidden = false
                 
                }
                
            }
        }
    }
    private func sendMessageData(){
        
        WebSocketManager.shared.userListnerSuccess = {
            
            self.getChatListing(messageId: self.messageId)
        }
        
    }
   
    //MARK: - BUTTON ACTIONS
    @IBAction func actionThreeDots(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        vc.modalPresentationStyle = .popover
        vc.isStatus = optionStatus
        if optionStatus == 1{
            vc.preferredContentSize = CGSize(width: 200, height: 123)
        }else if optionStatus == 2{
            vc.preferredContentSize = CGSize(width: 200, height: 82)
        }else if optionStatus == 3{
            vc.preferredContentSize = CGSize(width: 200, height: 82)
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContinueChatVC") as! ContinueChatVC
                vc.messageId = self.messageId
                vc.amount = self.receiverPrice
                vc.name = self.receiverName
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
   
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
// MARK: - Popup

extension ContractDetailVC : UIPopoverPresentationControllerDelegate {
    
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      
    return .none
      
  }
    
  //UIPopoverPresentationControllerDelegate
  func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
  }
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension ContractDetailVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
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
        print("Message----",chat.message ?? "")
        if sentByMe{
            print("me")
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendMessageTVC") as! SendMessageTVC
            let date = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
            if date == self.todayDate {
                cell.lblTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                
                cell.lblSendTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
            }else if date == self.yesterDayDate{
                cell.lblTime.text = "Yesterday"
                
                cell.lblSendTime.text = "Yesterday"
            }else{
                cell.lblTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                
                cell.lblSendTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
            }
         
            if arrChat[indexPath.section].message == nil{
                cell.vwMessage.isHidden = true
            }else{
                cell.vwMessage.isHidden = false
            }
            if arrChat[indexPath.section].media?.count ?? 0 > 0 {
                cell.lblMessageTitle.text = arrChat[indexPath.section].message ?? ""
                cell.clsnVwMessage.isHidden = false
                cell.vwImage.isHidden = false
                cell.arrImage = arrChat[indexPath.section].media ?? [String]()
                cell.uiSet()
            }else{
                cell.vwImage.isHidden = true
                cell.clsnVwMessage.isHidden = true
            }
            
            cell.lblMessage.text = arrChat[indexPath.section].message ?? ""
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
            print("other")
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveMessageTVC") as! ReceiveMessageTVC
          
            cell.lblMessageTitle.text = arrChat[indexPath.section].message ?? ""
            let date = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .slashDate)
            if date == self.todayDate {
                cell.lblTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
                
                cell.lblReceiverTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .timeAmPm)
            }else if date == self.yesterDayDate{
                cell.lblTime.text = "Yesterday"
                
                cell.lblReceiverTime.text = "Yesterday"
            }else{
                cell.lblTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
                
                cell.lblReceiverTime.text = string_date_ToDate((arrChat[indexPath.section].createdAt ?? ""), currentFormat: .BackEndFormat, requiredFormat: .DateAndTime)
            }
            if arrChat[indexPath.section].media?.count ?? 0 > 0 {
                cell.vwImage.isHidden = false
                cell.clsnVwMessage.isHidden = false
                if indexPath.section == 0{
                    cell.vwMessage.isHidden = true
                }else{
                    if arrChat[indexPath.section].message == nil{
                        cell.vwMessage.isHidden = true
                    }else{
                        cell.vwMessage.isHidden = false
                    }
                }
                cell.arrImage = arrChat[indexPath.section].media ?? [String]()
                cell.uiSet()
            }else{
                cell.vwMessage.isHidden = false
                cell.vwImage.isHidden = true
                cell.clsnVwMessage.isHidden = true
            }
           
            cell.lblMessage.text = arrChat[indexPath.section].message ?? ""
            if chat.sender == chat.senderdetails?.id{
                cell.imgVwProfile.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                cell.lblName.text = chat.senderdetails?.name ?? ""
              
                cell.lblReceiverName.text = chat.senderdetails?.name ?? ""
                if arrChat[indexPath.section].senderdetails?.name?.contains("Admin") == true{
                    cell.vwReceiverMsg.backgroundColor = UIColor(hex: "1F009688").withAlphaComponent(0.07)
                    cell.lblName.textColor = UIColor(hex: "005A52")
                    cell.vwReceiverImg.backgroundColor = UIColor(hex: "1F009688").withAlphaComponent(0.07)
                    cell.lblReceiverName.textColor = UIColor(hex: "005A52")
                }else{
                    cell.vwReceiverMsg.backgroundColor = UIColor(hex: "EF0B81").withAlphaComponent(0.07)
                    cell.lblName.textColor = UIColor(hex: "EF0B81")
                    cell.vwReceiverImg.backgroundColor = UIColor(hex: "EF0B81").withAlphaComponent(0.07)
                    cell.lblReceiverName.textColor = UIColor(hex: "EF0B81")
                    if getUserName == false{
                        lblUserName.text = chat.senderdetails?.name ?? ""
                        imgVwUser.imageLoad(imageUrl: chat.senderdetails?.profileImage ?? "")
                        getUserName = true
                    }
                }
            }else{
                cell.imgVwProfile.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                cell.lblName.text = chat.recipient?.name ?? ""
                cell.lblReceiverName.text = chat.recipient?.name ?? ""
                if getUserName == false{
                lblUserName.text = chat.recipient?.name ?? ""
                imgVwUser.imageLoad(imageUrl: chat.recipient?.profileImage ?? "")
                getUserName = true
                }
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

//MARK: - KEYBOARD HANDLING
extension ContractDetailVC {

    //MARK: - TABLE VIEW SCROLL TO BOTTOM
    func tableViewScrollToBottom() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            let numberOfSections = self.tblVwMessage.numberOfSections
            let numberOfRows = self.tblVwMessage.numberOfRows(inSection: 0)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections - 1))
                self.tblVwMessage.scrollToRow(at: indexPath, at: .bottom, animated: false )
            }
        }
    }
}
