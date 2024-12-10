//
//  UserListTVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit

class UserListTVC: UITableViewCell {

    //MARK: - OUTLETS
    
    @IBOutlet weak var imgVwTick: UIImageView!
    @IBOutlet weak var btnViewContract: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
  
}
