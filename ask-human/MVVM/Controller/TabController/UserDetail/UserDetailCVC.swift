//
//  UserDetailCVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/02/25.
//

import UIKit
struct UserDetailz{
    var title:String?
    var image:String?
    
    init(title: String? = nil, image: String? = nil) {
        self.title = title
        self.image = image
    }
}

class UserDetailCVC: UICollectionViewCell {
    @IBOutlet var viewBAck: UIView!
    @IBOutlet var widthImgVwTitle: NSLayoutConstraint!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
