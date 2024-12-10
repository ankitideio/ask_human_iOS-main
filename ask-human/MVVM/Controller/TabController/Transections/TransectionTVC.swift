//
//  TransectionTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/01/24.
//

import UIKit

class TransectionTVC: UITableViewCell {

    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTransectiontype: UILabel!
    @IBOutlet var imgVwWithdraw: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
