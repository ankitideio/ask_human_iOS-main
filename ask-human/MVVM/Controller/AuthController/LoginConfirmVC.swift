//
//  LoginConfirmVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit
import AuthenticationServices
import GoogleSignInSwift

class LoginConfirmVC: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet var lblDontHaveAccount: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    
    @IBOutlet var btnSigninApple: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - VARIABLES
    var viewModel = AuthVM()
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleSignIn.shared.delegate = self
       
    }
  
    override func viewWillAppear(_ animated: Bool) {
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                uiSet()
            }
        }
    func uiSet(){
        if traitCollection.userInterfaceStyle == .dark {
            btnSigninApple.borderWid = 1
            btnSigninApple.borderCol = .white
            btnSigninApple.cornerRadi = 24
            imgVwTitle.image = UIImage(named: "ddd")
            lblDontHaveAccount.textColor = .white
            lblTitle.textColor = .white
            
            applyGradientColor(to: lblTitle, with: "ASK", gradientColors: [UIColor(red: 240/255, green: 11/255, blue: 128/255, alpha: 1.0).cgColor, UIColor(red: 122/255, green: 13/255, blue: 158/255, alpha: 1.0).cgColor])
                } else {
                    
                    lblTitle.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    
                    applyGradientColor(to: lblTitle, with: "ASK", gradientColors: [UIColor(red: 240/255, green: 11/255, blue: 128/255, alpha: 1.0).cgColor, UIColor(red: 122/255, green: 13/255, blue: 158/255, alpha: 1.0).cgColor])
                    imgVwTitle.image = UIImage(named: "dddlll")
                    
                    lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    btnSigninApple.borderWid = 0
                    btnSigninApple.borderCol = .black
                }
    }
    //MARK: - ACTIONS
    
    @IBAction func actionSignupEmail(_ sender: UIButton) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionSigninGoogle(_ sender: UIButton) {
        GoogleSignIn.shared.email = true
        GoogleSignIn.shared.presentingWindow = view.window
        GoogleSignIn.shared.signIn()
        
    }
    
    @IBAction func actionSignInApple(_ sender: UIButton) {
        self.setupSOAppleSignIn()
    }
    func setupSOAppleSignIn() {

           actionHandleAppleSignin()

       }

   func actionHandleAppleSignin() {

           let appleIDProvider = ASAuthorizationAppleIDProvider()

           let request = appleIDProvider.createRequest()

           request.requestedScopes = [.fullName, .email]

           let authorizationController = ASAuthorizationController(authorizationRequests: [request])

           authorizationController.delegate = self

           authorizationController.presentationContextProvider = self

           authorizationController.performRequests()

       }
    @IBAction func actionSignUp(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
extension LoginConfirmVC: ASAuthorizationControllerDelegate {


        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

            print(error.localizedDescription)

        }

           // ASAuthorizationControllerDelegate function for successful authorization

        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

                // Create an account as per your requirement

                let appleId = appleIDCredential.user

                let appleUserFirstName = appleIDCredential.fullName?.givenName

                let appleUserLastName = appleIDCredential.fullName?.familyName

                let appleUserEmail = appleIDCredential.email
                
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.viewModel.socialaAuthApi(socialId: appleId, socialType: "apple", email: appleUserEmail ?? "", fcmToken: Store.deviceToken ?? "") { data in
                        Store.authKey = data?.token ?? ""
                        Store.isSocialLogin = true
                            if data?.user?.profileComplete == 0{
                                
                                let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginDetailsVC") as! SocialLoginDetailsVC
                                vc2.userName = (appleUserFirstName ?? "") + (appleUserLastName ?? "")
                                self.navigationController?.pushViewController(vc2, animated:true)
                                
                            }else{
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                                Store.autoLogin = "true"
                                vc.isComing = false
                                Store.selectTabIndex = 1
                                self.navigationController?.pushViewController(vc, animated:true)
                                
                            }
                    }
                }

            } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

                let appleUsername = passwordCredential.user

                let applePassword = passwordCredential.password

                //Write your code

            }

        }

    }

extension LoginConfirmVC: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
extension LoginConfirmVC: GoogleSignInDelegate {
    func googleSignIn(didSignIn auth: GoogleSignIn.Auth?, user: GoogleSignIn.User?, error: Error?) {
        if let email = user?.email {
            DispatchQueue.main.asyncAfter(deadline: .now()){
                self.viewModel.socialaAuthApi(socialId: user?.id ?? "", socialType: "google", email: user?.email ?? "", fcmToken: Store.deviceToken ?? "") { data in
                    Store.isSocialLogin = true
                    Store.authKey = data?.token ?? ""
                        if data?.user?.profileComplete == 0{
                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginDetailsVC") as! SocialLoginDetailsVC
                            vc2.userName = user?.name ?? ""
                            self.navigationController?.pushViewController(vc2, animated:true)

                        }else{
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                            Store.autoLogin = "true"
                            vc.isComing = false
                            Store.selectTabIndex = 1
                            self.navigationController?.pushViewController(vc, animated:true)
                            
                        }
                    

                }
            }
          
            
        } else {
            print("Google User Email not available")
        }
    
}
}
