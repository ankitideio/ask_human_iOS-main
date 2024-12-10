//
//  UserReviewTVC.swift
//  ask-human
//
//  Created by meet sharma on 17/11/23.
//

import UIKit
import FloatRatingView

class UserReviewTVC: UITableViewCell {

    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var ratingVw: FloatRatingView!
    @IBOutlet weak var imgVeProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
