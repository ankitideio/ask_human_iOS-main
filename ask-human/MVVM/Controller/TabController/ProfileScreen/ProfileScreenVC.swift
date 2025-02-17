//
//  ProfileScreenVC.swift
//  ask-human
//
//  Created by Ideio Soft on 10/01/25.
//

import UIKit


class ProfileScreenVC: UIViewController {

    @IBOutlet weak var tblVwProfile: UITableView!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var vwProfileImg: UIView!
    
    var arrHeader = ["Personal and Security","Professional details","Finances","Activities and Requests","Data and Privacy",""]
    var arrProfile = [ProfileData]()
    var viewModel = ProfileVM()
    var profileDetail: ProfileDetailData?
    var email = ""
    var phone:Int?
    var videoVerify = 0
    var arrContent = [ContentPolicies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfscrollView(notification:)), name: Notification.Name("scrollView"), object: nil)

        getUserDetails()
        tblVwProfile.showsHorizontalScrollIndicator = false
        tblVwProfile.showsVerticalScrollIndicator = false
        getProfileApi()

    }
    @objc func methodOfscrollView(notification:Notification){
        Store.ScrollviewCurrentOffset = 0
        tblVwProfile.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }

    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let storedOffset = Store.ScrollviewCurrentOffset ?? 0
        tblVwProfile.setContentOffset(CGPoint(x: 0, y: storedOffset), animated: false)
        
        }
    func getUserDetails(){
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            self.imgVwProfile.image = UIImage(named: "user")
        }else{
            self.imgVwProfile.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
        }
        self.email = Store.userDetail?["email"] as? String ?? ""
        self.phone = Int(Store.userDetail?["profile"] as? String ?? "")
        
        self.lblName.text = Store.userDetail?["userName"] as? String ?? ""
        self.lblEmail.text = Store.userDetail?["email"] as? String ?? ""
        if Store.userDetail?["phone"] as? Int ?? 0 != 0{
            self.lblPhoneNo.text = "\(Store.userDetail?["phone"] as? Int ?? 0)"
        }

    }
    func getProfileApi(){
        viewModel.getProfileApi{ data in
            self.videoVerify = data?.data?.user?.videoVerify ?? 0
        }

    }
    @IBAction func actionEdit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
        vc.isComing = false
        vc.callBack = {
         self.getProfileApi()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isComing = 1
        self.navigationController?.present(vc, animated: false)
    }
}

extension ProfileScreenVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print("TableView Scroll Offset: \(yOffset)")
        Store.ScrollviewCurrentOffset = yOffset
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrHeader.count // One section per header item
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           // Dequeue the custom header cell
         guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTVC") as? ProfileHeaderTVC else {
               return nil
           }
         if section == tableView.numberOfSections - 1 {
             headerCell.btnLogout.isHidden = false
         }else{
             headerCell.lblHeader.text = arrHeader[section]
         }
         

           return headerCell.contentView
       }

       // Section Header Height
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50 // Set your desired height
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has one row
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Adjust row height automatically
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileScreenTVC", for: indexPath) as! ProfileScreenTVC
        cell.uiSet(for: indexPath.section)
        cell.callBack = { (index,section) in
            if section == 0{
                if index == 0{
                    if Store.userDetail?["document"] as? String ?? "" == ""{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdNotVerifiedVC") as! IdNotVerifiedVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdVerifiedVC") as! IdVerifiedVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    if self.videoVerify == 3{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "reviewVideoVC") as! reviewVideoVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoIdentificationVC") as! VideoIdentificationVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                }
            }else if section == 1{
                if index == 0{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourlyPriceVC") as! HourlyPriceVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileHashtagsVC") as! ProfileHashtagsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if section == 2{
                if index == 0{
              
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else if index == 1{
                
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
                    self.navigationController?.pushViewController(vc, animated: true)
              
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TransectionsVC") as! TransectionsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if section == 3{
                if index == 0{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedReqVC") as! AppliedReqVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index == 1{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllDisputeVC") as! AllDisputeVC
                    self.navigationController?.pushViewController(vc, animated: true)
              
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                  
                }
            }else if section == 4{
                if index == 0{
              
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteAccountVC") as! DeleteAccountVC
                    vc.type = "delete"
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index == 1{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                    vc.isComing = 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index == 2{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DarkModeVC") as! DarkModeVC
                    self.navigationController?.pushViewController(vc, animated: true)

                }else if index == 3{
                    self.viewModel.getContentPolicyAboutApi(type: "help"){ data in
                        self.arrContent = data?.content ?? []
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
                            vc.arrOption = self.arrContent
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }else if index == 4{
                    self.viewModel.getContentPolicyAboutApi(type: "about"){ data in
                        self.arrContent = data?.content ?? []
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyAndAboutVC") as! PolicyAndAboutVC
                            vc.arrContent = self.arrContent
                            vc.type = "about"
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }else if index == 5{
                    self.viewModel.getContentPolicyAboutApi(type: "privacy_policy"){ data in
                        self.arrContent = data?.content ?? []
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyAndAboutVC") as! PolicyAndAboutVC
                            vc.arrContent = self.arrContent
                            vc.type = "privacy_policy"
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }

                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                    vc.email = self.email
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        return cell
    }

}
