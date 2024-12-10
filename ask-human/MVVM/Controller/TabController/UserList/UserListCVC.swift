//
//  UserListCVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit

class UserListCVC: UICollectionViewCell {
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnMultipleSelect: UIButton!
    @IBOutlet weak var imgVwBlueTick: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    var isSelectedCell: Bool = false {
            didSet {
                // Update the UI to reflect the selection state
                // For example, toggle the visibility of a checkmark
                btnMultipleSelect.isHidden = !isSelectedCell
            }
        }
}
