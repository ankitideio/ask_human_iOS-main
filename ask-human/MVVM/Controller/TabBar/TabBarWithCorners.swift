//
//  TabBarWithCorners.swift
//  ask-human
//
//  Created by meet sharma on 21/11/23.
//

import UIKit

class TabBarWithCorners: UITabBar {
    
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 30
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        if traitCollection.userInterfaceStyle == .dark {
            shapeLayer.fillColor = UIColor(hex: "#161616").cgColor
        }else{
            shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
            shapeLayer.shadowColor = UIColor.gray.cgColor
            shapeLayer.shadowOffset = CGSize(width: 0, height: -2)
            shapeLayer.shadowOpacity = 0.21
            shapeLayer.shadowRadius = 8
            shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        }
        
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
            self.isTranslucent = false
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radii, height: radii))
        
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 60 + 10
        tabFrame.origin.y = self.frame.origin.y + self.frame.height - 60 - 10
        self.layer.cornerRadius = 28
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
        
    }
    
   
}
