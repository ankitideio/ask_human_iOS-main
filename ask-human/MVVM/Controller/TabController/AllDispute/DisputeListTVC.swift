//
//  DisputeListTVC.swift
//  ask-human
//
//  Created by meet sharma on 18/11/23.
//

import UIKit

class DisputeListTVC: UITableViewCell {

    //MARK: - OUTLETS
    
    @IBOutlet var lblTtielContractId: UILabel!
    @IBOutlet var lblTitleDate: UILabel!
    @IBOutlet var lblTitleReason: UILabel!
    @IBOutlet var lblTitleStatus: UILabel!
    @IBOutlet var viewBAck: UIView!
    @IBOutlet weak var widthStatusBtn: NSLayoutConstraint!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblDisputeDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
