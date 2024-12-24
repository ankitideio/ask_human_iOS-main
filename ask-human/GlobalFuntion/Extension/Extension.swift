//
//  Extension.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import Foundation
import UIKit

//MARK: - Textfield
extension UITextField{
    
    //MARK: - Validations
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
    
    @IBInspectable var cornerRadi: CGFloat {
       get {
         return layer.cornerRadius
       }
       set {
         layer.cornerRadius = newValue
         layer.masksToBounds = newValue > 0
       }
     }
    
    @IBInspectable override var borderWid: CGFloat {
       get {
         return layer.borderWidth
       }
       set {
         layer.borderWidth = newValue
       }
     }
    
    @IBInspectable override var borderCol: UIColor? {
       get {
         return UIColor(cgColor: layer.borderColor!)
       }
       set {
         layer.borderColor = newValue?.cgColor
       }
     }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
         get {
             return leftView!.frame.size.width
         }
         set {
             let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
             leftView = paddingView
             leftViewMode = .always
         }
     }

     @IBInspectable var paddingRightCustom: CGFloat {
         get {
             return rightView!.frame.size.width
         }
         set {
             let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
             rightView = paddingView
             rightViewMode = .always
         }
     }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
 
    func setupRightImage(imageName:String){
      let imageView = UIImageView(frame: CGRect(x: 20, y: 12, width: 15, height: 15))
      imageView.image = UIImage(named: imageName)
      let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
      imageContainerView.addSubview(imageView)
      rightView = imageContainerView
      rightViewMode = .always
      self.tintColor = .lightGray
  }
}

//MARK: - Button

extension UIButton{
    @IBInspectable var cornerRadi: CGFloat {
       get {
         return layer.cornerRadius
       }
       set {
         layer.cornerRadius = newValue
         layer.masksToBounds = newValue > 0
       }
     }
    func removeBackgroundImage(for state: UIControl.State) {
           setBackgroundImage(nil, for: state)
       }
    @IBInspectable override var borderWid: CGFloat {
       get {
         return layer.borderWidth
       }
       set {
         layer.borderWidth = newValue
       }
     }
    @IBInspectable override var borderCol: UIColor? {
       get {
         return UIColor(cgColor: layer.borderColor!)
       }
       set {
         layer.borderColor = newValue?.cgColor
       }
     }
       func underline() {
         guard let text = self.titleLabel?.text else { return }
         let attributedString = NSMutableAttributedString(string: text)
         //NSAttributedStringKey.foregroundColor : UIColor.blue
         attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
         attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
         attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
         self.setAttributedTitle(attributedString, for: .normal)
       }
   }
//MARK: - LABLE
extension UILabel{
    @IBInspectable var cornerRadius: CGFloat {
       get {
         return layer.cornerRadius
       }
       set {
         layer.cornerRadius = newValue
         layer.masksToBounds = newValue > 0
       }
     }
    
    
   }

//MARK: - UIView
extension UIView{
    @IBInspectable var cornerRadiusView: CGFloat {
       get {
         return layer.cornerRadius
       }
       set {
         layer.cornerRadius = newValue
         layer.masksToBounds = newValue > 0
       }
     }
    @IBInspectable var borderWid: CGFloat {
      get {
        return layer.borderWidth
      }
      set {
        layer.borderWidth = newValue
      }
    }
    @IBInspectable var borderCol: UIColor? {
      get {
        return UIColor(cgColor: layer.borderColor!)
      }
      set {
        layer.borderColor = newValue?.cgColor
      }
    }
    
   }


@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            updateGradient()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private func updateGradient() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
               gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
               
               // Set the startPoint and endPoint for a horizontal gradient
               gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
               gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
}

@IBDesignable
class GradientButton: UIButton {
    
    // Define the colors for the gradient
    @IBInspectable var startColor: UIColor = UIColor.red {
        didSet {
            updateGradient()
        }
    }
    @IBInspectable var endColor: UIColor = UIColor.yellow {
        didSet {
            updateGradient()
        }
    }
    // Create gradient layer
    let gradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        // Set the gradient frame
        gradientLayer.frame = rect
        
        // Set the colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        // Gradient is linear from left to right
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        // Add gradient layer into the button
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Round the button corners
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
    }

    func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
  
}



