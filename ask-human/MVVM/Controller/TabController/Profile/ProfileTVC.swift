//
//  ProfileTVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class ProfileTVC: UITableViewCell {

    //MARK: - OUTLETS
    
    @IBOutlet var viewDarkMode: UIView!
    @IBOutlet var widthViewDark: NSLayoutConstraint!
    @IBOutlet var widthViewLight: NSLayoutConstraint!
    @IBOutlet var widthViewDarkMode: NSLayoutConstraint!
    @IBOutlet weak var imgVwTitle: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var iimgVwArrow: UIImageView!
    @IBOutlet var viewBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
