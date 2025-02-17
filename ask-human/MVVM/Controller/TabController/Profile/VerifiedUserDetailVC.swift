//
//  VerifiedUserDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 22/01/25.
//

import UIKit

class VerifiedUserDetailVC: UIViewController {
    @IBOutlet var lblZodiac: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var imgVwDocument: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var lblThankyou: UILabel!
    @IBOutlet var lblDocumentType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            imgVwUser.image = UIImage(named: "user")
        }else{
            imgVwUser.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
        }
        
        lblName.text = Store.userDetail?["userName"] as? String ?? ""

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
            lblDocumentType.text =  "Passport"
        }else if Store.userDetail?["identity"] as? Int == 1{
            lblDocumentType.text =  "Driving Licence"
        }else if Store.userDetail?["identity"] as? Int == 2{
            lblDocumentType.text =  "Country ID"
        }else{
            lblDocumentType.text =  ""
        }

        }

    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarHomeVCRoot()
    }
}
