//
//  SenderTVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class SenderTVC: UITableViewCell {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var vwHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 
    }

}
