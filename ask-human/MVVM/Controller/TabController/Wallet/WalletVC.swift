//
//  WalletVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class WalletVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var lblYourBalance: UILabel!
    @IBOutlet var lbltitleBalance: UILabel!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    
    //MARK: - variables
    var viewModel = WalletVM()
    var viewModelEarning = EarningVM()
    var currentWeekStartDate: Date = Date()
    var calendar = Calendar.current
    var firstDate = String()
    var secondDate = String()
    var isComing = false
    var callBack:(()->())?
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        uiSet()
        darkMode()
        getWalletApi()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    private func uiSet(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
        self.view.addGestureRecognizer(tapGesture)

    }
    @objc func overlayTapped() {
        self.dismiss(animated: true)
    }
    private func getWalletApi(){
        viewModel.getWalletDetail(showHud: true) { data in
            self.lblBalance.text = "$\(data?.checkWallet?.ammount ?? 0)"
        }
    }
    private func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let textColor: UIColor = isDarkMode ? .white : .black
        let balanceTextColor = isDarkMode ? .white : UIColor(hex: "#727272")

        [lblBalance, lbltitleBalance, lblScreenTitle].forEach { $0?.textColor = textColor }
        lblYourBalance.textColor = balanceTextColor
        btnBack.setImage(UIImage(named: isDarkMode ? "keyboard-backspace25" : "back"), for: .normal)

        viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#161616") : .white
        viewBack.borderCol = isDarkMode ? .clear : UIColor(hex: "#DDDDDD")
        viewBack.borderWid = isDarkMode ? 0 : 1
    }
    private func updateLabel() {
        calendar.firstWeekday = 2
        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeekStartDate))!
        let endDate = calendar.date(byAdding: .day, value: 6, to: startDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date1 = dateFormatter.date(from: dateFormatter.string(from: startDate)),
           let date2 = dateFormatter.date(from: dateFormatter.string(from: endDate)) {
            dateFormatter.dateFormat = "yyyy-M-dd"
            
            let formattedDate1 = dateFormatter.string(from: date1)
            let formattedDate2 = dateFormatter.string(from: date2)
            
            getEarningApi(startData: formattedDate1, endDate: formattedDate2)
            firstDate = formattedDate1
            secondDate = formattedDate2
        } else {
            print("Error converting date strings to Date objects.")
        }
        
        
    }
    private func getEarningApi(startData:String,endDate:String){
        viewModelEarning.getEarningApi(startDate: startData, endDate: endDate, showLoader: true) { data in
            self.lblBalance.text = "$\(data?.walletBalance ?? 0)"
            print("walletBalance:---\(data?.walletBalance ?? 0)")
            
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func actionBack(_ sender: UIButton) {
        //        self.navigationController?.popViewController(animated: true)
        if isComing == true{
            self.navigationController?.popViewController(animated: true)
        }else{
            SceneDelegate().tabBarProfileVCRoot()
        }
        
    }
    
    @IBAction func actionPayNow(_ sender: UIButton) {
        
    }
    
    @IBAction func addPayment(_ sender: GradientButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawAmountVC") as! WithdrawAmountVC
        vc.isComing = true
        vc.callBack = { amount in
            self.viewModel.addWalletAmount(ammount: amount) { data in
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    vc.url = data?.url ?? ""
                    vc.callback = { responseMsg in
                        
                        DispatchQueue.main.async {
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                            vc.modalPresentationStyle = .overFullScreen
                            vc.message = responseMsg
                            vc.callBack = {
                                if self.isComing == true{
                                    
                                    SceneDelegate().tabBarProfileVCRoot()
                                    
                                }else{
                                    self.updateLabel()
                                }
                                
                            }
                            self.navigationController?.present(vc, animated: false)
                        }
                        
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
        DispatchQueue.main.async {
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    
}
