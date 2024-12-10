//
//  ReferMessageVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/05/24.
//

import UIKit
import IQKeyboardManagerSwift

class ReferMessageVC: UIViewController {

    @IBOutlet var btnSent: GradientButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var txtVwMessage: IQTextView!
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var lblScreentitle: UILabel!
    
    var messageId = ""
    var notesId = ""
    var viewModel = ReferVM()
    var callBack:((_ message:String?)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("notesId:--\(notesId)")
        
        txtVwMessage.borderWid = 1
        txtVwMessage.layer.cornerRadius = 10
        txtVwMessage.borderCol = UIColor(hex: "#E8E8E8")
        viewBack.layer.cornerRadius = 30
        viewBack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
            lblScreentitle.textColor = .white
            lblTitleMessage.textColor = .white
            txtVwMessage.textColor = .white  
    
        }else{
            lblScreentitle.textColor = .black
            lblTitleMessage.textColor = .black
            txtVwMessage.textColor = .black
        }
    }
    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionSent(_ sender: UIButton) {
        if txtVwMessage.text.trimWhiteSpace.isEmpty == true{
            showSwiftyAlert("", "Enter message", false)
        }else{
            
            viewModel.applyRefer(messageId: messageId, notesId: notesId, message: txtVwMessage.text) { message in
                self.dismiss(animated: false)
                self.callBack?(message)
            }
        }
    }
    
}
