//
//  ProfileHeaderTVC.swift
//  ask-human
//
//  Created by Ideio Soft on 10/01/25.
//

import UIKit

class ProfileHeaderTVC: UITableViewCell {

    @IBOutlet var btnLogout: GradientButton!
    @IBOutlet weak var lblHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
