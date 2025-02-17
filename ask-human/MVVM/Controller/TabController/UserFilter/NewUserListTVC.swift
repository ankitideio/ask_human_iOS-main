//
//  NewUserListTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 13/01/25.
//

import UIKit
import FloatRatingView

class NewUserListTVC: UITableViewCell {
    @IBOutlet var imgVwSelected: UIImageView!
    @IBOutlet var viewBAck: UIView!
    @IBOutlet var viewOnline: UIView!
    @IBOutlet var ratingVw: FloatRatingView!
    @IBOutlet var btnAsk: UIButton!
    @IBOutlet var lblTitleChat: UILabel!
    @IBOutlet var lblTitlerating: UILabel!
    @IBOutlet var lblTitlePrice: UILabel!
    @IBOutlet var lblHashtags: UILabel!
    @IBOutlet var lblChatCount: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet weak var imgVwBlueTick: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
