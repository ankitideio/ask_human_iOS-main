//
//  ReferUserDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/05/24.
//

import UIKit
import UIKit
class ReferUserDetailVC: UIViewController {
  @IBOutlet var imgVwViewMOreLess: UIImageView!
  @IBOutlet var lblBtnViewMoreTitle: UILabel!
  @IBOutlet var btnViewMoreDetail: GradientButton!
  @IBOutlet var viewReviews: UIView!
  @IBOutlet var viewDescription: UIView!
  @IBOutlet var heightTblView: NSLayoutConstraint!
  @IBOutlet var tblVwReview: UITableView!
  @IBOutlet var btnBack: UIButton!
  @IBOutlet var btnReject: UIButton!
  @IBOutlet var lblTitleProposal: UILabel!
  @IBOutlet var lbltitleDescription: UILabel!
  @IBOutlet var lblDescription: UILabel!
  @IBOutlet var lblProposal: UILabel!
  @IBOutlet var btnAccept: GradientButton!
  @IBOutlet var imgVwBlurTick: UIImageView!
  @IBOutlet var lblUserName: UILabel!
  @IBOutlet var imgVwUser: UIImageView!
  @IBOutlet var lblScreenTitle: UILabel!
  @IBOutlet var lblTitleReview: UILabel!
  var arrReview = [Review]()
  var viewModelNote = NoteVM()
  var viewModel = ReferVM()
  var userId = ""
  var notesId = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    uiSet()
  }
  //MARK: - FUNCTION
  override func viewWillAppear(_ animated: Bool) {
    darkMode()
  }
  func uiSet(){
    getUserDetailApi()
    
  }
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)
      if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
        darkMode()
        tblVwReview.reloadData()
      }
    }
  func getUserDetailApi(){
    viewModelNote.getUserDetailApi(userId: userId) { data in
      self.lblUserName.text = data?.user?.name ?? ""
      self.lblDescription.text = data?.user?.about ?? ""
      self.imgVwUser.imageLoad(imageUrl: data?.user?.profileImage ?? "")
        self.arrReview = data?.user?.reviews ?? []
        if self.arrReview.count > 0 {
            let totalStars = self.arrReview.reduce(0) { $0 + ($1.starCount ?? 0) }
            let averageRating = Double(totalStars) / Double(self.arrReview.count)
            self.lblTitleReview.text = "Review(\(String(format: "%.1f", averageRating)))"
        } else {
            self.lblTitleReview.text = "Review(0)"
        }

      self.tblVwReview.reloadData()
        DispatchQueue.main.async {
            self.heightTblView.constant = self.tblVwReview.contentSize.height
        }

    }
  }
  func darkMode(){
    if traitCollection.userInterfaceStyle == .dark {
      lblBtnViewMoreTitle.textColor = .white
      btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
      lblScreenTitle.textColor = .white
      lblUserName.textColor = .white
      lblDescription.textColor = .white
      lblTitleReview.textColor = .white
      lbltitleDescription.textColor = .white
      lblProposal.textColor = .white
      lblTitleProposal.textColor = .white
      btnReject.backgroundColor = UIColor(hex: "#161616")
      tblVwReview.separatorColor = UIColor(hex: "#E3E3E3")
    }else{
      lblBtnViewMoreTitle.textColor = .white
      tblVwReview.separatorColor = UIColor(hex: "#E3E3E3")
      btnReject.backgroundColor = .black
      lblProposal.textColor = UIColor(hex: "#9E9E9E")
      lblTitleProposal.textColor = .black
      lbltitleDescription.textColor = .black
      lblTitleReview.textColor = .black
      lblDescription.textColor = UIColor(hex: "#9E9E9E")
      lblScreenTitle.textColor = .black
      lblUserName.textColor = .black
      btnBack.setImage(UIImage(named: "back"), for: .normal)
    }
    }
  @IBAction func actionBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  @IBAction func actionAccept(_ sender: UIButton) {
    viewModel.acceptRejectRefer(notesId: notesId, userId: userId, status: "2") { message in
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
      vc.modalPresentationStyle = .overFullScreen
      vc.message = message ?? ""
      vc.callBack = {
        SceneDelegate().notificationsRoot(selectTab: 1)
      }
      self.navigationController?.present(vc, animated: false)
    }
  }
  @IBAction func actionReject(_ sender: UIButton) {
    viewModel.acceptRejectRefer(notesId: notesId, userId: userId, status: "3") { message in
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
      vc.modalPresentationStyle = .overFullScreen
      vc.message = message ?? ""
      vc.callBack = {
        SceneDelegate().notificationsRoot(selectTab: 1)
      }
      self.navigationController?.present(vc, animated: false)
    }
  }
  @IBAction func actionViewMoreDetail(_ sender: GradientButton) {
      
    sender.isSelected = !sender.isSelected
    if sender.isSelected == true{
      lblBtnViewMoreTitle.text = "Show Less"
      imgVwViewMOreLess.image = UIImage(named: "lesss")
      if arrReview.count > 0{
        viewReviews.isHidden = false
      }else{
        viewReviews.isHidden = true
      }
      viewDescription.isHidden = false
    }else{
      imgVwViewMOreLess.image = UIImage(named: "viewLess")
      lblBtnViewMoreTitle.text = "View More Details"
      viewReviews.isHidden = true
      viewDescription.isHidden = true
    }
  }
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension ReferUserDetailVC: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if arrReview.count > 0{
      return arrReview.count
    }else{
      return 0
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVC", for: indexPath) as! ReviewTVC
    if traitCollection.userInterfaceStyle == .dark {
      cell.lblReviw.textColor = .white
    }else{
      cell.lblReviw.textColor = UIColor(hex: "#494949")
    }
    
    cell.ratingView.rating = arrReview[indexPath.row].starCount ?? 0
    cell.imgVwuser.imageLoad(imageUrl: arrReview[indexPath.row].reviewerProfileImage ?? "")
      let labelWidth = tableView.frame.width - 16
      let font = cell.lblReviw.font ?? UIFont.systemFont(ofSize: 17)
      let text = arrReview[indexPath.row].comment ?? ""
      let labelHeight = arrReview[indexPath.row].comment?.height(withConstrainedWidth: labelWidth, font: font)
      heightTblView.constant = labelHeight ?? 0
      cell.lblReviw.text = text
    return cell
  }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
