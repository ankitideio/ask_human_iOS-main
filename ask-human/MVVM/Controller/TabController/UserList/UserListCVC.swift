//
//  UserListCVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import AlignedCollectionViewFlowLayout

class UserListCVC: UICollectionViewCell {
    
    @IBOutlet var heightCollVwHashtag: NSLayoutConstraint!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnMultipleSelect: UIButton!
    @IBOutlet weak var imgVwBlueTick: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    var index = 0
    var arrHashtag = [Hashtagg]()
    var isSelectedCell: Bool = false {
            didSet {
                // Update the UI to reflect the selection state
                // For example, toggle the visibility of a checkmark
                btnMultipleSelect.isHidden = !isSelectedCell
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        collVwHashtag.delegate = self
        collVwHashtag.dataSource = self
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }

    }
    
    func uiSet(){
        arrHashtag = Store.userHashtags?.users?[index].hashtags ?? []
    collVwHashtag.reloadData()
    }
}
//MARK: - UICollectionViewDelegate
extension UserListCVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrHashtag.count > 0{
            return arrHashtag.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersHashtagCVC", for: indexPath) as! UsersHashtagCVC
        cell.lblName.text = "#\(arrHashtag[indexPath.row].title ?? "")"
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = "#\(arrHashtag[indexPath.row].title ?? "")"
        let padding: CGFloat = 5
        let textWidth = calculateTextWidth(text: text, font: UIFont.systemFont(ofSize: 12))
        
        return CGSize(width: textWidth + padding, height: 22)
    }
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        return text.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }


}
