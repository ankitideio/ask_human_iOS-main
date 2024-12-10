//
//  LogoutPopUpVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit


class LogoutPopUpVC: UIViewController {

    //MARK: - LIFE CYCLE METHOD
    
    var viewModel = ProfileVM()
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        btnCancel.gradientButton("Cancel", startColor: UIColor(red: 240/255, green: 11/255, blue: 128/255, alpha: 1.0), endColor: UIColor(red: 122/255, green: 13/255, blue: 158/255, alpha: 1.0), textSize: 15.0, fontFamily: "Poppins-Medium")
        
    }
    
    //MARK: - ACTIONS
    @IBAction func actionCancel(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @IBAction func actionLogout(_ sender: GradientButton) {
        print("Auth-------",Store.authKey ?? "")
        viewModel.logoutApi {
            WebSocketManager.shared.disconnect()
//            Store.DarkMode = nil
            Store.addUser = false
            Store.autoLogin = "false"
            Store.authKey = ""
            Store.selectTabIndex = nil
            Store.notesId = nil
            Store.isFilterAge = false
            Store.getNotificationData = nil
            Store.notificationCount = 0
            Store.userDetail = nil
            Store.filterDetail = ["Gender":[],"Ethnicity":[],"Zodiac":[],"Smoking":[],"Drinking":[],"Workout":[],"BodyType":[]]
            Store.filterAgeSelect = ["minAge":"","maxAge":""]
          
            SceneDelegate().loginVCRoot()
        }
    }
    

}
