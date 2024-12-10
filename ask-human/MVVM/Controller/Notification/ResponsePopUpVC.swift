//
//  ResponsePopUpVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 20/12/23.
//

import UIKit

class ResponsePopUpVC: UIViewController {

    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet weak var widthStack: NSLayoutConstraint!
    @IBOutlet weak var btnCancel: GradientButton!
    @IBOutlet weak var btnOk: GradientButton!
    @IBOutlet var lblMessage: UILabel!
    
    var message = ""
    var isComing = false
    var callBack:(()->())?
    
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
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblMessage.textColor = .white
        }else{
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            lblMessage.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        }
        }
    func uiSet(){
        lblMessage.text = message
        if isComing == true{
            btnOk.setTitle("Add Funds", for: .normal)
            btnCancel.isHidden = false
            widthStack.constant = 220
        }else{
            btnOk.setTitle("Ok", for: .normal)
            btnCancel.isHidden = true
            widthStack.constant = 200
        }
    }
    @IBAction func actonOk(_ sender: UIButton) {
        self.dismiss(animated: false)
        callBack?()
    }
    
    @IBAction func actionCancel(_ sender: GradientButton) {
        self.dismiss(animated: false)
    }
    
}
