//
//  AddWalletVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class AddWalletVC: UIViewController {
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actionNext(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        SceneDelegate().tabBarProfileVCRoot()
    }
    

}
