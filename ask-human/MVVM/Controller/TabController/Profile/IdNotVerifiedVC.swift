//
//  IdNotVerifiedVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 20/01/25.
//

import UIKit

class IdNotVerifiedVC: UIViewController {

    @IBOutlet var imgVwGif: UIImageView!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var lblTitlle: UILabel!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            uiSet()
        }
    }
    
    func uiSet() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let textColor: UIColor = isDarkMode ? .white : .black
        let backImageName = isDarkMode ? "keyboard-backspace25" : "back"
        let gifName = isDarkMode ? "reportForDark" : "report"

        [lblTitlle, lblSubtitle, lblScreenTitle].forEach { $0?.textColor = textColor }
        btnBack.setImage(UIImage(named: backImageName), for: .normal)

        if let gifImage = UIImage.gif(name: gifName) {
            imgVwGif.image = gifImage
        } else {
            print("Failed to load GIF.")
        }
    }


    @IBAction func actionVerifyNow(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
        vc.isBack = true
        vc.isComing = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }

}