extension UIViewController{
    func applyGradientColor(to label: UILabel, with targetText: String, gradientColors: [Any]) {
          // Create a mutable attributed string
          let attributedString = NSMutableAttributedString(string: label.text ?? "")

          // Find the range of the target text
          let range = (label.text as NSString?)?.range(of: targetText)

          if let range = range {
              // Create a gradient layer
              let gradientLayer = CAGradientLayer()
              gradientLayer.frame = label.bounds
              gradientLayer.colors = gradientColors

           
              UIGraphicsBeginImageContext(gradientLayer.bounds.size)

              gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
              let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()

          
              if let gradientImage = gradientImage {
                  attributedString.addAttribute(.foregroundColor, value: UIColor(patternImage: gradientImage), range: range)
              }


              label.attributedText = attributedString
          }
      }
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    //order of gradient colors
    gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor, UIColor.green.cgColor]
    // start and end points
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
    }
    func linearGradientColor(from colors: [UIColor], locations: [CGFloat], size: CGSize) -> UIColor {
        let image = UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height)).image { context in
            let cgColors = colors.map { $0.cgColor } as CFArray
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(
                colorsSpace: colorSpace,
                colors: cgColors,
                locations: locations
            )!
            context.cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0, y: 0),
                end: CGPoint(x: size.width, y:0),
                options:[]
            )
        }
        return UIColor(patternImage: image)
    }
}

class GradientBorderColorView: UIView {
    func setGradientBorderColor(startColor: UIColor, endColor: UIColor, borderWidth: CGFloat) {
        // Create a gradient layer for the border
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        // Create a shape layer to be used as a mask for the gradient
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(rect: bounds).cgPath

        // Set the mask for the gradient layer
        gradientLayer.mask = maskLayer

        // Create a shape layer for the border
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(rect: bounds).cgPath
        borderLayer.strokeColor = UIColor.black.cgColor  // Default border color
        borderLayer.lineWidth = borderWidth
        borderLayer.fillColor = nil

        // Add the border layer to the view's layer
        layer.addSublayer(borderLayer)

        // Add the gradient layer to the view's layer
        layer.addSublayer(gradientLayer)
    }
}
extension UIButton {
    func gradiantButton(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        
        // Ensure you remove any previous gradient layers to avoid overlap
        if let oldGradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView{
    func setGradientBackground(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            gradientLayer.cornerRadius = self.layer.cornerRadius

            // Remove previous gradient layers to avoid duplicates
            self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    func gradiantView(startColor: UIColor, endColor: UIColor) {

        let button: UIButton = UIButton(frame: self.bounds)
       
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        self.mask = button

    }
    func gradientButton(_ buttonText: String, startColor: UIColor, endColor: UIColor, textSize: CGFloat, fontFamily: String) {

        let button: UIButton = UIButton(frame: self.bounds)
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.font = UIFont(name: fontFamily, size: textSize) // Set font size and family

        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        self.mask = button

        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
    }
 
    func addTopShadow(shadowColor : UIColor, shadowOpacity : Float,shadowRadius : Float,offset:CGSize){
          self.layer.shadowColor = shadowColor.cgColor
          self.layer.shadowOffset = offset
          self.layer.shadowOpacity = shadowOpacity
          self.layer.shadowRadius = CGFloat(shadowRadius)
          self.clipsToBounds = false
      }
    @discardableResult
       func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
           let borderLayer = CAShapeLayer()

           borderLayer.strokeColor = color
           borderLayer.lineWidth = 2
           borderLayer.lineDashPattern = pattern
           borderLayer.frame = bounds
           borderLayer.fillColor = nil
           borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

           layer.addSublayer(borderLayer)
           return borderLayer
       }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
      
}

extension CALayer {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
//MARK: - UISegmentedControl
extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }

    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 4.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 2.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.appPurple
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
//MARK: - Textfield MaxLenth
private var kAssociationKeyMaxLength: Int = 0
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
class CustomSlide: UISlider {

     @IBInspectable var trackHeight: CGFloat = 10

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         //set your bounds here
         return CGRect(origin: bounds.origin, size: CGSizeMake(bounds.width, trackHeight))



       }
}
