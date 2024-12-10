//
//  AppliedReqTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 30/05/24.
//

import UIKit

class AppliedReqTVC: UITableViewCell {
    @IBOutlet var lblAboutJobCreated: UILabel!
    @IBOutlet var lblJobCeateUserName: UILabel!
    @IBOutlet var viewJobCreated: UIView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnStatus: UIButton!
    @IBOutlet var imgVwBlueTick: UIImageView!
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var lblJobCreate: UILabel!
    @IBOutlet var lblTitleName: UILabel!
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var lblTitleStatus: UILabel!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnViewDetail: UIButton!
    @IBOutlet weak var imgVwTickRefer: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
