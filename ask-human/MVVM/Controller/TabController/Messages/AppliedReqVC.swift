//
//  AppliedReqVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 30/05/24.
//

import UIKit

class AppliedReqVC: UIViewController {
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var tblVwList: UITableView!
    var viewModel = ReferVM()
    var arrRequests = [GetRequestsData]()
    var offSet = 1
    var limit = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwList.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "AppliedReqTVC", bundle: nil)
        tblVwList.register(nib, forCellReuseIdentifier: "AppliedReqTVC")
        
    }
    func getRequestsApi(){
        viewModel.getAppliedrequests(limit: limit, offset: offSet) { data in
            self.arrRequests = data ?? []
            if self.arrRequests.count > 0{
                self.lblNoData.isHidden = true
                
            }else{
                self.lblNoData.isHidden = false
            }
            self.tblVwList.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
        getRequestsApi()
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
            lblNoData.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
        }else{
            lblNoData.textColor = UIColor(hex: "#6F7179")
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }
}


//MARK: - UITableViewDelegate
extension AppliedReqVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrRequests.count > 0{
            return arrRequests.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppliedReqTVC", for: indexPath) as! AppliedReqTVC
            cell.viewBack.layer.shadowColor = UIColor.black.cgColor
            cell.viewBack.layer.shadowOffset = CGSize(width: 0, height: 4)
            cell.viewBack.layer.shadowRadius = 4
            cell.viewBack.layer.shadowOpacity = 0.12
            cell.viewBack.layer.masksToBounds = false
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblTitleName.textColor = .white
            cell.lblTitleStatus.textColor = .white
            cell.lblTitleMessage.textColor = .white
            cell.lblJobCreate.textColor = .white
            cell.lblJobCeateUserName.textColor = .white
            cell.viewBack.backgroundColor = UIColor(hex: "#161616")
            cell.viewBack.borderCol = .white
            cell.viewBack.borderWid = 1
            
        }else{
            cell.viewBack.borderCol = .clear
            cell.viewBack.borderWid = 0
            cell.viewBack.backgroundColor = UIColor(hex: "#F5F5F5")
            cell.lblTitleName.textColor = .black
            cell.lblTitleStatus.textColor = .black
            cell.lblTitleMessage.textColor = .black
            cell.lblJobCreate.textColor = .black
            cell.lblJobCeateUserName.textColor = .black
            
        }
        if arrRequests[indexPath.row].userID?.videoVerify == 1{
            cell.imgVwBlueTick.isHidden = false
            
        }else{
            cell.imgVwBlueTick.isHidden = true
            
        }
        if arrRequests[indexPath.row].referBy?.videoVerify == 1{
            cell.imgVwTickRefer.isHidden = false
            
        }else{
            cell.imgVwTickRefer.isHidden = true
            
        }

        cell.lblName.text = arrRequests[indexPath.row].referBy?.name ?? ""
        cell.lblMessage.text = arrRequests[indexPath.row].message ?? ""
        if arrRequests[indexPath.row].status == 2{
            cell.btnStatus.setTitle("Accepted", for: .normal)
            cell.btnStatus.setTitleColor(.white, for: .normal)
            cell.btnStatus.backgroundColor = UIColor(hex: "#F10B80")
        }else if arrRequests[indexPath.row].status == 3{
            cell.btnStatus.setTitle("Rejected", for: .normal)
            cell.btnStatus.setTitleColor(UIColor(hex: "#E30202"), for: .normal)
            cell.btnStatus.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.1216, alpha: 0.14)

        }else{
            cell.btnStatus.setTitleColor(UIColor(hex: "#02A0E3"), for: .normal)
            cell.btnStatus.backgroundColor = UIColor(hex: "#D9F1FF")

            cell.btnStatus.setTitle("Pending", for: .normal)
        }
        cell.btnViewDetail.tag = indexPath.row
        cell.btnViewDetail.addTarget(self, action: #selector(actionViewDetail), for: .touchUpInside)
        cell.lblJobCeateUserName.text = arrRequests[indexPath.row].userID?.name ?? ""
        cell.lblAboutJobCreated.text = arrRequests[indexPath.row].userID?.about ?? ""
        cell.imgVwUser.imageLoad(imageUrl: arrRequests[indexPath.row].userID?.profileImage ?? "")
        
        return cell
    }
    @objc func actionViewDetail(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "JobCreatedDetailVC") as! JobCreatedDetailVC
        vc.notesid = arrRequests[sender.tag].notes?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}

