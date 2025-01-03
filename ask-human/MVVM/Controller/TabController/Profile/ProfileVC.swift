//
//  ProfileVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

//MARK: - PROFILEDATA

struct ProfileData{
    let title:String?
    let img:String?
    init(title: String?, img: String?) {
        self.title = title
        self.img = img
    }
}


class ProfileVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet var lblEdit: UILabel!
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet var imgvwBlueTick: UIImageView!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var tblVwList: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnVideoVerification: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    
    //MARK: - VARIABLE
    
    var arrProfile = [ProfileData]()
    var viewModel = ProfileVM()
    var profileDetail: ProfileDetailData?
    var email = ""
    var phone:Int?
    var videoVerify = 0
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwList.showsVerticalScrollIndicator = false
        darkMode()
        uiSet()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwList.reloadData()
        }
        
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            viewBack.backgroundColor = UIColor(hex: "#161616")
            lblEdit.textColor = .white
            lblName.textColor = .white
            lblEmail.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(69.65)
            lblPhoneNo.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(69.65)
        }else{
            viewBack.backgroundColor = UIColor(hex: "#FBD3E8").withAlphaComponent(0.72)
            lblEdit.textColor = .black
            lblName.textColor = .black
            lblEmail.textColor = UIColor(hex: "#000000").withAlphaComponent(69.65)
            lblPhoneNo.textColor = UIColor(hex: "#000000").withAlphaComponent(69.65)
        }
    }
    //MARK: - FUNCTION
    
    func uiSet(){
     
        if Store.isSocialLogin == true{
            arrProfile.append(ProfileData(title: "Wallet", img: "waalt"))
            arrProfile.append(ProfileData(title: "Add Bank", img: "bank"))
            arrProfile.append(ProfileData(title: "Draft List", img: "draftt"))
            arrProfile.append(ProfileData(title: "Contact Us", img: "contact"))
            arrProfile.append(ProfileData(title: "All Contracts", img: "contracts"))
            arrProfile.append(ProfileData(title: "Notifications", img: "pinkNotification"))
             arrProfile.append(ProfileData(title: "Applied Requests", img: "requests"))
            arrProfile.append(ProfileData(title: "All Disputes", img: "dispute"))
            arrProfile.append(ProfileData(title: "Transaction History", img: "transection"))
            arrProfile.append(ProfileData(title: "Earnings", img: "dollr"))
            arrProfile.append(ProfileData(title: "Dark Mode", img: "Sun25"))
            arrProfile.append(ProfileData(title: "Logout", img: "setting"))
        }else{
            arrProfile.append(ProfileData(title: "Change Password", img: "lock"))
            arrProfile.append(ProfileData(title: "Change Phone Number", img: "changePhone"))
            arrProfile.append(ProfileData(title: "Change Email", img: "changeEmail"))
            arrProfile.append(ProfileData(title: "Wallet", img: "waalt"))
            arrProfile.append(ProfileData(title: "Add Bank", img: "bank"))
            arrProfile.append(ProfileData(title: "Draft List", img: "draftt"))
            arrProfile.append(ProfileData(title: "Contact Us", img: "contact"))
            arrProfile.append(ProfileData(title: "All Contracts", img: "contracts"))
            arrProfile.append(ProfileData(title: "Notifications", img: "pinkNotification"))
           arrProfile.append(ProfileData(title: "Applied Requests", img: "requests"))
            arrProfile.append(ProfileData(title: "All Disputes", img: "dispute"))
            arrProfile.append(ProfileData(title: "Transaction History", img: "transection"))
            arrProfile.append(ProfileData(title: "Earnings", img: "dollr"))
            arrProfile.append(ProfileData(title: "Dark Mode", img: "Sun25"))
            arrProfile.append(ProfileData(title: "Logout", img: "setting"))
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfGetProfile(notification:)), name: Notification.Name("getProfile"), object: nil)
        
    }
   
    @objc func methodOfGetProfile(notification:Notification){
        self.getProfileApi()
        
    }
    func getProfileApi(){
        viewModel.getProfileApi{ data in
            self.videoVerify = data?.data?.user?.videoVerify ?? 0
            if data?.data?.user?.videoVerify == 1{
                
                self.btnVideoVerification.isHidden = true
                self.imgvwBlueTick.isHidden = false
            }else if data?.data?.user?.videoVerify == 3{
                self.imgvwBlueTick.isHidden = true
                self.btnVideoVerification.isHidden = false
            }else{
                self.imgvwBlueTick.isHidden = true
                self.btnVideoVerification.isHidden = false
            }
        }
            self.email = Store.userDetail?["email"] as? String ?? ""
            self.phone = Int(Store.userDetail?["profile"] as? String ?? "")
         
            self.lblName.text = Store.userDetail?["userName"] as? String ?? ""
            self.lblEmail.text = Store.userDetail?["email"] as? String ?? ""
        if Store.userDetail?["phone"] as? Int ?? 0 != 0{
            self.lblPhoneNo.text = "\(Store.userDetail?["phone"] as? Int ?? 0)"
        }
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            self.imgVwProfile.image = UIImage(named: "user")
        }else{
            self.imgVwProfile.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
        }
       self.tblVwList.reloadData()
     

    }
    //MARK: - ACTION
    
    @IBAction func actionViewImage(_ sender: UIButton) {
        if Store.userDetail?["profile"] as? String ?? "" != ""{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isComing = true
            vc.imgString =  Store.userDetail?["profile"] as? String ?? ""
            self.navigationController?.present(vc, animated: true)
        }
    }
    @IBAction func actionIdentification(_ sender: UIButton) {
        if videoVerify == 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "reviewVideoVC") as! reviewVideoVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoIdentificationVC") as! VideoIdentificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    @IBAction func actionEdit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
        vc.isComing = 1
        vc.callBack = {
         self.getProfileApi()
      
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVC", for: indexPath) as! ProfileTVC
        cell.lblTitle.text = arrProfile[indexPath.row].title ?? ""
        cell.imgVwTitle.image = UIImage(named: arrProfile[indexPath.row].img ?? "")
        if Store.isSocialLogin == true{
            if indexPath.row == 9{
                cell.widthViewDarkMode.constant = 0
            }else{
                cell.widthViewDarkMode.constant = 0
            }
        }else{
            if indexPath.row == 12{
                cell.widthViewDarkMode.constant = 0
            }else{
                cell.widthViewDarkMode.constant = 0
            }
        }
      
        if traitCollection.userInterfaceStyle == .dark {
            cell.viewBack.backgroundColor = UIColor(hex: "#161616")
            cell.lblTitle.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(77.07)
            cell.iimgVwArrow.image = UIImage(named: "profileee")
            cell.viewDarkMode.borderWid = 1
            cell.viewDarkMode.borderCol = UIColor(hex: "#A2A2A2")
            cell.viewDarkMode.layer.cornerRadius = 14.2
            cell.widthViewDark.constant = 22
            cell.widthViewLight.constant = 0
        }else{
            cell.widthViewDark.constant = 0
            cell.widthViewLight.constant = 22
            cell.viewDarkMode.borderWid = 1
            cell.viewDarkMode.borderCol = UIColor(hex: "#B19DA7")
            cell.viewDarkMode.layer.cornerRadius = 14.2
            cell.iimgVwArrow.image = UIImage(named: "next")
            cell.viewBack.backgroundColor = UIColor(hex: "#FBD3E8").withAlphaComponent(0.72)
            cell.lblTitle.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Store.isSocialLogin == true{
            switch indexPath.row{
            case 0:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 1:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                vc.email = email
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 3:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DraftListVC") as! DraftListVC
                vc.isComing = 0
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
          
            case 5:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                vc.isComing = 0
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 6:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedReqVC") as! AppliedReqVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 7:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllDisputeVC") as! AllDisputeVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 8:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TransectionsVC") as! TransectionsVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 9:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EarningVC") as! EarningVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 10:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DarkModeVC") as! DarkModeVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 11:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)

            default:
                break
            }
        }else{
            switch indexPath.row{
            case 0:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 1:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPhoneNumberVC") as! AddNewPhoneNumberVC
                vc.phone = phone ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewEmailVC") as! AddNewEmailVC
                vc.email = email
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 3:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 5:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DraftListVC") as! DraftListVC
                vc.isComing = 0
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                vc.email = email
                self.navigationController?.pushViewController(vc, animated: true)
      
            case 7:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 8:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                vc.isComing = 0
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            case 9:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedReqVC") as! AppliedReqVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 10:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllDisputeVC") as! AllDisputeVC
                self.navigationController?.pushViewController(vc, animated: true)
           
                
            case 11:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TransectionsVC") as! TransectionsVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 12:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EarningVC") as! EarningVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 13:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DarkModeVC") as! DarkModeVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 14:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)
                
            default:
                break
            }
        }
    }
   
}
