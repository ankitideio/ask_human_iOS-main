//
//  ThumbTextSlider.swift
//  ask-human
//
//  Created by meet sharma on 19/12/23.
//

import Foundation
import UIKit
class ThumbTextSlider: UISlider {
    private var thumbTextLabel: UILabel = UILabel()
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    private lazy var thumbView: UIView = {
        let thumb = UIView()
        return thumb
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbTextLabel.frame = CGRect(x: thumbFrame.origin.x, y: thumbFrame.maxY - 55, width: thumbFrame.size.width, height: 30)
        self.setValue()
    }
    
    private func setValue() {
        let roundedValue = String(format: "%0.0f", self.value)
           thumbTextLabel.text = roundedValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.textColor = .darkGray
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        thumbTextLabel.adjustsFontSizeToFitWidth = true
       
        if let poppinsFont = UIFont(name: "Poppins-Regular", size: 14) {
                    thumbTextLabel.font = poppinsFont
                }
    }
}
