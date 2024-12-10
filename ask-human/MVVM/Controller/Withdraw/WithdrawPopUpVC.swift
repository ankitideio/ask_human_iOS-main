//
//  WithdrawPopUpVC.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import UIKit

class WithdrawPopUpVC: UIViewController {
    
    var callBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    @IBAction func actionOk(_ sender: GradientButton) {
        self.dismiss(animated: true)
        callBack?()
    }
    
    

}
