//
//  ProfilePopUpsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import UIKit

class ProfilePopUpsVC: UIViewController {

    @IBOutlet weak var tblVwList: UITableView!
    
    var arrTitle = [String]()
    var callBack:((_ indexx:Int,_ title:String,_ selectIndex:String)->())?
    var isSelect = 1
    var filterIndex = 0
    var type = ""
    let zodiacSigns = [
        "Aries", "Taurus", "Gemini", "Cancer",
        "Leo", "Virgo", "Libra", "Scorpio",
        "Sagittarius", "Capricorn", "Aquarius", "Pisces"
    ]
    var selectedTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        tblVwList.separatorStyle = .none
        
         if isSelect == 1{
            arrTitle.append("Male")
            arrTitle.append("Female")
            arrTitle.append("Others")
            
        }else if isSelect == 2{
            arrTitle.append("White")
            arrTitle.append("Black")
            arrTitle.append("Asian")
            arrTitle.append("Indian")
            arrTitle.append("Hispanic")
            arrTitle.append("Middle Eastern")
            arrTitle.append("Other")
            
        }else if isSelect == 3{
            arrTitle.append("Jawan")
            arrTitle.append("Munawwar Rangila")
            arrTitle.append("Salsabilla")
            arrTitle.append("Now Entertainment")
        }else if isSelect == 4{
            arrTitle.append("No")
            arrTitle.append("Occasionally")
            arrTitle.append("Regularly")
           
        }else if isSelect == 5{
            arrTitle.append("No")
            arrTitle.append("Socially")
            
            arrTitle.append("Regularly")
        }else if isSelect == 6{
            arrTitle.append("Yoga")
            arrTitle.append("Long Walk")
            arrTitle.append("Boxing")
            arrTitle.append("Strength")
        }else if isSelect == 7{
           arrTitle.append("Monthly")
           arrTitle.append("Yearly")
           arrTitle.append("Weekly")

       }else if isSelect == 9{
           tblVwList.isScrollEnabled = false
           arrTitle.append("All")
           arrTitle.append("Favorite")
           arrTitle.append("Unread Messages")
           arrTitle.append("Rejected Proposal")
           arrTitle.append("Ongoing Contracts")
           arrTitle.append("Complete Contracts")
           
           
       }else if isSelect == 11{
           //contracts
           arrTitle.append("All")
           arrTitle.append("Ongoing")
           arrTitle.append("Completed")
           
       }else if isSelect == 12{
           //mycontracts
           arrTitle.append("All")
           arrTitle.append("Upcoming")
           arrTitle.append("Ongoing")
           arrTitle.append("Completed")
           
       }else if isSelect == 13{
           //mycontracts
           arrTitle.append("Passport")
           arrTitle.append("Driving License")
           arrTitle.append("Country ID")
           
       }else if isSelect == 20{
           arrTitle.append(contentsOf: zodiacSigns)
       }else{
            arrTitle.append("Slim")
            arrTitle.append("Fit")
            arrTitle.append("Muscular")
            arrTitle.append("Average")
            arrTitle.append("Curvy")
        }

    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tblVwList.reloadData()
            
        }
    }


}
//MARK: - UITableViewDelegate
extension ProfilePopUpsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePopUpTVC", for: indexPath) as! ProfilePopUpTVC
        
        if traitCollection.userInterfaceStyle == .dark {
            
            if isSelect == 9 || isSelect == 11 || isSelect == 12{
                if indexPath.row == filterIndex{
                    cell.widthImgVwTick.constant = 15
                    cell.lblTitle.textColor = UIColor(hex: "#830D9A")
                }else{
                    cell.widthImgVwTick.constant = 0
                    cell.lblTitle.textColor = .white
                }
            }else{
                if arrTitle[indexPath.row] == selectedTitle {
                    cell.viewBack.backgroundColor = .app
                    cell.lblTitle.textColor = .white
                }else{
                    cell.viewBack.backgroundColor = .clear
                    cell.lblTitle.textColor = .white
                }
                cell.widthImgVwTick.constant = 0
            }
        }else{
            if isSelect == 9 || isSelect == 11 || isSelect == 12{
                if indexPath.row == filterIndex{
                    cell.widthImgVwTick.constant = 15
                    cell.lblTitle.textColor = UIColor(hex: "#830D9A")
                }else{
                    cell.widthImgVwTick.constant = 0
                    cell.lblTitle.textColor = .black
                }
            }else{
                if arrTitle[indexPath.row] == selectedTitle {
                    cell.viewBack.backgroundColor = .app
                    cell.lblTitle.textColor = .white
                }else{
                    cell.viewBack.backgroundColor = .clear
                    cell.lblTitle.textColor = .black
                }
                cell.widthImgVwTick.constant = 0
            }
        }
        
        cell.lblTitle.text = arrTitle[indexPath.row]
//        if arrTitle[indexPath.row] == selectedTitle {
//            cell.viewBack.backgroundColor = .app 
//            cell.lblTitle.textColor = .white
//        } else {
//            if traitCollection.userInterfaceStyle == .dark {
//                cell.viewBack.backgroundColor = .clear
//                cell.lblTitle.textColor = .white
//
//            }else{
//                cell.viewBack.backgroundColor = .clear
//                cell.lblTitle.textColor = .black
//            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            return 45
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false)
        if indexPath.row == 0{
            callBack?(indexPath.row, arrTitle[indexPath.row], "")
        }else{
            callBack?(indexPath.row, arrTitle[indexPath.row], "\(indexPath.row)")
        }
      
        
    }
}

