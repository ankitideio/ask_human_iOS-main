//
//  BankListTVC.swift
//  ask-human
//
//  Created by Ideio Soft on 04/09/24.
//

import UIKit

class BankListTVC: UITableViewCell {

    @IBOutlet var btnDefault: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var vwShadow: UIView!
    @IBOutlet weak var lblRoutingNumber: UILabel!
    @IBOutlet weak var lblRouting: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
