//
//  AddNoteVC.swift
//  ask-human
//
//  Created by meet sharma on 18/11/23.
//

import UIKit

class AddNoteVC: UIViewController {

    //MARK: - OUTLET
    
   
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var imgVwTile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
  
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = "Hi, \(Store.userDetail?["userName"] as? String ?? "")"
        
    }
    override func viewWillAppear(_ animated: Bool) {
  
        WebService.hideLoader()
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
            imgVwTile.image = UIImage(named: "askhumanicondark")
            lblName.textColor = .white
            lblTitleMessage.textColor = .white
        }else{
            imgVwTile.image = UIImage(named: "askhumaniconlight")
            lblName.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblTitleMessage.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        }
        }
        //MARK: - ACTION
    
    @IBAction func actionAddNote(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchNoteVC") as! SearchNoteVC
        Store.isRefer = false
        Store.isComingDraft = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
