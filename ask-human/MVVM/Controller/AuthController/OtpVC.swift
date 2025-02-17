//
//  OtpVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/12/23.
//

import UIKit
import OTPInputView



class OtpVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblNotRecievCode: UILabel!
    @IBOutlet var lblEnterOTP: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var lblOtpMessage: UILabel!
    @IBOutlet weak var btnContinue: GradientButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet var vwOtp: OTPInputView!
    @IBOutlet weak var btnResend: UIButton!
    
    //MARK: - VARIABLES
    var viewModel = AuthVM()
    var mobileNo:Int?
    var countryCode:String?
    var otp:Int?
    var viewModelProfile = ProfileVM()
    var timer: Timer?
    var remainingTime: Int = 60
    var mobileOtp,profileComplete:Int?
    var isSignup = false
    var isComing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("mobileNo:--\(mobileNo ?? 0)")
        darkMode()
        startTimer()
    }
    
    func startTimer() {
        remainingTime = 60
        lblTimer.text = formatTime(remainingTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if remainingTime > 0 {
            lblTimer.isHidden = false
            remainingTime -= 1
            lblTimer.text = formatTime(remainingTime)
            btnResend.isHidden = true
        } else {
            timer?.invalidate()
            timer = nil
            lblTimer.text = "00:00"
            btnResend.isHidden = false
            lblTimer.isHidden = true
        }
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                darkMode()
            }
        }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            lblEnterOTP.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblNotRecievCode.textColor = .white
            
        }else{
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblNotRecievCode.textColor = .black
            lblEnterOTP.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        }
        }
    func uiSet() {
        if let mobile = mobileNo {
            let phoneNo = convertPhoneNumber("\(mobile)")
            let message = "We have just sent you 4 digit code via your phone \(phoneNo)"
            let attributedString = NSMutableAttributedString(string: message)
            
            if let range = message.range(of: "\(phoneNo)") {
                let nsRange = NSRange(range, in: message)
                let font = UIFont(name: "Poppins-SemiBold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14)
                attributedString.addAttribute(.font, value: font, range: nsRange)
            }
            
            lblOtpMessage.attributedText = attributedString
        }
        
        vwOtp.delegateOTP = self
    }
    
    func convertPhoneNumber(_ phoneNumber: String) -> String {
        let length = phoneNumber.count
        if length > 4 {
            let startIndex = phoneNumber.index(phoneNumber.endIndex, offsetBy: -4)
            let lastFourDigits = phoneNumber[startIndex..<phoneNumber.endIndex]
            let maskedDigits = String(repeating: "*", count: length - 4)
            return maskedDigits + lastFourDigits
        } else {
            return phoneNumber
        }
    }
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func actionResend(_ sender: UIButton) {
        viewModel.resendApi(phone: String(mobileNo ?? 0), countryCode: countryCode ?? "") { data in
                showSwiftyAlert("", "Enter otp: \(data?.otp ?? "")", true)
                self.remainingTime = 60
                self.startTimer()
        }
    }
    @IBAction func actionContinue(_ sender: GradientButton) {
        timer?.invalidate()
        timer = nil
        guard let enteredOTP = otp else {
                showSwiftyAlert("", "Please enter the OTP.", false)
                return
            }
        if isComing{
            viewModel.phoneVerificationApi(phone: String(mobileNo ?? 0), countryCode: countryCode ?? "", otp: String(otp ?? 0)){ data in
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.message = "Mobile number changed successfully"
                    vc.callBack = {
                        SceneDelegate().loginVCRoot()
                    }
                    self.navigationController?.present(vc, animated: false)
                }
            }
        }else{
            viewModel.phoneVerificationApi(phone: String(mobileNo ?? 0), countryCode: countryCode ?? "", otp: String(otp ?? 0)){ data in
                if self.profileComplete == 0{
                    print("Store.authKe:--000\(Store.authKey ?? "")")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                    vc.mobileNo = self.mobileNo
                    vc.countryCode = Int(self.countryCode ?? "")
                    self.navigationController?.pushViewController(vc, animated:true)
                }else{
                    self.viewModelProfile.getProfileApi { data in
                        Store.autoLogin = "true"
                        if self.isSignup{
                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailVC") as! ConfirmEmailVC
                            self.navigationController?.pushViewController(vc2, animated:true)
                        }else{
                            SceneDelegate().tabBarHomeVCRoot()
                        }
                    }
                }
            }
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
//MARK: - OTPViewDelegate
extension OtpVC: OTPViewDelegate {
       func didFinishedEnterOTP(otpNumber: Int) {
           otp = otpNumber
           print("Entered OTP: \(otpNumber)")
       }

       func otpNotValid() {
           // Handle case where entered OTP is not valid
           
           print("Invalid OTP")
       }
   }
