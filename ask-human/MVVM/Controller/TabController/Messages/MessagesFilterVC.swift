//
//  MessagesFilterVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 29/05/24.
//

import UIKit

class MessagesFilterVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var lblNodata: UILabel!
    @IBOutlet var viewNotificationCount: UIView!
    @IBOutlet var lblNotificationCount: UILabel!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var viewInboxTitle: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var lblInbox: UILabel!
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var viewSearchBAck: UIView!
    @IBOutlet var btnCancel: GradientButton!
    @IBOutlet var txtfldSearch: UITextField!
    @IBOutlet var imgVwSearchIcon: UIImageView!
    @IBOutlet var tblVwList: UITableView!
    
    //MARK: - VARIABLES
    
    var usersListData = [GetRealTimeMsgModel]()
    var arrUserList = [Messagez]()
    var isFav = false
    var newMessage = ""
    var lastMessage = ""
    var loaderStatus:Bool = false
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        uiSet()
        self.setupRefreshControl()
    }
    
    func uiSet(){
        
        tblVwList.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "InboxListTVC", bundle: nil)
        tblVwList.register(nib, forCellReuseIdentifier: "InboxListTVC")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(forName: Notification.Name("tabInboxClick"), object: nil, queue: .main) { [weak self] notification in
            self?.methodOfReceivedList(notification: notification)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfGetNotificationCount(notification:)), name: Notification.Name("GetNotificationCount"), object: nil)
        
        NotificationCenter.default.addObserver(forName: Notification.Name("sendMessageListener"), object: nil, queue: .main) { [weak self] notification in
            self?.methodOfReceivedSendMesage(notification: notification)
        }
    }
    
    
    
    
    @objc func methodOfReceivedList(notification: Notification) {
        darkMode()
        isRead = false
        self.lblNodata.isHidden = true
        
        if WebSocketManager.shared.socket?.status == .connected {
            
            getNotificationCount()
            GetUserList(searchtext: "", isFilter: false)
            
        } else {
            WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
        }
    }
    
    @objc func methodOfReceivedSendMesage(notification: Notification) {
        isRead = false
        self.lblNodata.isHidden = true
        
        //        arrUserList.removeAll()
        if WebSocketManager.shared.socket?.status == .connected{
            
            getNotificationCount()
            GetUserList(searchtext: "", isFilter: false)
            
        }else{
            WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
            
        }
        
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tblVwList.refreshControl = refreshControl
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        
        GetUserList(searchtext: "", isFilter: false)
        
        sender.endRefreshing()
        
        
    }
    
    @objc func dismissKeyboardWhileClick() {
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwList.reloadData()
        }
        
    }
    
    @objc func methodOfGetNotificationCount(notification: Notification) {
        
        if WebSocketManager.shared.socket?.status == .connected{
            getNotificationCount()
            
        }else{
            
            WebSocketManager.shared.initialize(userId: Store.userDetail?["userId"] as? String ?? "")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        isRead = false
        arrUserList.removeAll()
        darkMode()
        
        
        if viewInboxData == false{
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
                self.getNotificationCount()
                self.GetUserList(searchtext: "", isFilter: false)
                WebService.hideLoader()
                viewInboxData = true
            }
        }else{
            self.getNotificationCount()
            self.GetUserList(searchtext: "", isFilter: false)
            
        }
        
    }
    
    func getInboxData(){
        WebSocketManager.shared.userListnerSuccess = {
            self.GetUserList(searchtext: "", isFilter: false)
        }
    }
    func getNotificationCount() {
        let param: parameters = ["userId": Store.userDetail?["userId"] as? String ?? ""]
        WebSocketManager.shared.getNotificationCount(dict: param)
        WebSocketManager.shared.notificationCount = { data in
            Store.notifyCount = data?[0].unreadCount ?? 0
            print("Received notification count data1111: \(data ?? [])")
            
            if data?[0].unreadCount ?? 0 > 0 {
                self.viewNotificationCount.isHidden = false
                self.lblNotificationCount.isHidden = false
                self.lblNotificationCount.text = data?[0].unreadCount ?? 0 > 9 ? "9+" : "\(data?[0].unreadCount ?? 0)"
            } else {
                self.viewNotificationCount.isHidden = true
                self.lblNotificationCount.isHidden = true
                self.lblNotificationCount.text = ""
            }
        }
        
    }
    
    func GetUserList(searchtext: String, isFilter: Bool) {
        let param: [String: Any] = [
            "userId": Store.userDetail?["userId"] as? String ?? "",
            "filter": isUserFilter,
            "search": searchtext
        ]
        print(param)
        
        func emitSocket() {
            WebSocketManager.shared.getUserList(dict: param)
            WebSocketManager.shared.inboxList = { data in
                
                showLoader = false
                viewInboxData = true
                
                guard let data = data else {
                    self.lblNodata.isHidden = false
                    self.arrUserList.removeAll()
                    self.tblVwList.reloadData()
                    return
                }
                
                if data.isEmpty || data[0].messages == nil {
                    if isFilter {
                        self.arrUserList.removeAll()
                        self.tblVwList.reloadData()
                    }
                    return
                }
                
                self.arrUserList.removeAll() // Clear list before adding new data
                
                for newUser in data {
                    if let messages = newUser.messages {
                        for newMessage in messages {
                            if let contractID = newMessage.contractID,
                               let index = self.arrUserList.firstIndex(where: { $0.contractID == contractID }) {
                                
                                self.arrUserList.remove(at: index)
                            }
                            
                            self.arrUserList.insert(newMessage, at: 0)
                        }
                    }
                }
                WebService.hideLoader()
                self.arrUserList.reverse()
                self.lblNodata.isHidden = !self.arrUserList.isEmpty
                self.tblVwList.reloadData()
            }
        }
        
        // Initial emit socket call
        emitSocket()
    }
    
    
    
    
    
    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            lblNodata.textColor = .white
            lblNotificationCount.textColor = .black
            imgVwSearchIcon.image = UIImage(named: "Icon - Search25 1")
            btnSearch.setImage(UIImage(named: "searchh"), for: .normal)
            btnFilter.setImage(UIImage(named: "filterWhite"), for: .normal)
            lblInbox.textColor = .white
            viewSearchBAck.backgroundColor = UIColor(hex: "#161616")
            viewSearchBAck.borderCol = .clear
            viewSearchBAck.borderWid = 0
            lblNotificationCount.textColor = .white
        }else{
            lblNodata.textColor = UIColor(hex: "#6F7179")
            lblNotificationCount.textColor = .white
            viewSearchBAck.borderCol = UIColor(hex: "#EBEBEB")
            viewSearchBAck.borderWid = 1
            viewSearchBAck.backgroundColor = .white
            imgVwSearchIcon.image = UIImage(named: "search")
            btnSearch.setImage(UIImage(named: "searchh"), for: .normal)
            btnFilter.setImage(UIImage(named: "filter"), for: .normal)
            lblInbox.textColor = .black
            lblNotificationCount.textColor = .white
        }
    }
    //MARK: -ButtonActions
    @IBAction func actionCancel(_ sender: UIButton) {
        viewSearch.isHidden = true
        viewInboxTitle.isHidden = false
        txtfldSearch.text = ""
        GetUserList(searchtext: "", isFilter: false)
    }
    @IBAction func actionSearch(_ sender: UIButton) {
        viewSearch.isHidden = false
        viewInboxTitle.isHidden = true
    }
    @IBAction func actionNotifications(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        vc.isComing = 1
        showLoader = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actionFiler(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 9
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 220, height: 210)
        vc.filterIndex = filterIndex
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selectIndex) in
            self.arrUserList.removeAll()
            filterIndex = index
            
            if selectIndex == "1"{
                isUserFilter = "0"
                
            }else if selectIndex == "2"{
                isUserFilter = "5"
            }else if selectIndex == "3"{
                isUserFilter = "2"
            }else if selectIndex == "4"{
                isUserFilter = "1"
            }else if selectIndex == "5"{
                isUserFilter = "3"
            }else{
                isUserFilter = ""
            }
            
            self.GetUserList(searchtext: "", isFilter: true)
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            let alternativeFormatter = DateFormatter()
            alternativeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return alternativeFormatter.date(from: dateString)
        }
    }
    
}
//MARK: - UITableViewDelegate
extension MessagesFilterVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxListTVC", for: indexPath) as! InboxListTVC
        
        if let poppingFont = UIFont(name: "Popping-Regular", size: 12) {
            cell.lblMessage.font = poppingFont
            cell.lblContractId.font = poppingFont
        }
        if arrUserList.count > 0 {
            let message = arrUserList[indexPath.row]
            if traitCollection.userInterfaceStyle == .dark {
                cell.lblName.textColor = .white
                if message.unreadCount ?? 0 > 0{
                    cell.lblMessage.textColor = .white
                }else{
                    cell.lblMessage.textColor = UIColor(hex: "#797C7B")
                }
                cell.mainVw.backgroundColor = .black
            }else{
                cell.mainVw.backgroundColor = .white
                cell.lblName.textColor = .black
                if message.unreadCount ?? 0 > 0{
                    cell.lblMessage.textColor = .black
                }else{
                    cell.lblMessage.textColor = UIColor(hex: "#797C7B")
                }
                
            }
            if Store.userDetail?["userId"] as? String ?? "" == message.sender?.id{
                
                if let createdAtDate = dateFromString(message.lastMessage?.createdAt ?? "") {
                    cell.lblTime.text = createdAtDate.timeAgoDisplay()
                } else {
                    cell.lblTime.text = "Invalid date"
                }
                if message.contractID == "" || message.contractID == nil{
                    cell.lblContractId.text = ""
                }else{
                    cell.lblContractId.text = "Contract Id : #\(message.contractID ?? "")"
                }
                
                cell.lblName.text = message.recipient?.name ?? ""
                if message.recipient?.profileImage == "" || message.recipient?.profileImage == nil{
                    cell.imgVwUser.image = UIImage(named: "user")
                }else{
                    cell.imgVwUser.imageLoad(imageUrl: message.recipient?.profileImage ?? "")
                }
                print("recipient:--\(message.recipient?.profileImage ?? "")")
                if message.isStatus == 2{
                    cell.lblMessage.text = "\(message.recipient?.name ?? "") Rejected  your invitation."
                }else{
                    if message.lastMessage?.message != nil{
                        cell.lblMessage.text = message.lastMessage?.message ?? ""
                    }else{
                        cell.lblMessage.text = "Media"
                    }
                }
                
                if message.unreadCount ?? 0 > 0{
                    cell.viewMessageCount.isHidden = false
                    cell.lblMessageCount.text = "\(message.unreadCount ?? 0)"
                }else{
                    cell.viewMessageCount.isHidden = true
                    cell.lblMessageCount.text = ""
                }
                if message.recipient?.isOnline == true{
                    cell.viewOnline.backgroundColor = UIColor(hex: "#F10B80")
                }else{
                    cell.viewOnline.backgroundColor = UIColor(hex: "#9A9E9C")
                }
            }else{
                
                if let createdAtDate = dateFromString(message.lastMessage?.createdAt ?? "") {
                    cell.lblTime.text = createdAtDate.timeAgoDisplay()
                } else {
                    cell.lblTime.text = "Invalid date"
                }
                if message.contractID == "" || message.contractID == nil{
                    cell.lblContractId.text = ""
                }else{
                    cell.lblContractId.text = "Contract Id : #\(message.contractID ?? "")"
                }
                
                cell.lblName.text = message.sender?.name ?? ""
                if message.isStatus == 2{
                    cell.lblMessage.text = "You have rejected the invitation request."
                }else{
                    if message.lastMessage?.message != nil{
                        cell.lblMessage.text = message.lastMessage?.message ?? ""
                    }else{
                        cell.lblMessage.text = "Media"
                    }
                }
                if message.sender?.profileImage == "" || message.sender?.profileImage == nil{
                    cell.imgVwUser.image = UIImage(named: "user")
                }else{
                    cell.imgVwUser.imageLoad(imageUrl: message.sender?.profileImage ?? "")
                }
                print("senderr:--\(message.sender?.profileImage ?? "")")
                if message.unreadCount ?? 0 > 0{
                    cell.viewMessageCount.isHidden = false
                    cell.lblMessageCount.text = "\(message.unreadCount ?? 0)"
                }else{
                    cell.viewMessageCount.isHidden = true
                    cell.lblMessageCount.text = ""
                }
                
                if message.sender?.isOnline == true{
                    cell.viewOnline.backgroundColor = UIColor(hex: "#F10B80")
                }else{
                    cell.viewOnline.backgroundColor = UIColor(hex: "#9A9E9C")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? InboxListTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell?.mainVw.backgroundColor = UIColor(hex: "#373737")
        }else{
            cell?.mainVw.backgroundColor = UIColor(hex: "#EF0B81").withAlphaComponent(0.04)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if let indexPath = indexPath {
            let cell = tableView.cellForRow(at: indexPath) as? InboxListTVC
            if self.traitCollection.userInterfaceStyle == .dark {
                cell?.mainVw.backgroundColor = .black
            } else {
                cell?.mainVw.backgroundColor = .white
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrUserList.count > 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
            vc.isComingDispute = "userList"
            isRead = true
            showLoader = true
            vc.notesId = arrUserList[indexPath.row].notesId ?? ""
            vc.messageId = arrUserList[indexPath.row].id ?? ""
            if Store.userDetail?["userId"] as? String ?? "" == Store.userDetail?["userId"] as? String ?? ""{
                vc.receiverId = arrUserList[indexPath.row].recipient?.id ?? ""
            }else{
                vc.receiverId = arrUserList[indexPath.row].sender?.id ?? ""
            }
            if arrUserList[indexPath.row].contractID == "" || arrUserList[indexPath.row].contractID == nil{
                vc.refered = true
            }else{
                vc.refered = false
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action1 = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            let param = ["messageId": self.arrUserList[indexPath.row].id ?? "", "userId": Store.userDetail?["userId"] as? String ?? ""]
            WebSocketManager.shared.deleteChat(dict: param)
            self.arrUserList.remove(at: indexPath.row)
            self.tblVwList.reloadData()
            WebService.showLoader()
            completionHandler(true)
        }
        if tableView.cellForRow(at: indexPath) is InboxListTVC {
            if arrUserList.count > 0 {
                if arrUserList[indexPath.row].favoriteBy?.contains(Store.userDetail?["userId"] as? String ?? "") == true {
                    isFav = true
                    print("contain")
                } else {
                    isFav = false
                    print("not contain")
                }
            }
        }
        action1.image = UIImage(named: "del")
        
        let action2 = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            let param = ["messageId": self.arrUserList[indexPath.row].id ?? "", "userId": Store.userDetail?["userId"] as? String ?? ""]
            WebSocketManager.shared.addFav(dict: param)
            WebService.showLoader()
            self.GetUserList(searchtext: "", isFilter: false)
            completionHandler(true)
        }
        action2.image = isFav ? UIImage(named: "unFav") : UIImage(named: "unfavv")
        
        if traitCollection.userInterfaceStyle == .dark {
            action1.backgroundColor = UIColor(hex: "#373737")
            action2.backgroundColor = UIColor(hex: "#373737")
        } else {
            action2.backgroundColor = UIColor(hex: "#EF0B81").withAlphaComponent(0.04)
            action1.backgroundColor = UIColor(hex: "#EF0B81").withAlphaComponent(0.04)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [action1, action2])
        configuration.performsFirstActionWithFullSwipe = false // Enable full swipe for the first action
        return configuration
    }
}
// MARK: - UITextFieldDelegate
extension MessagesFilterVC :UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = NSString(string: txtfldSearch.text!).replacingCharacters(in: range, with: string)
        self.arrUserList.removeAll()
        self.GetUserList(searchtext: newString, isFilter: true)
        
        return true
        
    }
}
// MARK: - Popup
extension MessagesFilterVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}
