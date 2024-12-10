//
//  EditProfileVC.swift
//  ask-human
//
//  Created by meet sharma on 21/11/23.
//

import UIKit

class EditProfileVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var imgVwProfile: UIImageView!
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldName.setLeftPaddingPoints(20)
        txtFldEmail.setLeftPaddingPoints(20)
        txtFldName.setRightPaddingPoints(20)
        txtFldEmail.setRightPaddingPoints(20)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
              }
    
    //MARK: - ACTION
    
    @IBAction func actionEditProfile(_ sender: GradientButton) {
        
    }
    @IBAction func actionBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        SceneDelegate().tabBarProfileVCRoot()
    }
    
    
    
}
