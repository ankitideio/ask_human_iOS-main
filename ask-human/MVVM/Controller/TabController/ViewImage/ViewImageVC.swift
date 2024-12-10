//
//  ViewImageVC.swift
//  ask-human
//
//  Created by meet sharma on 15/12/23.
//

import UIKit

class ViewImageVC: UIViewController {

    @IBOutlet weak var imgVwUpload: UIImageView!
    
    var uploadImg: Any?
    var imgString = ""
    var isComing = false
    override func viewDidLoad() {
        super.viewDidLoad()

       uiSet()
    }
    func uiSet(){
        if isComing == true{
            imgVwUpload.imageLoad(imageUrl: imgString)
        }else{
            if (((uploadImg as? String) != nil) == true) {
                imgVwUpload.imageLoad(imageUrl: uploadImg as? String ?? "")
                
            }else{
                imgVwUpload.image = uploadImg as? UIImage
                
            }
        }
    }
    @IBAction func actionCrossBtn(_ sender: UIButton) {
        dismiss(animated: false)
    }
    

 
}
