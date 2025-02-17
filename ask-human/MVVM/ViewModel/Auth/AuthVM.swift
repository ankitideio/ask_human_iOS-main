//
//  AuthVM.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation
class AuthVM{
    
    //MARK: - signUpApi
    func signUpApi(email:String,
                   name:String,
                   age:String,
                   mobile:String,
                   password:String,
                  // confirmPassword:String,
                   countryCode:String,
                   dob:String,
                   fcmToken:String,
                   onSuccess:@escaping((SignUpModel?)->())){
        
        let param: parameters = ["email": email,
                                 "name": name,
                                 "age": age,
                                 "mobile": mobile,
                                 "password":password,
                                // "confirmPassword": confirmPassword,
                                 "countryCode": countryCode,
                                 "dob": dob,
                                 "fcmToken": fcmToken]
            print(param)
        WebService.service(API.signUp,param: param,service: .post,is_raw_form: true){(model:SignUpModel,jsonData,jsonSer) in
            Store.authKey = model.data?.token ?? ""
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? 0,"age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","userId":model.data?.user?.id ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? ""]

            onSuccess(model)
        }
    }
    //MARK: - logInApi
                                 
    func logInApi(phone:String,
                  countryCode:String,
                  otp:String,
                  fcmToken:String,
                   onSuccess:@escaping((LoginData?)->())){
        
        let param: parameters = ["phone": phone,
                                 "countryCode": countryCode,
                                 "otp": otp,
                                 "fcmToken": fcmToken]
        
            print(param)
        
        WebService.service(API.logIn,param: param,service: .post,is_raw_form: true){(model:LoginModel,jsonData,jsonSer) in
            Store.authKey = model.data?.user?.token ?? ""
            WebSocketManager.shared.initialize(userId: model.data?.user?.id ?? "")
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.mobile ?? 0,"age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","userId":model.data?.user?.id ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? ""]
           
            onSuccess(model.data)
        }
    }
    func signinInApi(phone:String,
                  countryCode:String,
                     dob:String,
                     name:String,
                     age:String,
                   onSuccess:@escaping((LoginData?)->())){
        
        let param: parameters = ["phone": phone,
                                 "countryCode": countryCode,
                                 "dob": dob,
                                 "name": name,
                                 "age": age]
        
            print(param)
        
        WebService.service(API.logIn,param: param,service: .post,is_raw_form: true){(model:LoginModel,jsonData,jsonSer) in
            Store.authKey = model.data?.user?.token ?? ""
            WebSocketManager.shared.initialize(userId: model.data?.user?.id ?? "")
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.mobile ?? 0,
                                "age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","userId":model.data?.user?.id ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? ""]
           
            onSuccess(model.data)
        }
    }
    func loginInByMobileNumberApi(phone:String,
                  countryCode:String,
                   onSuccess:@escaping((LoginData?)->())){
        
        let param: parameters = ["phone": phone,
                                 "countryCode": countryCode]
        
            print(param)
        
        WebService.service(API.logIn,param: param,service: .post,is_raw_form: true){(model:LoginModel,jsonData,jsonSer) in
            Store.authKey = model.data?.user?.token ?? ""
            WebSocketManager.shared.initialize(userId: model.data?.user?.id ?? "")
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.mobile ?? 0,
                                "age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","userId":model.data?.user?.id ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? ""]
           
            onSuccess(model.data)
        }
    }

    //MARK: - PHONE OTP VERIFICATION
    func phoneVerificationApi(phone:String,
                              countryCode:String,
                              otp:String,
                   onSuccess:@escaping((VerificationData?)->())){
        
        let param: parameters = ["phone": phone,
                                 "countryCode": countryCode,
                                 "otp": otp,
                                 "fcmToken": Store.deviceToken ?? ""]
        
            print(param)
        
        WebService.service(API.signUpWithPhone,param: param,service: .post,is_raw_form: true){(model:PhoneVerificatioModel,jsonData,jsonSer) in
            Store.authKey = model.data?.token ?? ""
            onSuccess(model.data)
        }
    }
    //MARK: - RESEND OTP
    func resendApi(phone:String,countryCode:String,onSuccess:@escaping((DataClass?)->())){
        let param: parameters = ["phone": phone,
                                 "countryCode":countryCode]
        
            print(param)
        WebService.service(API.resendOtp,param: param,service: .post,is_raw_form: true){(model:ResendOtpModel,jsonData,jsonSer) in
            
            onSuccess(model.data)
        }
    }
    
    func userResendApi(onSuccess:@escaping((DataClass?)->())){
        
        WebService.service(API.userResendOtp,service: .post,is_raw_form: true){(model:ResendOtpModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    //MARK: - signInWithGoogleApi
    
    func socialaAuthApi(socialId:String,
                           socialType:String,
                           email:String,
                           fcmToken:String,
                   onSuccess:@escaping((LoginData?)->())){
        
        let param: parameters = ["socialId": socialId,
                                 "socialType":socialType,
                                 "email":email,
                                 "fcmToken":fcmToken]
        
            print(param)
        
        WebService.service(API.loginWithGoogle,param: param,service: .post,is_raw_form: true){(model:LoginModel,jsonData,jsonSer) in
            Store.userDetail = ["email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.mobile ?? 0,"age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","userId":model.data?.user?.id ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? ""]
            WebSocketManager.shared.initialize(userId: model.data?.user?.id ?? "")
            onSuccess(model.data)
        }
    }
    //MARK: - FORGOT PASSWORD
    func forgotPasswordApi(emailOrPhone:String,
                           onSuccess:@escaping((GetForgotData?,_ message:String?)->())){
        
        let param: parameters = ["emailOrPhone": emailOrPhone]
        
            print(param)
        
        WebService.service(API.forgotPassword,param: param,service: .post,is_raw_form: true){(model:ForgotPasswordModel,jsonData,jsonSer) in
            Store.authKey = model.data?.token ?? ""
            onSuccess(model.data,model.message)
        }
    }
    //MARK: - FORGOT PASSWORD OTP VERIFICATION
    func otpVerifyForgotPasswordApi(otp:Int,
                                    emailOrPhone:String,
                   onSuccess:@escaping((GetOtpVerifyData?)->())){
        
        let param: parameters = ["otp": otp,
                                 "emailOrPhone":emailOrPhone]
        
            print(param)
        
        WebService.service(API.otpVerifyforgotPassword,param: param,service: .post,is_raw_form: true){(model:OtpVerifyForgotPasswordModel,jsonData,jsonSer) in
            
            onSuccess(model.data)
        }
    }
    //MARK: - RESET PASSWORD
    func setNewPasswordApi(token:String,
                                    password:String,
                                    confirmPassword:String,
                   onSuccess:@escaping((GetOtpVerifyData?)->())){
        
        let param: parameters = ["token": token,
                                 "password":password,
                                 "confirmPassword":confirmPassword]
        
            print(param)
        
        WebService.service(API.setNewPasswrd,param: param,service: .post,is_raw_form: true){(model:OtpVerifyForgotPasswordModel,jsonData,jsonSer) in
            
            onSuccess(model.data)
        }
    }
}

