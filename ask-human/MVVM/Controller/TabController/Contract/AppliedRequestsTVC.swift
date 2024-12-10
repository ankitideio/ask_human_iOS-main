//
//  AppliedRequestsTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/05/24.
//

import UIKit

class AppliedRequestsTVC: UITableViewCell {
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var lblrating: UILabel!
    @IBOutlet var btnAccept: GradientButton!
    @IBOutlet var btnReject: UIButton!
    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
