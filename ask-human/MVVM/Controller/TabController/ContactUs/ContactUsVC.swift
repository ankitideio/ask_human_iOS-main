//
//  ContactUsVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class ContactUsVC: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet var lblBack: UIButton!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var lblMailUs: UILabel!
    @IBOutlet weak var lblWriteToUs: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    var email:String?
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("email: -- \(email ?? "")")
//        lblEmail.text = Store.userDetail?["email"] as? String ?? ""
        lblEmail.text = "ideiosoft@gmail.com"
        
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
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            
            lblBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblMailUs.textColor = .white
            lblWriteToUs.textColor = .white
        }else{
            lblBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            lblMailUs.textColor = UIColor(hex: "#1E212C")
            lblWriteToUs.textColor = UIColor(hex: "#1E212C")
        }
        }
    //MARK: - ACTIONS
    
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
    }
    
    @IBAction func actionStartChat(_ sender: GradientButton) {
        print("assfs")
        let email = "ideiosoft@gmail.com"
        
        if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback for earlier iOS versions
                UIApplication.shared.openURL(url)
            }
        }
    }
}
