//
//  ContinueChatVC.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import UIKit

class ContinueChatVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var widthAmount: NSLayoutConstraint!
    @IBOutlet var txtFldAmount: UITextField!
    @IBOutlet var btnPay: GradientButton!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    //MARK: - variabels
    var viewModel = ContinueChatVM()
    var viewModelUpdate = ProfileVM()
    var messageId = ""
    var userId = ""
    var amount = 0
    var name = ""
    var isComingContinue = false
    var callBack:(()->())?
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        setupTextFieldObserver()
        adjustTextFieldWidth()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            uiSet()
        }
    }
    
    private func uiSet(){
        
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
            let tapGestureOnTetxAreaView = UITapGestureRecognizer(target: self, action: #selector(openKeyboard))
            tapGestureOnTetxAreaView.cancelsTouchesInView = false
            vwDotted.addGestureRecognizer(tapGestureOnTetxAreaView)

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
    @objc func openKeyboard() {
        txtFldAmount.becomeFirstResponder()
    }

    private func setupTextFieldObserver() {
        txtFldAmount.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        adjustTextFieldWidth()
    }
    
    private func continueChatApi(){
        viewModel.continueChatApi(messageId: messageId, userId: userId, amount: amount) {
            self.dismiss(animated: true)
            self.callBack?()
        }
    }
    private func updatePriceApi(){
        if txtFldAmount.text?.trimWhiteSpace.isEmpty == true{
            showSwiftyAlert("", "Enter amount", false)
        }else{
            viewModelUpdate.addHourlyPriceApi(hashtags: [], hoursPrice: Int(txtFldAmount.text ?? "") ?? 0) { data in
                self.dismiss(animated: true)
                self.callBack?()
            }
        }
    }
    
    private func adjustTextFieldWidth() {
        guard let text = txtFldAmount.text else { return }
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: txtFldAmount.font!])
        widthAmount.constant = size.width + 20
        print(size)
        view.layoutIfNeeded()
    }
    //MARK: - IBAction
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
//MARK: - UITextFieldDelegate
extension ContinueChatVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // If it's a continue chat, we don't allow any editing
        if isComingContinue {
            return false
        }
        
        // Get the current text and calculate the new text
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        // If the updated text is empty, allow it (to let the user clear it)
        if updatedText.isEmpty {
            adjustTextFieldWidth()
            return true
        }
        
        // Check if the updated text can be converted to an integer
        if let intValue = Int(updatedText) {
            // Clamp the value between 1 and 100
            if intValue < 1 {
                textField.text = "1"
                adjustTextFieldWidth()
                return false
            } else if intValue > 100 {
                textField.text = "100"
                adjustTextFieldWidth()
                return false
            }
            adjustTextFieldWidth()
            return true
        }
        
        // If the updated text is not numeric, do not allow the change
        return false
    }
}
