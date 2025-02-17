//
//  IdVerifiedVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 20/01/25.
//

import UIKit

class IdVerifiedVC: UIViewController {
    @IBOutlet var imgVwGender: UIImageView!
    @IBOutlet var imgVwAge: UIImageView!
    @IBOutlet var imgVwZodiac: UIImageView!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var imgVwGif: UIImageView!
    @IBOutlet var lblTitlePassport: UILabel!
    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var lblVerified: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var lblZodiac: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var imgVwDocument: UIImageView!
    @IBOutlet var btnBack: UIButton!
    
    var isComing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    
    func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let gifName = isDarkMode ? "fileForDark" : "file"
        
        if let gifImage = UIImage.gif(name: gifName) {
            imgVwGif.image = gifImage
        } else {
            print("Failed to load GIF: \(gifName)")
        }

        btnBack.setImage(isDarkMode ? UIImage(named: "keyboard-backspace25") :  UIImage(named: "back"), for: .normal)
        lblScreenTitle.textColor = isDarkMode ? UIColor.white : .black
        lblAge.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblMsg.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblGender.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblZodiac.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblTitlePassport.textColor = isDarkMode ? UIColor.white : .black
        imgVwAge.image = UIImage(named: isDarkMode ? "ageDark" : "age")
        imgVwGender.image = UIImage(named: isDarkMode ? "genderDark" : "gender")
        imgVwZodiac.image = UIImage(named: isDarkMode ? "zodiacDark" : "zodiac")


    }
    func uiSet(){
        imgVwDocument.imageLoad(imageUrl: Store.userDetail?["document"] as? String ?? "")
            if Store.userDetail?["gender"] as? Int ?? 0 == 0{
                self.lblGender.text = "Male"
            }else if Store.userDetail?["gender"] as? Int ?? 0 == 1{
                self.lblGender.text = "Female"
            }else{
                self.lblGender.text = "Others"
            }
        lblAge.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
        lblZodiac.text = "\(Store.userDetail?["zodiac"] as? String ?? "")"
        if Store.userDetail?["identity"] as? Int == 0{
            lblTitlePassport.text =  "Passport"
        }else if Store.userDetail?["identity"] as? Int == 1{
            lblTitlePassport.text =  "Driving Licence"
        }else if Store.userDetail?["identity"] as? Int == 2{
            lblTitlePassport.text =  "Country ID"
        }else{
            lblTitlePassport.text =  ""
        }

        }
    

    
    @IBAction func actionBack(_ sender: UIButton) {
        if isComing{
            SceneDelegate().tabBarHomeVCRoot()
        }else{
            SceneDelegate().tabBarProfileVCRoot()
        }
       
    }
    
}
