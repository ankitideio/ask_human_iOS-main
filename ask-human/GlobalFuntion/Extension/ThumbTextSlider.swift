//
//  ThumbTextSlider.swift
//  ask-human
//
//  Created by meet sharma on 19/12/23.
//

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
        
        // Position the thumb text label
        thumbTextLabel.frame = CGRect(x: thumbFrame.origin.x - (thumbTextLabel.frame.size.width / 2) + thumbFrame.size.width / 2,
                                      y: thumbFrame.maxY - 48,
                                      width: thumbFrame.size.width * 1.8,
                                      height: 20)
        setValue()
    }
    
    private func setValue() {
        let roundedValue = String(format: "%0.0f", self.value)
        if traitCollection.userInterfaceStyle == .dark {
            thumbTextLabel.textColor = UIColor(hex: "#979797")
        }else{
            thumbTextLabel.textColor = UIColor(hex: "#545454")
        }
        
        thumbTextLabel.text = "\(roundedValue) Star"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupThumbTextLabel()
        configureSliderAppearance()
    }
    
    private func setupThumbTextLabel() {
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.textColor = UIColor(hex: "#545454")
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        thumbTextLabel.adjustsFontSizeToFitWidth = true
        
        if let poppinsFont = UIFont(name: "Poppins-Regular", size: 12) {
            thumbTextLabel.font = poppinsFont
        }
    }
    
    private func configureSliderAppearance() {
        // Set the thumb image
        if let thumbImage = UIImage(named: "sliderThumb") {
            setThumbImage(thumbImage, for: .normal)
        }
        
        // Set track colors
        minimumTrackTintColor = UIColor.app
        maximumTrackTintColor = UIColor(hex: "#D9D9D9")
    }
    
    // Adjust the track height
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let originalTrackRect = super.trackRect(forBounds: bounds)
        let customHeight: CGFloat = 10 // Desired track height
        let yOffset = (originalTrackRect.height - customHeight) / 2
        return CGRect(x: originalTrackRect.origin.x, y: originalTrackRect.origin.y + yOffset, width: originalTrackRect.width, height: customHeight)
    }
}
