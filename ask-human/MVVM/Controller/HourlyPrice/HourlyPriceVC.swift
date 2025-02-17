//
//  HourlyPriceVC.swift
//  ask-human
//
//  Created by Ideio Soft on 15/01/25.
//

import UIKit

class HourlyPriceVC: UIViewController {

    @IBOutlet var btnAddANdUpdate: GradientButton!
    @IBOutlet weak var heightTextVw: NSLayoutConstraint!
    @IBOutlet weak var txtVwDescription: UITextView!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    
    var viewModel = ProfileVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSet()
    }
    private func uiSet(){
        txtFldPrice.delegate = self
        darkMode()
        
        let text = """
        The hourly price in "Ask Human" is the fixed cost users pay for one-on-one conversations with responders, charged in full-hour increments.
        How It Works:
        • Set by Responders: Responders determine their hourly rate based on expertise and demand.
        • Hourly Sessions: Users pay for a full hour upfront. To continue beyond an hour, users must pay for the next hour.
        • Transparent Pricing: Hourly rates are shown before starting a session.
        *$60/hour → A session lasting up to 1 hour costs $60. To continue, another $60 is charged for the next hour.
        """

        // Define attributes
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .left
        
        let textColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: 0.005
        ]
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-SemiBold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: 0.005
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: regularAttributes)
        if let range = text.range(of: "How It Works:") {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttributes(boldAttributes, range: nsRange)
        }
        txtVwDescription.attributedText = attributedString
        
        let newSize = txtVwDescription.sizeThatFits(CGSize(width: txtVwDescription.frame.width, height: CGFloat.greatestFiniteMagnitude))
        heightTextVw.constant = newSize.height

        if Store.userDetail?["hoursPrice"] as? Int ?? 0 > 0{
            txtFldPrice.text = "\(Store.userDetail?["hoursPrice"] as? Int ?? 0)"
            btnAddANdUpdate.setTitle("Update", for: .normal)
        }else{
            txtFldPrice.text = ""
            btnAddANdUpdate.setTitle("Add", for: .normal)
        }

    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    private func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            txtFldPrice.textColor = .black
            txtVwDescription.textColor = .white
            lblScreenTitle.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            let placeholderColor = UIColor(hex: "#000000").withAlphaComponent(0.5)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldPrice.attributedPlaceholder = NSAttributedString(string: "Hourly price", attributes: attributes)

        }else{
            let placeholderColor = UIColor(hex: "#000000").withAlphaComponent(0.5)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldPrice.attributedPlaceholder = NSAttributedString(string: "Hourly price", attributes: attributes)

            txtFldPrice.textColor = .black
            txtVwDescription.textColor = .black
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
    }

    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
    }
    
    @IBAction func actionHourlyPrice(_ sender: UIButton) {
        guard let priceText = txtFldPrice.text, !priceText.isEmpty else {
            showSwiftyAlert("", "Please enter hourly price", false)
            return
        }
        
        guard let price = Int(priceText), price > 0 else {
            showSwiftyAlert("", "Please enter hourly price greater than 0", false)
            return
        }
        viewModel.addHourlyPriceApi(hashtags: [], hoursPrice: price){ message in
            DispatchQueue.global(qos: .background).async {
                self.viewModel.getProfileApi { data in
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = "Updated successfully"
                        vc.callBack = {
                            SceneDelegate().notificationsRoot(selectTab: 2)
                        }
                        self.navigationController?.present(vc, animated: false)

                        
                    }
                }
            }
        }
        }
    
}

// MARK: - UITextFieldDelegate
extension HourlyPriceVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string.isEmpty {
                return true
            }
            guard let currentText = textField.text else { return true }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if let number = Int(newText), number >= 1, number <= 100 {
                return true
            }
            return false
        }
        
}
