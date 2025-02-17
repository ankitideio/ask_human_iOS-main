//
//  reviewVideoVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/01/24.
//

import UIKit

class reviewVideoVC: UIViewController {
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblTitleMessage: UILabel!
    
    var viewModel = ProfileVM()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
        getProfileApi()
    }
    func getProfileApi(){
        viewModel.getProfileApi{ data in
        }

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblTitle.textColor = .white
            lblTitleMessage.textColor = .white
        }else{
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblTitle.textColor = UIColor(hex: "#1F1F1F")
            lblTitleMessage.textColor = UIColor(hex: "#060606")
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
        
    }
    @IBAction func actionDone(_ sender: GradientButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
        
    }

}
