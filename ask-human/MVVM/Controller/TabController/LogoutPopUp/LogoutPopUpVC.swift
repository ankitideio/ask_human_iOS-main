//
//  LogoutPopUpVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit


class LogoutPopUpVC: UIViewController {

    //MARK: - LIFE CYCLE METHOD
    
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var lblScrenTitle: UILabel!
    var viewModel = ProfileVM()
    @IBOutlet var btnLogoutAndDelete: GradientButton!
    @IBOutlet weak var btnCancel: UIButton!
    var isComing = 0
    var callBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        if isComing == 0{
            lblScrenTitle.text = "Delete account"
            lblSubTitle.text = "Are you sure you want to permanently delete your account? This action cannot be undone."
            btnLogoutAndDelete.setTitle("Delete", for: .normal)
        }else if isComing == 1{
            lblScrenTitle.text = "Logout"
            lblSubTitle.text = "You really want to logout your account"
            btnLogoutAndDelete.setTitle("Logout", for: .normal)
        }else{
            lblScrenTitle.text = "Change profile image"
            lblSubTitle.text = "If you chnage profile image,you will need to reverify your ID."
            btnLogoutAndDelete.setTitle("Change", for: .normal)
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func actionCancel(_ sender: UIButton) {
        dismiss(animated: false)
        if isComing != 2{
            callBack?()
        }
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        dismiss(animated: false)
        if isComing != 2{
            callBack?()
        }
    }
    
    @IBAction func actionLogout(_ sender: GradientButton) {
        callBack?()
        if isComing == 0{
            viewModel.deleteAccuntApi {
                WebSocketManager.shared.disconnect()
                self.nilStoredData()
                SceneDelegate().loginVCRoot()
            }
            
        }else if isComing == 1{
            viewModel.logoutApi {
                WebSocketManager.shared.disconnect()
                self.nilStoredData()
                SceneDelegate().loginVCRoot()
            }
        }else{
            self.dismiss(animated: true)
            callBack?()
        }
    }
    func nilStoredData(){
        Store.ScrollviewCurrentOffset = 0
        Store.addUser = false
        Store.autoLogin = "false"
        Store.authKey = ""
        Store.selectTabIndex = nil
        Store.notesId = nil
        Store.isFilterAge = false
        Store.getNotificationData = nil
        Store.notificationCount = 0
        Store.userDetail = nil
        Store.filterDetail = nil
        //Store.filterDetail = ["Gender":[],"Ethnicity":[],"Zodiac":[],"Smoking":[],"Drinking":[],"Workout":[],"BodyType":[]]
        Store.filterAgeSelect = ["minAge":"","maxAge":""]

    }

}
