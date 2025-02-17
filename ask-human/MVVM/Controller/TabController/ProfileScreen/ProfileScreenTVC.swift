//
//  ProfileScreenTVC.swift
//  ask-human
//
//  Created by Ideio Soft on 10/01/25.
//

import UIKit
struct ProfileScreenData{
    var title:String?
    var img:String?
    var height:Int?
    var width:Int?
    init(title: String? = nil, img: String? = nil, height: Int? = nil, width: Int? = nil) {
        self.title = title
        self.img = img
        self.height = height
        self.width = width
    }
}
 
class ProfileScreenTVC: UITableViewCell {
    
    @IBOutlet weak var collVwProfile: UICollectionView!
    @IBOutlet weak var heightCollVw: NSLayoutConstraint!
    
    var section = 0
    var dataSource: [ProfileScreenData] = []
    var callBack:((_ index:Int,_ section:Int)->())?
    var isSelect = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func uiSet(for section: Int) {
        self.section = section
        print(section)
        switch section {
        case 0:
            dataSource = [
                ProfileScreenData(title: "Id Verification", img: "idVerification1",height: 18,width: 18),
                ProfileScreenData(title: "Identification", img: "identification1",height: 18,width: 18)
            ]
            heightCollVw.constant = 85
        case 1:
            dataSource = [
                ProfileScreenData(title: "Hourly Price", img: "hourly1",height: 18,width: 18),
                ProfileScreenData(title: "Hashtags", img: "hastag1",height: 18,width: 18)
            ]
            heightCollVw.constant = 85
        case 2:
            dataSource = [
                ProfileScreenData(title: "Wallet", img: "wallet1",height: 16,width: 21),
                ProfileScreenData(title: "Add bank", img: "addBank1",height: 18,width: 18),
                ProfileScreenData(title: "Transaction history", img: "trasaction1",height: 18,width: 18)
            ]
            heightCollVw.constant = 180
        case 3:
            dataSource = [
                ProfileScreenData(title: "Applied requests", img: "appliedRequest1",height: 16,width: 21),
                ProfileScreenData(title: "All disputes", img: "allDispute1",height: 18,width: 18),
                ProfileScreenData(title: "All contracts", img: "allContract1",height: 18,width: 16)
               
            ]
            heightCollVw.constant = 180
        case 4:
            let currentImage = traitCollection.userInterfaceStyle == .dark ? "dark" : "dark1"
            dataSource = [
                ProfileScreenData(title: "Delete account", img: "draft1",height: 18,width: 15),
                ProfileScreenData(title: "Notification", img: "notificationSetting1",height: 18,width: 18),
                ProfileScreenData(title: "Dark mode", img: currentImage,height: 40,width: 56),
                ProfileScreenData(title: "Help", img: "help1",height: 18,width: 18),
                ProfileScreenData(title: "About", img: "about1",height: 18,width: 18),
                ProfileScreenData(title: "Privacy", img: "privacy1",height: 18,width: 14),
                ProfileScreenData(title: "Contact us", img: "contactUs1",height: 14,width: 18)
            ]
            heightCollVw.constant = 370
        case 5:
            heightCollVw.constant = 0
        default:
            dataSource = []
        }
        collVwProfile.delegate = self
        collVwProfile.dataSource = self
    }
    
}

extension ProfileScreenTVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileScreenCVC", for:  indexPath) as! ProfileScreenCVC
        cell.lblList.text = dataSource[indexPath.row].title
        cell.imgVwList.image = UIImage(named: dataSource[indexPath.row].img ?? "")
        cell.heightImg.constant = CGFloat(dataSource[indexPath.row].height ?? 0)
        cell.widthImg.constant = CGFloat(dataSource[indexPath.row].width ?? 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collVwProfile.frame.width/2-5, height: 85)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSelect{
            isSelect = false
            callBack?(indexPath.row,section)
        }
    }
}
