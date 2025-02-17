//
//  HelpTVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import UIKit

class HelpTVC: UITableViewCell {
  @IBOutlet weak var btnDropdown: UIButton!
  @IBOutlet weak var lblDetail: UILabel!
  @IBOutlet weak var imgVwDropDown: UIImageView!
  @IBOutlet weak var lblHeader: UILabel!
  @IBOutlet weak var vwDetail: UIView!
  @IBOutlet weak var vwHeader: UIView!
  @IBOutlet weak var vwBackground: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
