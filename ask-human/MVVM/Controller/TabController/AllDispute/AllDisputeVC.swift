//
//  AllDisputeVC.swift
//  ask-human
//
//  Created by meet sharma on 18/11/23.
//

import UIKit

class AllDisputeVC: UIViewController {
    
    //MARK: - OUTLETS

    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var lblDataFound: UILabel!
    @IBOutlet weak var lblDisputes: UILabel!
    @IBOutlet weak var btnDisputes: UIButton!
    @IBOutlet weak var lblMyDispute: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var tblVwDispute: UITableView!
    @IBOutlet weak var btnMyDispute: UIButton!
    
    var viewModel = DisputeVM()
    var arrDispute = [Dispute]()
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
          uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwDispute.reloadData()
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            lblNoData.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            btnMyDispute.setTitleColor(.white, for: .normal)
            btnDisputes.setTitleColor(.white, for: .normal)
            lblDisputes.textColor = .white
            lblMyDispute.textColor = .white
        }else{
            lblNoData.textColor = UIColor(hex: "#6F7179")
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            btnMyDispute.setTitleColor(.black, for: .normal)
            btnDisputes.setTitleColor(UIColor(hex: "#898989"), for: .normal)
            lblDisputes.textColor = .black
            lblMyDispute.textColor = .black
        }
    }
    func uiSet(){
        viewModel.getMyDispute { data in
            self.arrDispute.removeAll()
            self.arrDispute = data?.disputeList ?? []
            self.tblVwDispute.reloadData()
            if self.arrDispute.count > 0{
                self.lblNoData.text = ""
            }else{
                self.lblNoData.text = "No Data Found!"
            }
        }
    }
    //MARK: - ACTIONS
    
    @IBAction func actionMyDispute(_ sender: UIButton) {
        if sender.tag == 0{
            if traitCollection.userInterfaceStyle == .dark {
                btnMyDispute.setTitleColor(.white, for: .normal)
                btnDisputes.setTitleColor(.white, for: .normal)
                lblMyDispute.backgroundColor = UIColor(hex: "#B70C8E")
                lblDisputes.backgroundColor = UIColor(hex: "#EEEEF4")
            }else{
                btnMyDispute.setTitleColor(UIColor.black, for: .normal)
                btnDisputes.setTitleColor(UIColor(hex: "#898989"), for: .normal)
                lblMyDispute.backgroundColor = UIColor(hex: "#B70C8E")
                lblDisputes.backgroundColor = UIColor(hex: "#EEEEF4")
            }
            viewModel.getMyDispute { data in
                self.arrDispute.removeAll()
                self.arrDispute = data?.disputeList ?? []
                self.tblVwDispute.reloadData()
                if self.arrDispute.count > 0{
                    self.lblNoData.text = ""
                }else{
                    self.lblNoData.text = "No Data Found!"
                }
            }
           
        }else{
            if traitCollection.userInterfaceStyle == .dark {
                btnMyDispute.setTitleColor(.white, for: .normal)
                btnDisputes.setTitleColor(.white, for: .normal)
                lblDisputes.backgroundColor = UIColor(hex: "#B70C8E")
                lblMyDispute.backgroundColor = UIColor(hex: "#EEEEF4")
            }else{
                btnMyDispute.setTitleColor(UIColor(hex: "#898989"), for: .normal)
                btnDisputes.setTitleColor(UIColor.black, for: .normal)
                lblDisputes.backgroundColor = UIColor(hex: "#B70C8E")
                lblMyDispute.backgroundColor = UIColor(hex: "#EEEEF4")
            }
            viewModel.getDispute { data in
                self.arrDispute.removeAll()
                self.arrDispute = data?.disputeList ?? []
                self.tblVwDispute.reloadData()
                if self.arrDispute.count > 0{
                    self.lblNoData.text = ""
                }else{
                    self.lblNoData.text = "No Data Found!"
                }
            }
           
        }

    }

    
    
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
//        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionFilter(_ sender: UIButton) {
        
    }
    

}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension AllDisputeVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDispute.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisputeListTVC", for: indexPath) as! DisputeListTVC
        cell.lblName.text = "#\(arrDispute[indexPath.row].message?.contractId ?? "")"
        cell.lblReason.text = arrDispute[indexPath.row].reasons?.reason ?? ""
        cell.lblDisputeDate.text = formatDisputeDate(dateString: arrDispute[indexPath.row].createdAt ?? "")
        if traitCollection.userInterfaceStyle == .dark {
            cell.viewBAck.backgroundColor = UIColor(hex: "#161616")
            cell.lblName.textColor = .white
            cell.lblReason.textColor = .white
            cell.lblDisputeDate.textColor = .white
            
            cell.lblTitleDate.textColor = .white
            cell.lblTitleReason.textColor = .white
            cell.lblTitleStatus.textColor = .white
            cell.lblTtielContractId.textColor = .white
        }else{
            cell.lblTtielContractId.textColor = .black
            cell.viewBAck.backgroundColor = UIColor(hex: "#F5F5F5")
            cell.lblName.textColor = UIColor(hex: "#787878")
            cell.lblReason.textColor = UIColor(hex: "#787878")
            cell.lblDisputeDate.textColor = UIColor(hex: "#787878")
            
            cell.lblTitleDate.textColor = .black
            cell.lblTitleReason.textColor = .black
            cell.lblTitleStatus.textColor = .black
            
        }
        if arrDispute[indexPath.row].isStatus == 1{
            cell.btnStatus.setTitle("In Review", for: .normal)
            cell.btnStatus.backgroundColor = UIColor(hex: "D9F1FF")
            cell.btnStatus.setTitleColor(UIColor(hex: "#02A0E3"), for: .normal)
            cell.btnStatus.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 13)
            cell.widthStatusBtn.constant = 77
        }else{
            cell.btnStatus.setTitle("Dispute Resolve", for: .normal)
            cell.btnStatus.backgroundColor = .clear
            cell.btnStatus.setTitleColor(UIColor(hex: "#00C013"), for: .normal)
            cell.btnStatus.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
            cell.widthStatusBtn.constant = 114
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
//        vc.isComing = true
        vc.isComingDispute = "Dispute"
        isRead = true
        vc.messageId = arrDispute[indexPath.row].message?.id ?? ""
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
}
