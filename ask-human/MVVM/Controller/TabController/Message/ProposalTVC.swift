//
//  ProposalTVC.swift
//  ask-human
//
//  Created by Ideio Soft on 21/08/24.
//

import UIKit

class ProposalTVC: UITableViewCell {

    @IBOutlet weak var heightReferView: NSLayoutConstraint!
    @IBOutlet weak var heightFirstVw: NSLayoutConstraint!
    @IBOutlet weak var lblReferDescription: UILabel!
    @IBOutlet weak var lblReferName: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var vwRefer: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var imgVwTick: UIImageView!
    @IBOutlet weak var lblAcceptRejectStatus: UILabel!
    @IBOutlet weak var lblNameProposal: UILabel!
    @IBOutlet weak var lblDescriptionProposal: UILabel!
    @IBOutlet weak var imgVwUserProposal: UIImageView!
    @IBOutlet weak var btnViewProposal: UIButton!
    @IBOutlet weak var vwSecond: UIView!
    @IBOutlet weak var vwFirst: UIView!
    @IBOutlet weak var txtVwProposal: UITextView!
    @IBOutlet weak var stackVwProposal: UIStackView!
    @IBOutlet weak var heightAcceptReject: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
