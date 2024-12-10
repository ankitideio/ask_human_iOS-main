//
//  AddDisputeVC.swift
//  ask-human
//
//  Created by meet sharma on 18/11/23.
//

import UIKit
import IQKeyboardManagerSwift

class AddDisputeVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var btnCross: UIButton!
    @IBOutlet weak var tblVwHeight: NSLayoutConstraint!
    @IBOutlet weak var tblVwDispute: UITableView!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var backGroundVw: UIView!
    @IBOutlet weak var txtVwComment: IQTextView!
    @IBOutlet weak var lblSelect: UILabel!
    
    var viewModel = DisputeVM()
    var arrReason = [Reason]()
    var messageId = ""
    var reasonId = ""
    var callBack:((_ message:String)->())?
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwHeight.constant = 0
        backGroundVw.layer.cornerRadius = 40
        backGroundVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        getDisputeReasontApi()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
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
           lblSelect.textColor = .white
            btnDismiss.setTitleColor(.white, for: .normal)
            btnDismiss.borderCol = .white
            btnCross.setImage(UIImage(named: "crosswhite"), for: .normal)
             
        }else{
            btnCross.setImage(UIImage(named: "crossBlack"), for: .normal)
            lblSelect.textColor = .black
            btnDismiss.setTitleColor(.black, for: .normal)
            btnDismiss.borderCol = UIColor(hex: " #DCDCDC")
        }
    }
    func getDisputeReasontApi(){
        let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           txtVwComment.textContainerInset = padding
        viewModel.getDisputeResonList { data in
            self.arrReason = data?.reasonList ?? []
            
            self.tblVwDispute.reloadData()
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            print("Touch")
            tblVwHeight.constant = 0
            let touch = touches.first
            if touch?.view != self.backGroundVw
            { self.dismiss(animated: true, completion: nil) }
        }
    //MARK: - ACTIONS
    
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionAddDispute(_ sender: GradientButton) {
        if lblSelect.text == "Please Select"{
            showSwiftyAlert("", "Please select a reason.", false)
        }
//        else if txtVwComment.text == ""{
//            showSwiftyAlert("", "Enter your comment", false)
//        }
        else{
            viewModel.addDispute(reasonId: reasonId, messageId: messageId, comment: txtVwComment.text ?? "") { message in
//
                self.dismiss(animated: false)
                self.callBack?(message)

       
            }
        }
       
    }
    
    @IBAction func actionSelect(_ sender: UIButton) {
        if arrReason.count < 5{
            self.tblVwHeight.constant = CGFloat(50*(arrReason.count))
        }else{
            self.tblVwHeight.constant = 250
        }
       }
  
    
    
}
extension AddDisputeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReason.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReasonDisputeTVC", for: indexPath) as! ReasonDisputeTVC
        cell.lblReason.text = arrReason[indexPath.row].reason ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lblSelect.text = arrReason[indexPath.row].reason ?? ""
        self.reasonId = arrReason[indexPath.row].id ?? ""
        tblVwHeight.constant = 0
        
    }
}
