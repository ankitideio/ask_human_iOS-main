//
//  ConfirmEmailVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit

class ConfirmEmailVC: UIViewController {
    

    //MARK: - LIFE CYCLE METHOD
    
    @IBOutlet var lblCongrats: UILabel!
    @IBOutlet var lblWelcome: UILabel!
    var isComing = false
    @IBOutlet weak var btnGoto: GradientButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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
            lblWelcome.textColor = .white
            lblCongrats.textColor = .white
        }else{
            lblWelcome.textColor = .black
            lblCongrats.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        }
        }
    //MARK: - ACTIONS
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionGoToHome(_ sender: GradientButton) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
            vc.isComing = false
            Store.autoLogin = "true"
           Store.selectTabIndex = 1
            self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    
    
}
