//
//  NotificationsVC.swift
//  askHuman
//
//  Created by IDEIO SOFT on 16/11/23.
//

import UIKit


class NotificationsVC: UIViewController {
    
    //MARK: - OUTLET
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    
    //MARK: - VARIABLE
    
    var arrToday = [Notificationss]()
    var arrThisWeek = [Notificationss]()
    var arrLastWeek = [Notificationss]()
    var viewModel = NOtificationVM()
    var arrNotification = [Notificationss]()
    
    var status = ""
    var arrSection = [String]()
    var page = 1
    var ifExist = false
    var isComing = 0
    let refreshControl = UIRefreshControl()
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.showsVerticalScrollIndicator = false
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblVw.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationApi(page: 1, showLoader: true, isStatus: true)
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            uiSet()
            
        }
    }
    
    @objc func refreshData() {
        DispatchQueue.main.async {
            self.notificationApi(page: 1, showLoader: false, isStatus: true)
           self.refreshControl.endRefreshing()
          }
           
       }
    func uiSet(){
   
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfGetNotifications(notification:)), name: Notification.Name("notifications"), object: nil)
        if traitCollection.userInterfaceStyle == .dark {
            lblNoData.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
        }else{
            lblNoData.textColor = UIColor(hex: "#6F7179")
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
        tblVw.reloadData()
    }
   
    
    @objc func methodOfGetNotifications(notification:Notification){
        if Store.notificationCount ?? 0 > 0 {
            
            self.notificationApi(page: 1, showLoader: false, isStatus: true)
            
        }else{
            
            self.notificationApi(page: 1, showLoader: true, isStatus: false)
        }
        
        
        
    }
    func notificationApi(page: Int, showLoader: Bool, isStatus: Bool) {
        
        viewModel.notificationsApi(page: page, limit: 10, showLoader: showLoader) { [weak self] data in
            WebService.hideLoader()
            guard let self = self else { return }
            self.arrSection.removeAll()
            self.arrToday.removeAll()
            self.arrThisWeek.removeAll()
            self.arrLastWeek.removeAll()
            Store.notificationCount = data?.data?.notifications?.count ?? 0
            Store.getNotificationData = data?.data?.notifications ?? []
            
            
            for notification in data?.data?.notifications ?? []{
                switch notification.timeCategory {
                case "today":
                    self.arrToday.append(notification)
                    self.arrSection.append("Today")
                case "thisweek":
                    self.arrThisWeek.append(notification)
                    self.arrSection.append("This Week")
                default:
                    self.arrLastWeek.append(notification)
                    self.arrSection.append("Last Week")
                }
            }
            
            // Remove duplicates from section array
            
            
            let orderedSet = NSOrderedSet(array: self.arrSection)
            let filteredArray = Array(orderedSet) as? [String] ?? []
            self.arrSection = filteredArray
            
            self.tblVw.reloadData()
            
            if data?.data?.notifications?.count ?? 0 > 0 {
                lblNoData.isHidden = true
                lblNoData.text = ""
            } else {
                
                lblNoData.isHidden = false
                lblNoData.text = "No data found!"
            }
            
        }
    }
    
    func updateLabelVisibility() {
        
    }
    
    //MARK: - ACTION
    
    @IBAction func actionBack(_ sender: UIButton) {
        if isComing == 0{
            SceneDelegate().tabBarProfileVCRoot()
        }else if isComing == 1{
            SceneDelegate().notificationsRoot(selectTab: 0)
        }else{
            SceneDelegate().notificationsRoot(selectTab: 1)
        }
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension NotificationsVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrSection.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return arrSection[section]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if arrSection.contains("Today"){
                return arrToday.count
            }else if arrSection.contains("This Week"){
                return arrThisWeek.count
            }else{
                return arrLastWeek.count
            }
            
        case 1:
            if arrSection.contains("This Week"){
                return arrThisWeek.count
            }else{
                return arrLastWeek.count
            }
        default:
            return arrLastWeek.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderTVC") as! SectionHeaderTVC
        if arrSection.count > 0{
            headerCell.lblWeeks.text = arrSection[section]
            if traitCollection.userInterfaceStyle == .dark {
                headerCell.lblWeeks.textColor = .white
            }else{
                headerCell.lblWeeks.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            }
            
        }
        
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if arrSection.count > 0{
            
                if arrSection[indexPath.section].contains("Today"){
                    
                    if arrToday[indexPath.row].status == "1"{
                        
                        
                        if arrToday[indexPath.row].isAcceptOrReject == 0{
//                            viewModel.readNotificationsApi(notificationId: arrToday[indexPath.row].id ?? "") {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                                isRead = true
//                            Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                                vc.isComing = false
                                vc.notificationId = self.arrToday[indexPath.row].id ?? ""
                            vc.notesId = self.arrToday[indexPath.row].notesID?.id ?? ""
                                self.navigationController?.pushViewController(vc, animated:true)
//                            }
                        }else{
                            showSwiftyAlert("", "Already acted on this invitation.", true)
                        }
                    }else if arrToday[indexPath.row].status == "3" || arrToday[indexPath.row].status == "6" || arrToday[indexPath.row].status == "2" || arrToday[indexPath.row].status == "25" || arrToday[indexPath.row].status == "26"{
//                        viewModel.readNotificationsApi(notificationId: arrToday[indexPath.row].id ?? "") {
                            // referrr
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                        isRead = true
                        vc.isComing = true
//                        Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                            vc.notificationId = self.arrToday[indexPath.row].id ?? ""
                        vc.notesId = self.arrToday[indexPath.row].notesID?.id ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }else if arrToday[indexPath.row].status == "9" || arrToday[indexPath.row].status == "10" || arrToday[indexPath.row].status == "8"{
//                        viewModel.readNotificationsApi(notificationId: arrToday[indexPath.row].id ?? "") {
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContractDetailVC") as! ContractDetailVC
                            vc.isComingNotification = true
                            vc.messageId = self.arrToday[indexPath.row].id ?? ""
//                            vc.notesId = self.arrToday[indexPath.row].notesID?.id ?? ""
                            vc.notificationId = self.arrToday[indexPath.row].id ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }
                }else if arrSection[indexPath.section].contains("This Week"){
                    if arrThisWeek[indexPath.row].status == "1"{
                        
                        
                            if arrThisWeek[indexPath.row].isAcceptOrReject == 0{
//                                viewModel.readNotificationsApi(notificationId: arrThisWeek[indexPath.row].id ?? "") {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                                isRead = true
//                                Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                                vc.isComing = false
                                    vc.notificationId = self.arrThisWeek[indexPath.row].id ?? ""
                                vc.notesId = self.arrThisWeek[indexPath.row].notesID?.id ?? ""
                                self.navigationController?.pushViewController(vc, animated:true)
//                            }
                        }else{
                            showSwiftyAlert("", "Already acted on this invitation.", true)
                        }
                    }else if arrThisWeek[indexPath.row].status == "3" || arrThisWeek[indexPath.row].status == "6" || arrThisWeek[indexPath.row].status == "2" || arrThisWeek[indexPath.row].status == "25" ||  arrThisWeek[indexPath.row].status == "26"{
//                        viewModel.readNotificationsApi(notificationId: arrThisWeek[indexPath.row].id ?? "") {
                            
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                        isRead = true
                            vc.isComing = true
                        
//                        Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                            vc.notesId = self.arrThisWeek[indexPath.row].notesID?.id ?? ""
                            vc.notificationId = self.arrThisWeek[indexPath.row].id ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }else if arrThisWeek[indexPath.row].status == "9" || arrThisWeek[indexPath.row].status == "10" || arrThisWeek[indexPath.row].status == "8"{
//                        viewModel.readNotificationsApi(notificationId: arrThisWeek[indexPath.row].id ?? "") {
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContractDetailVC") as! ContractDetailVC
                            vc.messageId = self.arrThisWeek[indexPath.row].id ?? ""
                            vc.notificationId = self.arrThisWeek[indexPath.row].id ?? ""
//                            vc.notesId = self.arrThisWeek[indexPath.row].notesID?.id ?? ""
                            vc.isComingNotification = true
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }
                }else{
                    if arrLastWeek[indexPath.row].status == "1"{
                        if arrLastWeek[indexPath.row].isAcceptOrReject == 0{
//                            viewModel.readNotificationsApi(notificationId: arrLastWeek[indexPath.row].id ?? "") {
                                
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                            isRead = true
//                            Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                                vc.isComing = false
                                vc.notificationId = self.arrLastWeek[indexPath.row].id ?? ""
                                vc.notesId = self.arrLastWeek[indexPath.row].notesID?.id ?? ""
                                self.navigationController?.pushViewController(vc, animated:true)
//                            }
                            }else{
                                showSwiftyAlert("", "Already acted on this invitation.", true)
                            
                        }
                    }else if arrLastWeek[indexPath.row].status == "3" || arrLastWeek[indexPath.row].status == "6" || arrLastWeek[indexPath.row].status == "2" || arrLastWeek[indexPath.row].status == "25" || arrLastWeek[indexPath.row].status == "26"{
//                        viewModel.readNotificationsApi(notificationId: arrLastWeek[indexPath.row].id ?? "") {
                            
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
                            isRead = true
                            vc.isComing = true
//                        Store.userIdRefer = arrToday[indexPath.row].notesID?.userID ?? ""
                            vc.notesId = self.arrLastWeek[indexPath.row].notesID?.id ?? ""
                            vc.notificationId = self.arrLastWeek[indexPath.row].id ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }else if arrLastWeek[indexPath.row].status == "9" || arrLastWeek[indexPath.row].status == "10" || arrLastWeek[indexPath.row].status == "8"{
//                        viewModel.readNotificationsApi(notificationId: arrLastWeek[indexPath.row].id ?? "") {
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContractDetailVC") as! ContractDetailVC
                            vc.messageId = self.arrLastWeek[indexPath.row].id ?? ""
                            vc.notificationId = self.arrThisWeek[indexPath.row].id ?? ""
//                            vc.notesId = self.arrLastWeek[indexPath.row].notesID?.id ?? ""
                            vc.isComingNotification = true
                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
                    }
                }
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTVC", for: indexPath) as! NotificationsTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.bgVw.layer.cornerRadius = 20
            cell.contentView.backgroundColor =  .black
            cell.bgVw.backgroundColor = UIColor(hex: "#161616")
            cell.bgVw.layer.shadowColor = UIColor.black.cgColor
            cell.bgVw.layer.shadowOpacity = 0.13
            cell.bgVw.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.bgVw.layer.shadowRadius = 14
            cell.bgVw.layer.masksToBounds = false
            cell.bgVw.layer.shadowPath = UIBezierPath(rect: cell.bgVw.bounds).cgPath
            cell.bgVw.layer.masksToBounds = false
            
            
        }else{
            cell.contentView.backgroundColor =  .white
            cell.bgVw.backgroundColor =  .white
            cell.contentView.layer.cornerRadius = 10
            cell.bgVw.layer.borderWidth = 1
            cell.bgVw.layer.borderColor = UIColor.clear.cgColor
            cell.bgVw.layer.masksToBounds = false
            cell.bgVw.layer.shadowColor = UIColor.black.cgColor
            cell.bgVw.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.bgVw.layer.shadowRadius = 6
            cell.bgVw.layer.cornerRadius = 20
            cell.bgVw.layer.shadowOpacity = 0.13
            cell.bgVw.layer.masksToBounds = false
        }
        if arrSection.count > 0{
            
            if arrSection[indexPath.section].contains("Today"){
                let message = arrToday[indexPath.row].message ?? ""
                let name = arrToday[indexPath.row].userID?.name ?? ""
                let status = arrToday[indexPath.row].status ?? ""
                let contactID = arrToday[indexPath.row].contractId ?? ""
                
                if status == "1" || status == "3" || status == "4" || status == "5"  || status == "10" || status == "11" {
                    let name = arrToday[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "6" || status == "7"{
                    let contactID = "#\(arrToday[indexPath.row].contractId ?? "")"
                    let username = arrToday[indexPath.row].username ?? ""
                    if let range = message.range(of: contactID),let range2 = message.range(of: username) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "17" || status == "18" || status == "22"{
                    let deductAmount = "$1"
                    let lastWord = getLastWord(from: arrToday[indexPath.row].message ?? "") ?? ""
                    if let range = message.range(of: deductAmount),let range2 = message.range(of: lastWord) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "2" || status == "26"{
                    let name = arrToday[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }else if status == "9"{
                    let contractIdd = "#\(arrToday[indexPath.row].contractId ?? "")"
                    let name = arrToday[indexPath.row].username ?? ""
                    
                    if let range = message.range(of: contractIdd),let range2 = message.range(of: name)  {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }
                else{
                    if let nameRange = message.range(of: name),
                       let messageIdRange = message.range(of: contactID) {
                        
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(nameRange, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(messageIdRange, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                    
                }
                
                cell.lblName.text = arrToday[indexPath.row].title ?? ""
                let dateString = arrToday[indexPath.row].createdAt ?? ""
                if let formattedDate = convertDateToDesiredFormat(dateString: dateString) {
                    cell.lblTiming.text = formattedDate
                } else {
                    cell.lblTiming.text = "Invalid date"
                }

                
                if traitCollection.userInterfaceStyle == .dark {
                    cell.lblName.textColor = UIColor(hex: "#FFFFFF")
                    cell.lblTiming.textColor = UIColor(hex: "#FFFFFF")
                }else{
                    cell.lblName.textColor = UIColor(hex:  "#222222")
                    cell.lblTiming.textColor = UIColor(hex: "#686868")
                }

                            }
            if arrSection[indexPath.section].contains("This Week"){
                
                cell.lblName.text = arrThisWeek[indexPath.row].title ?? ""
                let dateString = arrThisWeek[indexPath.row].createdAt ?? ""
                if let formattedDate = convertDateToDesiredFormat(dateString: dateString) {
                    cell.lblTiming.text = formattedDate
                } else {
                    cell.lblTiming.text = "Invalid date"
                }

                if traitCollection.userInterfaceStyle == .dark {
                    cell.lblName.textColor = UIColor(hex: "#FFFFFF")
                    cell.lblTiming.textColor = UIColor(hex: "#FFFFFF")
                }else{
                    cell.lblName.textColor = UIColor(hex: "#222222")
                    cell.lblTiming.textColor = UIColor(hex: "#686868")
                }
                //                cell.lblDescripion.text = arrThisWeek[indexPath.row].message ?? ""
                let message = arrThisWeek[indexPath.row].message ?? ""
                let name = arrThisWeek[indexPath.row].userID?.name ?? ""
                let status = arrThisWeek[indexPath.row].status ?? ""
                let contactID = arrThisWeek[indexPath.row].messageID ?? ""
                if status == "1" || status == "3" || status == "4" || status == "5"  || status == "10" || status == "11"{
                    let name = arrThisWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if  status == "6" || status == "7"{
                    let contactID = "#\(arrThisWeek[indexPath.row].contractId ?? "")"
                    let username = arrThisWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: contactID),let range2 = message.range(of: username){
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "17" || status == "18" || status == "22"{
                    let deductAmount = "$1"
                    let lastWord = getLastWord(from: arrThisWeek[indexPath.row].message ?? "") ?? ""
                    if let range = message.range(of: deductAmount),let range2 = message.range(of: lastWord) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "2"  || status == "26"{
                    let name = arrThisWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }else if status == "9"{
                    let name = arrThisWeek[indexPath.row].username ?? ""
                    let contractIdd = "#\(arrThisWeek[indexPath.row].contractId ?? "")"
                    if let range = message.range(of: contractIdd), let range2 = message.range(of: name){
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }
                else{
                    if let nameRange = message.range(of: name),
                       let messageIdRange = message.range(of: contactID) {
                        
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(nameRange, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(messageIdRange, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }
                
            }
            if arrSection[indexPath.section].contains("Last Week"){
                
                cell.lblName.text = arrLastWeek[indexPath.row].title ?? ""
                let dateString = arrLastWeek[indexPath.row].createdAt ?? ""
                if let formattedDate = convertDateToDesiredFormat(dateString: dateString) {
                    cell.lblTiming.text = formattedDate
                } else {
                    cell.lblTiming.text = "Invalid date"
                }

//                cell.lblTiming.text = formatDate(dateString: arrLastWeek[indexPath.row].updatedAt ?? "")
                if traitCollection.userInterfaceStyle == .dark {
                    cell.lblName.textColor = UIColor(hex: "#FFFFFF")
                    cell.lblTiming.textColor = UIColor(hex: "#FFFFFF")
                }else{
                    cell.lblName.textColor = UIColor(hex: "#222222")
                    cell.lblTiming.textColor = UIColor(hex: "#686868")
                }
                //                cell.lblDescripion.text = arrLastWeek[indexPath.row].message ?? ""
                let message = arrLastWeek[indexPath.row].message ?? ""
                let name = arrLastWeek[indexPath.row].userID?.name ?? ""
                let status = arrLastWeek[indexPath.row].status ?? ""
                let contactID = arrLastWeek[indexPath.row].contractId ?? ""
                if status == "1" || status == "3" || status == "4" || status == "5"  || status == "10" || status == "11"{
                    let name = arrLastWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "6" || status == "7"{
                    let contactID = "#\(arrLastWeek[indexPath.row].contractId ?? "")"
                    let username = arrLastWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: contactID),let range2 = message.range(of: username) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "17" || status == "18" || status == "22"{
                    let deductAmount = "$1"
                     let lastWord = getLastWord(from: arrLastWeek[indexPath.row].message ?? "") ?? ""
                    
                    if let range = message.range(of: deductAmount),let range2 = message.range(of: lastWord){
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }else if status == "2" || status == "26"{
                    let name = arrLastWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }else if status == "9"{
                    let contractIdd = "#\(arrLastWeek[indexPath.row].contractId ?? "")"
                    let name = arrLastWeek[indexPath.row].username ?? ""
                    if let range = message.range(of: contractIdd),let range2 = message.range(of: name) {
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(range, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(range2, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                        
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }

                }
                else{
                    
                    if let nameRange = message.range(of: name),
                       let messageIdRange = message.range(of: contactID) {
                        
                        let attributedString = NSMutableAttributedString(string: message)
                        
                        let boldFont = UIFont(name: "Poppins-Bold", size: cell.lblDescripion.font.pointSize) ?? cell.lblDescripion.font
                        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont ?? []]
                        
                        attributedString.addAttributes(boldAttributes, range: NSRange(nameRange, in: message))
                        attributedString.addAttributes(boldAttributes, range: NSRange(messageIdRange, in: message))
                        
                        cell.lblDescripion.attributedText = attributedString
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    } else {
                        cell.lblDescripion.text = message
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.lblDescripion.textColor = UIColor(hex: "#FFFFFF")
                        }else{
                            cell.lblDescripion.textColor = UIColor(hex: "#686868")
                        }
                    }
                }
            }
        }
        
        
        
        return cell
    }
    func getLastWord(from sentence: String) -> String? {
        // Split the sentence into words
        let words = sentence.split(separator: " ")
        
        // Return the last word if it exists
        return words.last.map(String.init)
    }

    func convertDateToDesiredFormat(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM, yyyy h:mm a"
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let formattedDateString = outputFormatter.string(from: date)
            return formattedDateString
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        if runningApi == false{
        //            if arrSection.contains("Today"){
        //                if indexPath.row == arrToday.count - 1 {
        //                    page += 1
        //                    self.notificationApi(page: page, showLoader: false)
        //                }
        //            }
        //            if arrSection.contains("This Week"){
        //                if indexPath.row == arrThisWeek.count - 1 {
        //                    page += 1
        //                    self.notificationApi(page: page, showLoader: false)
        //                }
        //            }
        //            if arrSection.contains("Last Week"){
        //                if indexPath.row == arrLastWeek.count - 1 {
        //                    page += 1
        //                    self.notificationApi(page: page, showLoader: false)
        //                }
        //            }
        //        }
    }
    
}
