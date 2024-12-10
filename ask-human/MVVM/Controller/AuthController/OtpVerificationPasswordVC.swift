//
//  OtpVerificationPasswordVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import UIKit
import OTPInputView

class OtpVerificationPasswordVC: UIViewController {
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblDontHaveCode: UILabel!
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var lblOTPVerificatin: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var vwOtp: OTPInputView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    var viewModel = AuthVM()
    var emailOrPhone = ""
    var otp:Int?
    var timer: Timer?
    var remainingTime: Int = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        vwOtp.delegateOTP = self
        startTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    
    func startTimer() {
        remainingTime = 60
        lblTimer.text = formatTime(remainingTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            lblTimer.text = formatTime(remainingTime)
            lblTimer.isHidden = false
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
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblTitleMessage.textColor = .white
            lblOTPVerificatin.textColor = .white
            lblDontHaveCode.textColor = .white
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            
        }else{
            
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            lblTitleMessage.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblOTPVerificatin.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblDontHaveCode.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        }
        }
    @IBAction func actionResend(_ sender: UIButton) {
        viewModel.resendApi { data in
            showSwiftyAlert("", "Enter otp: \(data?.otp ?? "")", true)
            self.remainingTime = 60
            self.startTimer()
        }
    }
    
    @IBAction func actionVerify(_ sender: GradientButton) {
        print("otp:--\(otp ?? 0)")
        timer?.invalidate()
        timer = nil
        viewModel.otpVerifyForgotPasswordApi(otp: otp ?? 0, emailOrPhone: emailOrPhone) { data in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            
            self.navigationController?.pushViewController(vc, animated:true)
                
            
            }
        
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension OtpVerificationPasswordVC: OTPViewDelegate {
       func didFinishedEnterOTP(otpNumber: Int) {
           otp = otpNumber
           print("Entered OTP: \(otpNumber)")
       }

       func otpNotValid() {
           // Handle case where entered OTP is not valid
           
           print("Invalid OTP")
       }
   }
