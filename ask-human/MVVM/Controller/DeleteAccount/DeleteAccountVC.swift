//
//  DeleteAccountVC.swift
//  ask-human
//
//  Created by Ideio Soft on 15/01/25.
//

import UIKit

class DeleteAccountVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var heightTxtVw: NSLayoutConstraint!
    @IBOutlet weak var txtVwDesciprtion: UITextView!
    @IBOutlet weak var heightStackVw: NSLayoutConstraint!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgVwTitle: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - variables
    var type = ""
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                darkMode()
            }
        }

    private func darkMode(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
            btnBack.setImage(isDarkMode ? UIImage(named: "keyboard-backspace25") : UIImage(named: "back"), for: .normal)
            lblTitle.textColor = isDarkMode ? UIColor.white : .black
            txtVwDesciprtion.textColor = isDarkMode ? UIColor.white : .black
            btnDelete.borderWid = isDarkMode ? 1 : 0
            btnDelete.borderCol = isDarkMode ? UIColor.white : .clear
    }

    private func uiSet(){
        txtVwDesciprtion.isScrollEnabled = false
        if type == "delete"{
            lblTitle.text = "Delete Account"
            imgVwTitle.image = UIImage(named: "deleteAccount")
            heightStackVw.constant = 40
            setAccountDeletionText()
         
        }else if type == "about"{
            lblTitle.text = "About"
            imgVwTitle.image = UIImage(named: "about2")
            setAboutText()
            heightStackVw.constant = 0
        }else{
            lblTitle.text = "Privacy"
            imgVwTitle.image = UIImage(named: "privacy2")
            setAboutText()
            heightStackVw.constant = 0
        }
    }
    private func setAccountDeletionText() {
        let text = """
        Account deletion policy
        
        • Deleting your account is permanent and cannot be undone.
        • All data, including conversations and account settings, will be permanently deleted.
        • Settle any pending payments before proceeding.
        • Consider logging out your account instead if you’re unsure.
        • Contact support for assistance if needed.
        • Confirm deletion by entering your password.
        """

        // Create an attributed string
        let attributedString = NSMutableAttributedString(string: text)

        // Apply bold to "Account deletion policy"
        if let range = text.range(of: "Account deletion policy") {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: nsRange)
        }

        // Configure paragraph style for line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6 // Adjust for desired line spacing
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)

        // Set the attributed text to the UITextView
        txtVwDesciprtion.attributedText = attributedString

        // Adjust the UITextView height dynamically if needed
        let newSize = txtVwDesciprtion.sizeThatFits(CGSize(width: txtVwDesciprtion.frame.width, height: CGFloat.greatestFiniteMagnitude))
        heightTxtVw.constant = newSize.height
    }
    private func setAboutText() {
        let text = """
        Heading
        
        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. 
        
        Heading
        
        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. 
        
        Heading
                
        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
        """

        // Create an attributed string
        let attributedString = NSMutableAttributedString(string: text)

        // Apply bold to all occurrences of "Heading"
        let wordsToBold = "Heading"
        let nsText = text as NSString
        let boldFont = UIFont.boldSystemFont(ofSize: 16)

        var searchRange = NSRange(location: 0, length: nsText.length)
        while let foundRange = nsText.range(of: wordsToBold, options: [], range: searchRange).toOptional() {
            attributedString.addAttribute(.font, value: boldFont, range: foundRange)
            searchRange = NSRange(location: foundRange.location + foundRange.length, length: nsText.length - (foundRange.location + foundRange.length))
        }

        // Configure paragraph style for line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6 // Adjust for desired line spacing
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)

        // Set the attributed text to the UITextView
        txtVwDesciprtion.attributedText = attributedString

        // Adjust the UITextView height dynamically if needed
        let newSize = txtVwDesciprtion.sizeThatFits(CGSize(width: txtVwDesciprtion.frame.width, height: CGFloat.greatestFiniteMagnitude))
        heightTxtVw.constant = newSize.height
    }
    
    //MARK: - IBAction
    @IBAction func actionLogout(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
        vc.isComing = 1
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: false)

    }
    @IBAction func actionDelete(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
        vc.isComing = 0
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: false)
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
        
    }
    
}
//MARK: - NSRange
extension NSRange {
    /// Convert NSRange to Optional to make range checks simpler
    func toOptional() -> NSRange? {
        return self.location != NSNotFound ? self : nil
    }
}

