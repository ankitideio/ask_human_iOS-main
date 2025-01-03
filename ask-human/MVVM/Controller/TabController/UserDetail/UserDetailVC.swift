//
//  UserDetailVC.swift
//  ask-human
//
//  Created by meet sharma on 17/11/23.
//

import UIKit
import AlignedCollectionViewFlowLayout

class UserDetailVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var lblNoHashtag: UILabel!
    @IBOutlet var heightCollvw: NSLayoutConstraint!
    @IBOutlet var collVwhastag: UICollectionView!
    @IBOutlet var btnSentInvitationAndRefer: GradientButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var lblDataFound: UILabel!
    @IBOutlet var imgVwBlueTick: UIImageView!
    @IBOutlet weak var lblReviewCount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var heightTblVw: NSLayoutConstraint!
    @IBOutlet weak var tblVwReview: UITableView!
    
    //MARK: - variables
    var indexx = 0
    var viewModel = InvitationVM()
    var userId = ""
    var viewModelNote = NoteVM()
    var isSelect = 0
    var arrReview = [Review]()
    var isRefer = false
    var arrHashtags = [Hashtagz]()
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    //MARK: - FUNCTION
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
        getUserDetail()
    }
    func uiSet(){
        tblVwReview.estimatedRowHeight = 150
        tblVwReview.rowHeight = UITableView.automaticDimension
        if isRefer == true{
            btnSentInvitationAndRefer.setTitle("Send Refer", for: .normal)
        }else{
            btnSentInvitationAndRefer.setTitle("Send Invitation", for: .normal)
        }
        let nib2 = UINib(nibName: "HashtagCVC", bundle: nil)
        collVwhastag.register(nib2, forCellWithReuseIdentifier: "HashtagCVC")
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwhastag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        if let flowLayout = collVwhastag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 40)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                darkMode()
                tblVwReview.reloadData()
            }
        }
    private func updateCollectionViewHeight() {
        updateHeight(for: collVwhastag, constraint: heightCollvw)
        }
        
        private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
            collectionView.layoutIfNeeded()
            constraint.constant = collectionView.contentSize.height
        }

    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblName.textColor = .white
            lblReviewCount.textColor = .white
        }else{
            lblReviewCount.textColor = .black
            lblScreenTitle.textColor = .black
            lblName.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
        }
    func getUserDetail(){
        viewModelNote.getUserDetailApi(userId: userId) { data in
            if data?.user?.profileImage == "" || data?.user?.profileImage == nil{
                self.imgVwProfile.image = UIImage(named: "user")
               
            }else{
                self.imgVwProfile.imageLoad(imageUrl: data?.user?.profileImage ?? "")
            }
            self.arrReview = data?.user?.reviews ?? []
            if data?.user?.reviews?.count ?? 0 > 0{
                self.lblDataFound.text = ""
            }else{
                self.lblDataFound.text = "No Review Found!"
            }
            if data?.user?.reviews?.count ?? 0 > 0 {
                let averageRating = self.getAverageRating(reviews: data?.user?.reviews)
                self.lblReviewCount.text = "Reviews(\(averageRating))"
            }else{
                self.lblReviewCount.text = "Reviews(0.0)"
            }
          
            self.lblName.text = data?.user?.name ?? ""
            if data?.user?.videoVerify == 1{
                self.imgVwBlueTick.isHidden = false
            }else{
                self.imgVwBlueTick.isHidden = true
            }
            self.arrHashtags = data?.user?.hashtags ?? []
            if self.arrHashtags.count > 0{
                self.lblNoHashtag.isHidden = true
                self.updateCollectionViewHeight()
                self.updateheightCollVwHashtags()
            }else{
                self.heightCollvw.constant = 90
                self.lblNoHashtag.isHidden = false
            }
            self.collVwhastag.reloadData()
            self.tblVwReview.reloadData()
        }
    }
    func getAverageRating(reviews: [Review]?) -> String {
        let totalStars = reviews?.compactMap { $0.starCount }.reduce(0, +) ?? 0
        let averageRating = Double(totalStars) / Double(reviews?.count ?? 0)
        return String(format: "%.1f", averageRating)
    }

    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSentInvitation(_ sender: GradientButton) {
        if isRefer == true{
            viewModel.sendReferInvitation(notesId: Store.selectReferData?["notesId"] as? String ?? "", notificationId: Store.selectReferData?["notificationId"] as? String ?? "", referTo: ["\(userId)"], messageId: Store.selectReferData?["messageId"] as? String ?? "") { message in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                Store.selectReferData = nil
                vc.message = message ?? ""
                vc.callBack = {
                    SceneDelegate().tabBarHomeVCRoot()
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)
            }
           
        }else{
            viewModel.sendInvitationApi(inviteId: userId) { message in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.message = message ?? ""
                vc.callBack = {
                    SceneDelegate().tabBarHomeVCRoot()
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)
                
            }
        }
    }
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension UserDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewTVC", for: indexPath) as! UserReviewTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblReview.textColor = .white
        }else{
            cell.lblReview.textColor = UIColor(hex: "#494949")
        }
        cell.imgVeProfile.imageLoad(imageUrl: arrReview[indexPath.row].reviewerProfileImage ?? "")
        cell.ratingVw.rating = Double(arrReview[indexPath.row].starCount ?? 0)
        cell.lblReview.text = arrReview[indexPath.row].comment ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightTblVw.constant = tblVwReview.contentSize.height+5
    }
    
}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension UserDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHashtags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashtagCVC", for: indexPath) as! HashtagCVC
        cell.viewBtnDelete.isHidden = true
        cell.viewHashtagCount.isHidden = true
        cell.lblHashtag.textColor = .white
        cell.viewBAck.setGradientBackground(
            colors: [UIColor(hex: "#F00C82"), UIColor(hex: " #970D98")],
            startPoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1.0, y: 1.0)
        )
        cell.imgVwVerified.image = UIImage(named: "certificate-solid 2")
        if arrHashtags[indexPath.row].isVerified == 1{
            cell.widthImgVerify.constant = 14
        }else{
            cell.widthImgVerify.constant = 0
        }
        cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
        
        return cell
    }
    func updateheightCollVwHashtags() {
        let rows = ceil(CGFloat(arrHashtags.count) / 2)
        let newHeight = rows * 40 + max(0, rows - 1) * 8
        heightCollvw.constant = newHeight
    }

}
