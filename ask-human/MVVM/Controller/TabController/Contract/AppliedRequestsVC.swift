//
//  AppliedRequestsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/05/24.
//

import UIKit

class AppliedRequestsVC: UIViewController {
  @IBOutlet weak var lblNodata: UILabel!
  @IBOutlet var lblScreenTitle: UILabel!
  @IBOutlet var btnBack: UIButton!
  @IBOutlet var tblVwList: UITableView!
  var viewModel = ReferVM()
  var notesId = ""
  var arrAppliedUser = [AppliedUser]()
  override func viewDidLoad() {
    super.viewDidLoad()
      
    tblVwList.showsVerticalScrollIndicator = false
  }
  override func viewWillAppear(_ animated: Bool) {
    darkMode()
    getAppliedrequestsApi()
  }
  func getAppliedrequestsApi(){
    viewModel.getOwnerAppliedrequestsApi(notesId: notesId) { data in
      self.arrAppliedUser = data?.appliedUsers ?? []
        
      if self.arrAppliedUser.count > 0{
        self.lblNodata.isHidden = true
      }else{
        self.lblNodata.isHidden = false
      }
      self.tblVwList.reloadData()
    }
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
        lblNodata.textColor = .white
      btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
      lblScreenTitle.textColor = .white
      tblVwList.separatorColor = UIColor(hex: "#E3E3E3")
    }else{
        lblNodata.textColor = UIColor(hex: "#6F7179")
      tblVwList.separatorColor = UIColor(hex: "#E3E3E3")
      lblScreenTitle.textColor = .black
      btnBack.setImage(UIImage(named: "back"), for: .normal)
    }
    }
  @IBAction func actionBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension AppliedRequestsVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if arrAppliedUser.count > 0{
      return arrAppliedUser.count
    }else{
      return 0
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AppliedRequestsTVC") as! AppliedRequestsTVC
    if traitCollection.userInterfaceStyle == .dark {
      cell.lblName.textColor = .white
      cell.lblrating.textColor = .white
      cell.btnReject.backgroundColor = UIColor(hex: "#272727")
    }else{
      cell.btnReject.backgroundColor = .black
      cell.lblName.textColor = UIColor(hex: "#262626")
      cell.lblrating.textColor = UIColor(hex: "#878787")
    }
    cell.lblName.text = arrAppliedUser[indexPath.row].appliedBy?.name ?? ""
      let user = arrAppliedUser[indexPath.row].appliedBy
      cell.lblName.text = user?.name ?? ""
      if let reviews = user?.reviews, reviews.count > 0 {
          let totalStars = reviews.reduce(0) { $0 + ($1.starCount ?? 0) }
          let averageRating = Double(totalStars) / Double(reviews.count)
          cell.lblrating.text = "Review(\(String(format: "%.1f", averageRating)))"
      } else {
          cell.lblrating.text = "Review(\(0))"
      }

    cell.imgVwUser.imageLoad(imageUrl: arrAppliedUser[indexPath.row].appliedBy?.profileImage ?? "")
    cell.btnAccept.tag = indexPath.row
    cell.btnAccept.addTarget(self, action: #selector(ActionAccept), for: .touchUpInside)
    cell.btnReject.tag = indexPath.row
    cell.btnReject.addTarget(self, action: #selector(ActionReject), for: .touchUpInside)
    return cell
  }
  @objc func ActionAccept(sender:UIButton){
    viewModel.acceptRejectRefer(notesId: notesId, userId: arrAppliedUser[sender.tag].appliedBy?.id ?? "", status: "2") { message in
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
      vc.modalPresentationStyle = .overFullScreen
      vc.message = message ?? ""
      vc.callBack = {
        self.navigationController?.popViewController(animated: true)
      }
      self.navigationController?.present(vc, animated: false)
    }
  }
  @objc func ActionReject(sender:UIButton){
    viewModel.acceptRejectRefer(notesId: notesId, userId: arrAppliedUser[sender.tag].appliedBy?.id ?? "", status: "3") { message in
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
      vc.modalPresentationStyle = .overFullScreen
      vc.message = message ?? ""
      vc.callBack = {
        self.navigationController?.popViewController(animated: true)
      }
      self.navigationController?.present(vc, animated: false)
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferUserDetailVC") as! ReferUserDetailVC
    vc.userId = arrAppliedUser[indexPath.row].appliedBy?.id ?? ""
    self.navigationController?.pushViewController(vc, animated: true)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
