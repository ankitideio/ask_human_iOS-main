//
//  ContinueChatVC.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import UIKit

class ContinueChatVC: UIViewController {

    @IBOutlet var widthAmount: NSLayoutConstraint!
    @IBOutlet var txtFldAmount: UITextField!
    @IBOutlet var btnPay: GradientButton!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    var viewModel = ContinueChatVM()
    var viewModelUpdate = ProfileVM()
    var messageId = ""
    var userId = ""
    var amount = 0
    var name = ""
    var isComingContinue = false
    var callBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

       uiSet()
       setupTextFieldObserver()
       adjustTextFieldWidth()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func overlayTapped() {
        self.dismiss(animated: true)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
           uiSet()
        }
    }
    
    func uiSet(){
      
        if isComingContinue == true{
            lblHeader.text = "Continue Chat"
            
            lblTitle.text = "You need to pay $\(amount) for further assistence to \(name)"
            txtFldAmount.text = "\(amount)"
            btnPay.setTitle("Pay", for: .normal)
            txtFldAmount.isUserInteractionEnabled = false
            
            let attributedString = NSMutableAttributedString(string: lblTitle.text!)
               let amountRange = (lblTitle.text! as NSString).range(of: "$\(amount)")
               let nameRange = (lblTitle.text! as NSString).range(of: "\(name)")
               attributedString.addAttribute(.font, value: UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16), range: amountRange)
            
               attributedString.addAttribute(.font, value: UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16), range: nameRange)
            if traitCollection.userInterfaceStyle == .dark {
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nameRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: amountRange)

                lblTitle.attributedText = attributedString
            }else{
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nameRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: amountRange)

                lblTitle.attributedText = attributedString
            }
               
      
        }else{
            lblHeader.text = "Update Price"
            btnPay.setTitle("Update", for: .normal)
            lblTitle.text = "Your current hourly price is $\(amount) if you want to Update your hourly price you can update it"
            txtFldAmount.text = "\(amount)"
            txtFldAmount.isUserInteractionEnabled = true
            
            let attributedString = NSMutableAttributedString(string: lblTitle.text!)
               let amountRange = (lblTitle.text! as NSString).range(of: "$\(amount)")
               attributedString.addAttribute(.font, value: UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16), range: amountRange)
            if traitCollection.userInterfaceStyle == .dark {
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: amountRange)
            } else {
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: amountRange)
            }
            lblTitle.attributedText = attributedString
        }
        vwBackground.layer.cornerRadius = 40
        vwBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupTextFieldObserver() {
          txtFldAmount.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
      }
      
      @objc func textFieldDidChange(_ textField: UITextField) {
          adjustTextFieldWidth()
      }
      
    func continueChatApi(){
        viewModel.continueChatApi(messageId: messageId, userId: userId, amount: amount) {
            self.dismiss(animated: true)
            self.callBack?()
        }
        
    }
    func updatePriceApi(){
        if txtFldAmount.text?.trimWhiteSpace.isEmpty == true{
            showSwiftyAlert("", "Enter amount", false)
        }else{
            viewModelUpdate.updatePriceApi(price: txtFldAmount.text ?? "") {
            
                    self.dismiss(animated: true)
                    self.callBack?()
                
            }
        }
       
        
    }
    
    func adjustTextFieldWidth() {
        guard let text = txtFldAmount.text else { return }
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: txtFldAmount.font!])
         widthAmount.constant = size.width + 20
        
        print(size)
        view.layoutIfNeeded()
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionPay(_ sender: GradientButton) {
        if isComingContinue == true{
            continueChatApi()
        }else{
           updatePriceApi()
        }
       
    }
    

}
