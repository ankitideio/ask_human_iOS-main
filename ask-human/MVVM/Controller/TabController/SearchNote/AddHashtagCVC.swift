//
//  AddHashtagCVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/01/25.
//

import UIKit

class AddHashtagCVC: UICollectionViewCell {
    @IBOutlet var trailingLblHashtag: NSLayoutConstraint!
    @IBOutlet var leadingLblHashtag: NSLayoutConstraint!
    @IBOutlet var imgVwDeleteBtn: UIImageView!
    @IBOutlet var imgVwVerify: UIImageView!
    @IBOutlet var widthImgVerify: NSLayoutConstraint!
    @IBOutlet var heightUsedCount: NSLayoutConstraint!
    @IBOutlet var widthViewUsedCount: NSLayoutConstraint!
    @IBOutlet var lblUsedCount: UILabel!
    @IBOutlet var viewUserCount: UIView!
    @IBOutlet var viewBtnDelete: UIView!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var lblHashtag: UILabel!
    @IBOutlet var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
