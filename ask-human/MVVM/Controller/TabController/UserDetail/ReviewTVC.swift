//
//  ReviewTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/02/25.
//

import UIKit
import FloatRatingView

class ReviewTVC: UITableViewCell {
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblReviw: UILabel!
    @IBOutlet var imgVwuser: UIImageView!
    @IBOutlet var ratingView: FloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
