//
//  ProfileVM.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import Foundation
import UIKit

class ProfileVM{
    //MARK: - PROFILE API
    
    func setProfileDetailApi(name:String,
                          about:String,
                          gender:Int,
                          ethnicity:String,
                          zodiac:String,
                          age:Int,
                          smoke:String,
                          drink:String,
                          workout:String,
                          bodytype:String,
                          price:String,
                          profileImage:UIImageView,
                             imageUpload:Bool,
                   onSuccess:@escaping((ProfileDetailModel?)->())){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "jpeg", data: profileImage.image?.toData() ?? Data(), key: "profileImage")
        var param = [String:Any]()
        if imageUpload == true{
            param = ["name": name,
                    "about": about,
                    "gender":gender,
                    "ethnicity": ethnicity,
                    "zodiac": zodiac,
                    "age": age,
                    "smoke": smoke,
                    "drink": drink,
                     "hoursPrice":price,
                    "workout": workout,
                    "bodytype": bodytype,
                    "profileImage": imageInfo]
        }else{
            param = ["name": name,
                    "about": about,
                    "gender":gender,
                    "ethnicity": ethnicity,
                    "zodiac": zodiac,
                    "age": age,
                    "hoursPrice":price,
                    "smoke": smoke,
                    "drink": drink,
                    "workout": workout,
                    "bodytype": bodytype]
        }
        
            print(param)
       
        WebService.service(API.updateProfile,param: param,service: .put,is_raw_form: false){(model:ProfileDetailModel,jsonData,jsonSer) in
           
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? "","age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"userId":model.data?.user?.id ?? ""]
           
//            showSwiftyAlert("", model.message ?? "", true)
            onSuccess(model)
        }
    }
    
    
    func getProfileApi(onSuccess:@escaping((ProfileDetailModel?)->())){
        
        WebService.service(API.getProfile,service: .get,showHud: false,is_raw_form: true){(model:ProfileDetailModel,jsonData,jsonSer) in
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? 0,"age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"userId":model.data?.user?.id ?? ""]
            WebSocketManager.shared.initialize(userId: model.data?.user?.id ?? "")
            onSuccess(model)
            
        }
    }
    
    func updatePriceApi(price:String,onSucess:@escaping(()->())){
        let param:parameters = ["hoursPrice":price]
        print(param)
        WebService.service(API.updateProfile,param: param,service: .put,is_raw_form: false){(model:ProfileDetailModel,jsonData,jsonSer) in
            onSucess()
        }
    }
    
    func logoutApi(onSuccess:@escaping(()->())){
        let param:parameters = ["fcmToken":Store.deviceToken ?? ""]
        WebService.service(API.logout,param:param,service: .post,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
            
            onSuccess()
            
        }
    }
    
    func changePasswordApi(oldPassword:String,
                           newPassword:String,
                           confirmPassword:String,
                           onSuccess:@escaping((CommonModel?)->())){
        let param: parameters = ["oldPassword": oldPassword,
                                 "newPassword": newPassword,
                                 "confirmPassword": confirmPassword]
        
            print(param)
        
        WebService.service(API.changePassword,param: param,service: .put,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
//            showSwiftyAlert("", model.message ?? "", true)
            onSuccess(model)
            
        }
    }
    
    func changeEmailApi(email:String,
                        onSuccess:@escaping((_ message:String?)->())){
        let param: parameters = ["email": email]
        
            print(param)
        
        WebService.service(API.changeEmail,param: param,service: .put,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message)
            
        }
    }
    
    func changePhoneNumberApi(phoneNO:Int,
                              countryCode:String,
                              onSuccess:@escaping((GetOtpData?)->())){
        let param: parameters = ["phoneNO": phoneNO,"countryCode":countryCode]
        
            print(param)
        
        WebService.service(API.changePhone,param: param,service: .put,is_raw_form: true){(model:AddMobileAndEmailModel,jsonData,jsonSer) in
            onSuccess(model.data)
            
        }
    }
    func verifyChangeMobileNumberApi(otp:Int,
                                     onSuccess:@escaping((_ message:String?)->())){
        let param: parameters = ["otp": otp]
        
            print(param)
        
        WebService.service(API.changePhoneNumberVerify,param: param,service: .put,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
            
            onSuccess(model.message ?? "")
            
        }
    }
    func verifyChangeEmailApi(token:String,
                              onSuccess:@escaping((_ message:String?)->())){
        
        WebService.service(API.changeEmailVerify,service: .get,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message ?? "")
            
        }
    }
    func transactionHistoryApi(onSuccess:@escaping(([TransactionList]?)->())){
        
        WebService.service(API.transactionHistory,service: .get){(model:TransactionHistoryModel,jsonData,jsonSer) in
            
            onSuccess(model.data)
            
        }
    }
}
