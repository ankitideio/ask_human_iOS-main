//
//  UserFilterTVC.swift
//  ask-human
//
//  Created by meet sharma on 21/11/23.
//

import UIKit
import SwiftRangeSlider


class UserFilterTVC: UITableViewCell{
  
    

    //MARK: - OUTLETS
    @IBOutlet weak var slider: RangeSlider!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSelectUnselect: UIButton!
    var callBack:((_ minValue:Int,_ maxValue:Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func uiSet(){
        slider.minimumValue = 18.0
        slider.maximumValue = 72.0
//        slider.lowerValue = 10.0
//        slider.upperValue = 100.0
        slider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
            // Handle the range slider value change event
            print("Lower Value: \(rangeSlider.lowerValue), Upper Value: \(rangeSlider.upperValue)")
        Store.isFilterAge = true
        callBack?(Int(rangeSlider.lowerValue),Int(rangeSlider.upperValue))
        }
    
}
