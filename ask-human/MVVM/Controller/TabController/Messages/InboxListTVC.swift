//
//  InboxListTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 29/05/24.
//

import UIKit

class InboxListTVC: UITableViewCell {
    
    @IBOutlet var mainVw: UIView!
    @IBOutlet var viewOnline: UIView!
    @IBOutlet var lblMessageCount: UILabel!
    @IBOutlet var viewMessageCount: UIView!
    @IBOutlet var lblContractId: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgVwUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
