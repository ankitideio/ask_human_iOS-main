//
//  HashtagListVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 19/12/24.
//

import UIKit

class HashtagListVC: UIViewController {
    //MARK: -IBOutlet
    @IBOutlet var lblNodata: UILabel!
    @IBOutlet var lblScreentitle: UILabel!
    @IBOutlet var heightTblvw: NSLayoutConstraint!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnCross: UIButton!
    @IBOutlet var tblVwList: UITableView!
    
    var viewModel = ProfileVM()
    var callBack:(()->())?
    var arrNewHashtags = [Hashtag]()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        let nib = UINib(nibName: "HashtagListForVerifyTVC", bundle: nil)
        tblVwList.register(nib, forCellReuseIdentifier: "HashtagListForVerifyTVC")
           
        viewBack.layer.cornerRadius = 30
        viewBack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if arrNewHashtags.count > 0{
            lblNodata.isHidden = true
            heightTblvw.constant = CGFloat(arrNewHashtags.count*60)
        }else{
            lblNodata.isHidden = false
            heightTblvw.constant = CGFloat(2*60)
        }
        print(arrNewHashtags)
        tblVwList.reloadData()
    }
    
    //MARK: -IBAction
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
//MARK: - UITableViewDelegate
extension HashtagListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrNewHashtags.count > 0{
            return arrNewHashtags.count
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagListForVerifyTVC", for: indexPath) as! HashtagListForVerifyTVC
        if arrNewHashtags.count > 0{
            if arrNewHashtags[indexPath.row].isVerified == 1{
                cell.btnRequest.isHidden = false
                cell.viewVerified.isHidden = true
                cell.btnRequest.setTitle("Verified", for: .normal)
                cell.btnRequest.tag = indexPath.row
                cell.btnRequest.backgroundColor = .white
                cell.btnRequest.setTitleColor(.app, for: .normal)


            }else if arrNewHashtags[indexPath.row].isVerified == 2{
                cell.btnRequest.isHidden = false
                cell.viewVerified.isHidden = true

                cell.btnRequest.setTitle("Send Request", for: .normal)
                cell.btnRequest.tag = indexPath.row
                cell.btnRequest.addTarget(self, action: #selector(actionRequest), for: .touchUpInside)
                cell.btnRequest.backgroundColor = .white
                cell.btnRequest.setTitleColor(.app, for: .normal)

            }else{
                cell.btnRequest.isHidden = false
                cell.viewVerified.isHidden = true
                cell.btnRequest.backgroundColor = UIColor(hex: "#49ADF4")
                cell.btnRequest.setTitleColor(.white, for: .normal)
                cell.btnRequest.setTitle("Pending", for: .normal)
            }
            cell.lblHashtag.text = arrNewHashtags[indexPath.row].title ?? ""
        }
        return cell
    }
    @objc func actionRequest(sender:UIButton){
        viewModel.sendHashtagRequest(id: arrNewHashtags[sender.tag].id ?? "") {_ in 
            self.dismiss(animated: true)
            self.callBack?()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
