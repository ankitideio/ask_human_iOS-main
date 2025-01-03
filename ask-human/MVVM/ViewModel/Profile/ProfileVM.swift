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
    //0 for male 1 for female
    func scanDocumentApi(document:UIImage,type:Int,onSuccess:@escaping((_ gender:Int?)->())){
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "jpeg", data: document.toData(), key: "document")
        let param:parameters = ["document":imageInfo,"type":type]
        WebService.service(API.scanDocument,param:param,service:.put,showHud: true,is_raw_form: false) { (model:DocumentModel,jsonData,jsonSer) in
            onSuccess(model.data?.gender)
        }
    }
    func setProfileDetailApi(name:String,
                          about:String,
                          gender:Int,
                          ethnicity:String,
                          zodiac:String,
                          age:Int,
                             dob:String,
                          smoke:String,
                          drink:String,
                          workout:String,
                          bodytype:String,
                             hoursPrice:String,
                             countryCode:String,
                             nationality:String,
                             identity:Int,
                          profileImage:UIImageView,
                             document:UIImageView,
                             imageUpload:Bool,
                             uploadDocument:Bool,
                             hashtags: [[Hashtag]],
                             onSuccess:@escaping((ProfileDetailModel?)->())){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "jpeg", data: profileImage.image?.toData() ?? Data(), key: "profileImage")
        
        
        let imageInfoDocument : ImageStructInfo
        imageInfoDocument = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "jpeg", data: document.image?.toData() ?? Data(), key: "document")
        
        var hashtagDict = [[String: Any]]()
        for tagList in hashtags {
            for tag in tagList {
                let tagInfo: [String: Any] = [
                    "id": tag.id ?? "",
                    "title": tag.title ?? ""
                ]
                hashtagDict.append(tagInfo)
            }
        }
        print("Hashtags dictionary: \(hashtagDict)")
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: hashtagDict)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                var param = [String:Any]()
                if imageUpload == true && uploadDocument == true{
                    param = ["name": name,
                             "about": about,
                             "gender":gender,
                             "ethnicity": ethnicity,
                             "zodiac": zodiac,
                             "age": age,
                             "dob": dob,
                             "smoke": smoke,
                             "drink": drink,
                             "hoursPrice":hoursPrice,
                             "workout": workout,
                             "countryCode": countryCode,
                             "nationality": nationality,
                             "identity": identity,
                             "bodytype": bodytype,
                             "profileImage": imageInfo,
                             "document": imageInfoDocument,
                             "hashtags": jsonString]
                }else if imageUpload == true{
                    param = ["name": name,
                             "about": about,
                             "gender":gender,
                             "ethnicity": ethnicity,
                             "zodiac": zodiac,
                             "age": age,
                             "dob": dob,
                             "smoke": smoke,
                             "drink": drink,
                             "hoursPrice":hoursPrice,
                             "workout": workout,
                             "countryCode": countryCode,
                             "nationality": nationality,
                             "identity": identity,
                             "bodytype": bodytype,
                             "profileImage": imageInfo,
                             "hashtags": jsonString]
                }else if uploadDocument == true{
                    param = ["name": name,
                             "about": about,
                             "gender":gender,
                             "ethnicity": ethnicity,
                             "zodiac": zodiac,
                             "age": age,
                             "dob": dob,
                             "smoke": smoke,
                             "drink": drink,
                             "hoursPrice":hoursPrice,
                             "workout": workout,
                             "countryCode": countryCode,
                             "nationality": nationality,
                             "identity": identity,
                             "bodytype": bodytype,
                             "document": imageInfoDocument,
                             "hashtags": jsonString]
                }else{
                    param = ["name": name,
                             "about": about,
                             "gender":gender,
                             "ethnicity": ethnicity,
                             "zodiac": zodiac,
                             "age": age,
                             "dob": dob,
                             "smoke": smoke,
                             "drink": drink,
                             "hoursPrice":hoursPrice,
                             "workout": workout,
                             "countryCode": countryCode,
                             "nationality": nationality,
                             "identity": identity,
                             "bodytype": bodytype,
                             "hashtags": jsonString]
                }
                
                print(param)
                
                WebService.service(API.updateProfile,param: param,service: .put,is_raw_form: false){(model:ProfileDetailModel,jsonData,jsonSer) in
                    Store.Hashtags = model
                    Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? "","age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"userId":model.data?.user?.id ?? "","dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? "","nationality":model.data?.user?.nationality ?? "","document":model.data?.user?.document ?? "","identity":model.data?.user?.identity ?? ""]
                    
                    //            showSwiftyAlert("", model.message ?? "", true)
                    onSuccess(model)
                }
            }else {
                print("Failed to convert JSON to string.")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func setProfileAfterSocialLoginApi(name:String,
                          age:Int,
                             dob:String,
                             countryCode:String,
                             onSuccess:@escaping((ProfileDetailModel?)->())){
        let param:parameters = ["name": name,
                             "age": age,
                             "dob": dob,
                             "countryCode": countryCode]
                print(param)
                WebService.service(API.updateProfile,param: param,service: .put,is_raw_form: false){(model:ProfileDetailModel,jsonData,jsonSer) in
                    Store.Hashtags = model
                    Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? "","age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"userId":model.data?.user?.id ?? "","dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? "","nationality":model.data?.user?.nationality ?? "","document":model.data?.user?.document ?? "","identity":model.data?.user?.identity ?? ""]
                    onSuccess(model)
                }
    }
    func sendHashtagRequest(id: String, onSuccess: @escaping (VerificationHashtagData?) -> Void) {
        // Parameters for the API request
        let param: [String: Any] = ["id": id]
        
        do {
            // Convert parameters to JSON
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            
            // Check JSON conversion
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            } else {
                print("Failed to convert JSON to string.")
                return
            }
            
            // Call the web service
            WebService.service(API.sendRequestForHashtag, param: param, service: .post, is_raw_form: false) { (model: VerifyHashtagModel, _, _) in
                onSuccess(model.data)
            }
        } catch {
            // Print error if JSONSerialization fails
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
    }


    func getSearchHashtagApi(searchBy:String,onSuccess:@escaping(([GetSearchHashtagData])->())){
        WebService.service(API.getHashtags,urlAppendId: searchBy,service: .get,showHud: false,is_raw_form: false){(model:SearchHashtagModel,jsonData,jsonSer) in
                
            onSuccess(model.data ?? [])
                
        }
    }
    
    func getProfileApi(onSuccess:@escaping((ProfileDetailModel?)->())){
        
        WebService.service(API.getProfile,service: .get,showHud: false,is_raw_form: true){(model:ProfileDetailModel,jsonData,jsonSer) in
            Store.Hashtags = model
            Store.userDetail = ["userName":model.data?.user?.name ?? "","email":model.data?.user?.email ?? "","profile":model.data?.user?.profileImage ?? "","phone":model.data?.user?.mobile ?? 0,"age":model.data?.user?.age ?? 0,"gender":model.data?.user?.gender ?? 0,"ethnicity":model.data?.user?.ethnicity ?? "","zodiac":model.data?.user?.zodiac ?? "","smoke":model.data?.user?.smoke ?? "","drink":model.data?.user?.drink ?? "","workout":model.data?.user?.workout ?? "","bodyType":model.data?.user?.bodytype ?? "","description":model.data?.user?.about ?? "","hoursPrice":model.data?.user?.hoursPrice ?? 0,"userId":model.data?.user?.id ?? "","dob":model.data?.user?.dob ?? "","countryCode":model.data?.user?.countryCode ?? "","nationality":model.data?.user?.nationality ?? "","document":model.data?.user?.document ?? "","identity":model.data?.user?.identity ?? ""]
            
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
