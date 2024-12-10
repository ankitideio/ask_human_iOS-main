//
//  JobCreatedDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 25/06/24.
//

import UIKit

class JobCreatedDetailVC: UIViewController {
    
    @IBOutlet weak var lblQuestionTitle: UILabel!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewUserDetail: UIView!
    @IBOutlet weak var heightCollVw: NSLayoutConstraint!
    @IBOutlet weak var collvwImgs: UICollectionView!
    @IBOutlet var lblRejectCount: UILabel!
    @IBOutlet var lblReferCount: UILabel!
    @IBOutlet var lblCreatedIt: UILabel!
    @IBOutlet var imgVwBluetick: UIImageView!
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    var notesid = ""
    var viewModel = ReferVM()
    var arrImgs = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailApi()
        darkMode()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            viewUserDetail.borderCol = .white
            lblQuestionTitle.textColor = .white
            viewUserDetail.borderWid = 1
            
        }else{
            lblQuestionTitle.textColor = .black
            viewUserDetail.borderCol = .clear
            viewUserDetail.borderWid = 0
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            viewUserDetail.layer.shadowColor = UIColor.black.cgColor
            viewUserDetail.layer.shadowOffset = CGSize(width: 0, height: 4)
            viewUserDetail.layer.shadowRadius = 4
            viewUserDetail.layer.shadowOpacity = 0.12
            viewUserDetail.layer.masksToBounds = false

        }
    }
    
    func getDetailApi(){
        viewModel.getJobCreatedDetail(notesId: notesid) { data in
            self.lblQuestion.text = data?[0].notes?[0].note ?? ""
            self.lblName.text = data?[0].userID?[0].name ?? ""
            self.imgVwUser.imageLoad(imageUrl: data?[0].userID?[0].profileImage ?? "")
            self.arrImgs = data?[0].notes?[0].media ?? []
            self.heightCollVw.constant = self.arrImgs.count > 0 ? 144 : 0
            
            
            if self.traitCollection.userInterfaceStyle == .dark {
                self.lblQuestion.textColor = .white
                self.lblName.textColor = .white
                self.lblScreenTitle.textColor = .white
                if let createdAtString = data?[0].notes?[0].createdAt {
                    let formattedDate = self.formatDate(dateString: createdAtString)
                    self.applyAttributedTextDarkMode(to: self.lblCreatedIt,
                                                     title: "Created it  :  ",
                                                     value: formattedDate)
                }
                
                let referCount = data?[0].referCount ?? 0
                self.applyAttributedTextDarkMode(to: self.lblReferCount,
                                                 title: "Refer count  :  ",
                                                 value: "\(referCount)")
                
                let rejectCount = data?[0].rejectCount ?? 0
                self.applyAttributedTextDarkMode(to: self.lblRejectCount,
                                                 title: "Reject count  :  ",
                                                 value: "\(rejectCount)")
                
                
            }else{
                self.lblQuestion.textColor = .black
                self.lblName.textColor = .black
                self.lblScreenTitle.textColor = .black
                
                if let createdAtString = data?[0].notes?[0].createdAt {
                    let formattedDate = self.formatDate(dateString: createdAtString)
                    self.applyAttributedTextLightmode(to: self.lblCreatedIt,
                                                      title: "Created it  :  ",
                                                      value: formattedDate)
                }
                
                let referCount = data?[0].referCount ?? 0
                self.applyAttributedTextLightmode(to: self.lblReferCount,
                                                  title: "Refer count  :  ",
                                                  value: "\(referCount)")
                
                let rejectCount = data?[0].rejectCount ?? 0
                self.applyAttributedTextLightmode(to: self.lblRejectCount,
                                                  title: "Reject count  :  ",
                                                  value: "\(rejectCount)")
                
            }
            self.collvwImgs.reloadData()
        }
        
    }
    
    func applyAttributedTextLightmode(to label: UILabel, title: String, value: String) {
        let fullText = "\(title) \(value)"
        let attributedString = NSMutableAttributedString(string: fullText)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#5A5A5A"),
            .font: UIFont.boldSystemFont(ofSize: label.font.pointSize)
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: title.count))
        label.attributedText = attributedString
    }
    func applyAttributedTextDarkMode(to label: UILabel, title: String, value: String) {
        let fullText = "\(title) \(value)"
        let attributedString = NSMutableAttributedString(string: fullText)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: label.font.pointSize)
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: title.count))
        label.attributedText = attributedString
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension JobCreatedDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrImgs.count > 0{
            return arrImgs.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesListCVC", for: indexPath) as! ImagesListCVC
        cell.imgVwNotes.imageLoad(imageUrl: arrImgs[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4-8, height: 144)
    }
}
