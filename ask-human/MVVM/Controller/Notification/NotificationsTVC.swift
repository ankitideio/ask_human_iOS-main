//
//  NotificationsTVC.swift
//  askHuman
//
//  Created by IDEIO SOFT on 16/11/23.
//

import UIKit

class NotificationsTVC: UITableViewCell {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblTiming: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescripion: UILabel!
    @IBOutlet weak var bgVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
