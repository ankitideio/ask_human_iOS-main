//
//  SettingsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 23/01/25.
//

import UIKit

class SettingsVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblVwList: UITableView!
    
    //MARK: - Variables
    var arrProfile = [ProfileData]()
    var email = ""
    var phone:Int?

    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    
    func uiSet(){
        let nib = UINib(nibName: "SettingsTVC", bundle: nil)
        tblVwList.register(nib, forCellReuseIdentifier: "SettingsTVC")
        if Store.isSocialLogin == true{
            arrProfile.append(ProfileData(title: "Change Phone Number", img: "changePhone"))
        }else{
            arrProfile.append(ProfileData(title: "Change Phone Number", img: "changePhone"))
            arrProfile.append(ProfileData(title: "Change Email", img: "changeEmail"))
        }
        email = Store.userDetail?["email"] as? String ?? ""
        phone = Int(Store.userDetail?["profile"] as? String ?? "")

        tblVwList.reloadData()

    }
    //MARK: - IBAction
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension SettingsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTVC", for: indexPath) as! SettingsTVC
        cell.lblTitle.text = arrProfile[indexPath.row].title ?? ""
        cell.imgVwTitle.image = UIImage(named: arrProfile[indexPath.row].img ?? "")
//        if Store.isSocialLogin == true{
//        }else{
//        }
      
        if traitCollection.userInterfaceStyle == .dark {
        }else{
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Store.isSocialLogin == true{
            switch indexPath.row{
            case 0:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPhoneNumberVC") as! AddNewPhoneNumberVC
                vc.phone = phone ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            
            default:
                break
            }

        }else{
            switch indexPath.row{
            case 0:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPhoneNumberVC") as! AddNewPhoneNumberVC
                vc.phone = phone ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewEmailVC") as! AddNewEmailVC
                vc.email = email
                self.navigationController?.pushViewController(vc, animated: true)

                
            default:
                break
            }
        }
    }
   
}
