//
//  HomeVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var lblfilterList: UILabel!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var lblDataFound: UILabel!
    @IBOutlet weak var lblContracts: UILabel!
    @IBOutlet weak var lblAllContracts: UILabel!
    @IBOutlet weak var btnContracts: UIButton!
    @IBOutlet weak var btnAllContracts: UIButton!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var lblFilterResult: UILabel!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var tblVwList: UITableView!
    
    //MARK: - VARIABLE
    
    var arrList = ["Ellipse 1","Ellipse 3","Ellipse 4","Ellipse 5","Ellipse 6"]
    var viewModel = ContractsVM()
    var arrContract = [Message]()
    var page = 1
    var limit = 10
    var selectIndex = 0
    var filterIndexContract = 0
    var filterIndexMyContract = 0
    var isCalling = false
    var isLoading = false
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
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
            tblVwList.reloadData()
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            lblDataFound.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            btnAllContracts.setTitleColor(.white, for: .normal)
            btnContracts.setTitleColor(.white, for: .normal)
            lblContracts.textColor = .white
            lblAllContracts.textColor = .white
        }else{
            lblDataFound.textColor = UIColor(hex: "#6F7179")
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            btnAllContracts.setTitleColor(.black, for: .normal)
            btnContracts.setTitleColor(UIColor(hex: "#898989"), for: .normal)
            lblContracts.textColor = UIColor(hex: "#898989")
            lblAllContracts.textColor = .black
            
        }
    }
    
    func uiSet(){
        vwHeader.isHidden = false
        vwFilter.isHidden = true
        //all contracts
       getContractsApi(page: page, limit: limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
    }
    
    func getContractsApi(page: Int, limit: Int, showLoader: Bool, filterStatus:Int, selectedIndexParam: Int){
        viewModel.allContractApi(page: page, limit: limit, showLoader: showLoader, filterStatus:filterStatus, selectedIndexParam: selectedIndexParam) { data in
            self.isLoading = false
            if page == 1{
                self.arrContract.removeAll()
                self.arrContract = data?.message ?? []
            }else{
                self.arrContract.append(contentsOf: data?.message ?? [])
            }
            
            self.tblVwList.reloadData()
            if self.arrContract.count > 0{
                self.lblDataFound.text = ""
            }else{
                self.lblDataFound.text = "No Data Found!"
                
            }
        }

    }
    
    func getMyContractsApi(page: Int, limit: Int, showLoader: Bool, filterStatus:Int, selectedIndexParam: Int){
        viewModel.myContractApi(page:page, limit: 10, showLoader: showLoader, filterStatus: filterStatus, selectedIndexParam: selectedIndexParam) {  data in
            self.isLoading = false
            if page == 1 {
                self.arrContract.removeAll()
                self.arrContract = data?.message ?? []
            }else{
                self.arrContract.append(contentsOf: data?.message ?? [])
            }
            self.tblVwList.reloadData()
            if self.arrContract.count > 0{
                self.lblDataFound.text = ""
            }else{
                self.lblDataFound.text = "No Data Found!"
            }
        }

    }
    @IBAction func actionThreedot(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        if selectIndex == 0{
            vc.isSelect = 11
            vc.filterIndex = filterIndexContract
            vc.preferredContentSize = CGSize(width: 160, height: 115)
        }else{
            vc.filterIndex = filterIndexMyContract
            vc.isSelect = 12
            vc.preferredContentSize = CGSize(width: 160, height: 150)
        }
        
        vc.modalPresentationStyle = .popover
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        
        vc.callBack = { (index,title,selecIndex) in
            
            
            if self.selectIndex == 0{
                self.arrContract.removeAll()
                self.filterIndexContract = index
                if self.filterIndexContract == 1{
                    // 1 for ongoing
                    
                    self.getContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus: 1, selectedIndexParam: 1)
                    
                }else if self.filterIndexContract == 2{
                    //2 for completed
                    self.getContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus: 3, selectedIndexParam: 1)
                }else{
                    //0 for all
                    self.getContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
                }
                print("index:-\(index) title:-\(title)")
                
            }else{
                //all 4 upcom 0 ongo 1 comple 3
                self.filterIndexMyContract = index
                self.arrContract.removeAll()
                if self.filterIndexMyContract == 1{
                    // 4 for uncoming
                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 0, selectedIndexParam: 1)

                }else if self.filterIndexMyContract == 2{
                    //1 for ongoing
                    self.getMyContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus: 1, selectedIndexParam: 1)
                    
                }else if self.filterIndexMyContract == 3{
                    //3 for completed
                    self.getMyContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus: 3, selectedIndexParam: 1)
                    
                }else{
                    //all
                    self.getMyContractsApi(page: 0, limit: self.limit, showLoader: false, filterStatus:4, selectedIndexParam: 0)
                }

                
                print("index:-\(index) title:-\(title)")

            }
        }
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func actionFilterBtn(_ sender: UIButton) {
//        vwHeader.isHidden = true
//        vwFilter.isHidden = false
//
//        tblVwList.reloadData()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        SceneDelegate().tabBarProfileVCRoot()
    }
    
    @IBAction func actionAllContract(_ sender: UIButton) {
        isLoading = true
        if sender.tag == 0{
            selectIndex = 0
            page = 1
            if traitCollection.userInterfaceStyle == .dark {
                btnAllContracts.setTitleColor(UIColor.white, for: .normal)
                btnContracts.setTitleColor(.white, for: .normal)
                lblAllContracts.backgroundColor = UIColor(hex: "#B70C8E")
                lblContracts.backgroundColor = UIColor(hex: "#EEEEF4")
                
            }else{
                btnAllContracts.setTitleColor(UIColor.black, for: .normal)
                btnContracts.setTitleColor(UIColor(hex: "#898989"), for: .normal)
                lblAllContracts.backgroundColor = UIColor(hex: "#B70C8E")
                lblContracts.backgroundColor = UIColor(hex: "#EEEEF4")
            }
            if filterIndexContract > 0{
                if filterIndexContract == 1{
                    // 1 ongoing
                    self.getContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 1, selectedIndexParam: 1)
                    
                }else if filterIndexContract == 2{
                    //3 completee
                    self.getContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 3, selectedIndexParam: 1)
                    
                }else{
                    
                    self.getContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
                }
                
            }else{
                self.getContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
            }
        }else{
            selectIndex = 1
            page = 1
            if traitCollection.userInterfaceStyle == .dark {
                btnAllContracts.setTitleColor(.white, for: .normal)
                btnContracts.setTitleColor(UIColor.white, for: .normal)
                lblContracts.backgroundColor = UIColor(hex: "#B70C8E")
                lblAllContracts.backgroundColor = UIColor(hex: "#EEEEF4")
            }else{
                btnAllContracts.setTitleColor(UIColor(hex: "#898989"), for: .normal)
                btnContracts.setTitleColor(UIColor.black, for: .normal)
                lblContracts.backgroundColor = UIColor(hex: "#B70C8E")
                lblAllContracts.backgroundColor = UIColor(hex: "#EEEEF4")
            }
            if filterIndexMyContract > 0{
//                if filterIndexMyContract == 1{
//                    //upcoming
//                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 0, selectedIndexParam: 1)
//
//                }else
                if filterIndexMyContract == 1{
                    //ongoing
                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 1, selectedIndexParam: 1)
                    
                }else  if filterIndexMyContract == 2{
                    //complete
                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 0, selectedIndexParam: 1)

                }else{
                    //all
                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)

                }
                
            }else{
                //all
                self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
            }
        }
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContract.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTVC", for: indexPath) as! UserListTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblDescription.textColor = .white
        }else{
            cell.lblDescription.textColor = UIColor(hex: "#656565")
        }
        cell.lblDescription.text = arrContract[indexPath.row].messageList?.last?.message ?? ""
        if selectIndex == 0{
            cell.lblName.text = arrContract[indexPath.row].senders?.name ?? ""
           
            if arrContract[indexPath.row].senders?.profileImage == "" || arrContract[indexPath.row].senders?.profileImage == nil{
                cell.imgVwUser.image = UIImage(named: "user")
            }else{
                cell.imgVwUser.imageLoad(imageUrl: arrContract[indexPath.row].senders?.profileImage ?? "")
            }
            if arrContract[indexPath.row].senders?.videoVerify == 1{
                cell.imgVwTick.isHidden = false
            }else{
                cell.imgVwTick.isHidden = true
            }
        }else{
            cell.lblName.text = arrContract[indexPath.row].recipients?.name ?? ""
            if arrContract[indexPath.row].recipients?.profileImage == "" || arrContract[indexPath.row].recipients?.profileImage == nil{
                cell.imgVwUser.image = UIImage(named: "user")
            }else{
                cell.imgVwUser.imageLoad(imageUrl: arrContract[indexPath.row].recipients?.profileImage ?? "")
            }
            if arrContract[indexPath.row].recipients?.videoVerify == 1{
                cell.imgVwTick.isHidden = false
            }else{
                cell.imgVwTick.isHidden = true
            }
        }
        cell.btnViewContract.tag = indexPath.row
        cell.btnViewContract.addTarget(self, action: #selector(actionViewContract), for: .touchUpInside)
        if indexPath.row == arrContract.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: tblVwList.bounds.width + 1, bottom: 0, right: 0)
        } else {
            cell.separatorInset = .zero
        }
        return cell
    }
    @objc func actionViewContract(sender:UIButton){

      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrContract[indexPath.row].isStatus != 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
            vc.isComingDispute = "Dispute"
            vc.messageId = arrContract[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContractDetailVC") as! ContractDetailVC
           
            vc.messageId = arrContract[indexPath.row].id ?? ""
            vc.index = selectIndex
           
            if selectIndex == 0{
                vc.receiverId = arrContract[indexPath.row].recipients?.id ?? ""
                vc.profileImg = arrContract[indexPath.row].senders?.profileImage ?? ""
                vc.userName = arrContract[indexPath.row].senders?.name ?? ""
                vc.isVerify = arrContract[indexPath.row].senders?.videoVerify ?? 0
            }else{
                vc.receiverId = arrContract[indexPath.row].senders?.id ?? ""
                vc.profileImg = arrContract[indexPath.row].recipients?.profileImage ?? ""
                vc.userName = arrContract[indexPath.row].recipients?.name ?? ""
                vc.isVerify = arrContract[indexPath.row].recipients?.videoVerify ?? 0
            }
//            vc.isDispute = arrContract[indexPath.row].isDispute ?? 0
//            vc.isStatus = arrContract[indexPath.row].isStatus ?? 0
            vc.callBack = {
                self.selectIndex = 1
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectIndex == 0{
            if indexPath.row == arrContract.count - 1 && !isCalling{
                isCalling = true
                page += 1
                self.getContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1)
            }
            }else{
                if indexPath.row == arrContract.count - 1 && !isCalling{
                    isCalling = true
                    page += 1
                    self.getMyContractsApi(page: self.page, limit: self.limit, showLoader: false, filterStatus: 4, selectedIndexParam: 1) 
                }
            }
    }
    
}
// MARK: - Popup
extension HomeVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}
