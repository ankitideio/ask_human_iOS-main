//
//  DualThumbSlider.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/12/23.
//

import Foundation
import UIKit
class DualThumbSlider: UIView {
    
    let lowerSlider = UISlider()
    let upperSlider = UISlider()
    var val1:Int?
    var val2:Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSliders()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSliders()
    }
    
    private func setupSliders() {
        addSubview(lowerSlider)
        addSubview(upperSlider)
        lowerSlider.setThumbImage(UIImage(named: "sliderFill"), for: .normal)
           upperSlider.setThumbImage(UIImage(named: "emptySlider"), for: .normal)
           
           // Set minimum and maximum values
           lowerSlider.minimumValue = 0
           lowerSlider.maximumValue = 70
           
           upperSlider.minimumValue = 0
           upperSlider.maximumValue = 70
        
        lowerSlider.addTarget(self, action: #selector(lowerSliderValueChanged(_:)), for: .valueChanged)
        upperSlider.addTarget(self, action: #selector(upperSliderValueChanged(_:)), for: .valueChanged)
        
        // Customize the appearance or layout of the sliders as needed
        // Set the frame, colors, etc.
    }
    
    @objc private func lowerSliderValueChanged(_ sender: UISlider) {
        self.lowerSlider.value = Float(val1 ?? 0)
        self.lowerSlider.value = Float(val2 ?? 0)
    }
    
    @objc private func upperSliderValueChanged(_ sender: UISlider) {
        self.lowerSlider.value = Float(val1 ?? 0)
        self.lowerSlider.value = Float(val2 ?? 0)
    }
}
