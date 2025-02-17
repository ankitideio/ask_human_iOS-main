//
//  NoteVM.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/12/23.
//

import Foundation
import UIKit

//MARK: - addNoteApi
class NoteVM{
    var maxAge = ""
    var minAge = ""
    func addNoteApi(note:String, media:[Any],status:String, onSuccess:@escaping((NotesData?,_ message:String?)->())){
        let param:parameters = ["note":note,"status":status,"media":media]
        print(param)
        WebService.service(API.addNote, param: param, service: .post,showHud: true, is_raw_form: true) { (model:AddNotesModel, jsonData, jsonSer) in
            
            onSuccess(model.data,model.message)
        }
    }
    func editQuestionApi(note:String,status:String, onSuccess:@escaping((NotesData?,_ message:String?)->())){
        let param:parameters = ["note":note,"status":status]
        print(param)
        WebService.service(API.addNote, param: param, service: .post,showHud: true, is_raw_form: true) { (model:AddNotesModel, jsonData, jsonSer) in
            
            onSuccess(model.data,model.message)
        }
    }
    
    func updateNoteApi(id:String,note:String,media:[Any],status:String,
                       onSuccess:@escaping((NotesData?,_ message:String?)->())){
        let param: parameters = ["id":id,"note": note,
                                 "media": media,
                                 "status": status]
        
        print(param)
        
        WebService.service(API.updateNote, param: param, service: .put, is_raw_form: true) { (model:AddNotesModel, jsonData, jsonSer) in
            
            onSuccess(model.data,model.message)
        }
    }
    //    func addNoteApi(note:String,
    //                    media:[Any],
    //                    status:String,
    //                    onSuccess:@escaping((NotesData?)->())){
    //        print(media)
    //        var imageStructArr = [ImageStructInfo]()
    //
    //            for (index, mediaItem) in media.enumerated() {
    //                if let image = mediaItem as? UIImage {
    //                    // Handle UIImage (Image)
    //                    let imgStruct = ImageStructInfo(
    //                        fileName: "\(index).png",
    //                        type: "image/png",
    //                        data: image.toData() ,
    //                        key: "media"
    //                    )
    //                    imageStructArr.append(imgStruct)
    //
    //                } else if let videoURL = mediaItem as? URL {
    //                    if let videoData = try? Data(contentsOf: videoURL) {
    //
    //                        let videoFileName = "\(index).MOV"
    //                        let videoStruct = ImageStructInfo(
    //                            fileName: videoFileName,
    //                            type: "video/MOV",
    //                            data: videoData,
    //                            key: "media"
    //                        )
    //                        imageStructArr.append(videoStruct)
    //                    }
    //                }
    //            }
    //            let param: parameters = ["note": note,
    //                                     "media": imageStructArr,
    //                                     "status": status]
    //
    //            print(param)
    //
    //            WebService.service(API.addNote, param: param, service: .post, is_raw_form: false) { (model:AddNotesModel, jsonData, jsonSer) in
    //
    //                onSuccess(model.data)
    //            }
    //        }
    
    //    func updateNoteApi(id:String,note:String,
    //                    media:[Any],
    //                       deleteImg:[String],
    //                    status:String,
    //                    onSuccess:@escaping((NotesData?)->())){
    //        print(media)
    //
    //
    //        var imageStructArr = [Any]()
    //
    //            for (index, mediaItem) in media.enumerated() {
    //                if let image = mediaItem as? UIImage {
    //                    // Handle UIImage (Image)
    //                    let imgStruct = ImageStructInfo(
    //                        fileName: "\(index).png",
    //                        type: "image/png",
    //                        data: image.toData() ,
    //                        key: "media"
    //                    )
    //                    imageStructArr.append(imgStruct)
    //
    //                } else if let videoURL = mediaItem as? URL {
    //                    if let videoData = try? Data(contentsOf: videoURL) {
    //
    //                        let videoFileName = "\(index).MOV"
    //                        let videoStruct = ImageStructInfo(
    //                            fileName: videoFileName,
    //                            type: "video/MOV",
    //                            data: videoData,
    //                            key: "media"
    //                        )
    //                        imageStructArr.append(videoStruct)
    //                    }
    //                }else{
    //                    imageStructArr.append(mediaItem as? String ?? "")
    //                }
    //            }
    //        let param: parameters = ["id":id,"note": note,
    //                                     "media": imageStructArr,
    //                                 "status": status,"myimages":deleteImg]
    //
    //            print(param)
    //
    //            WebService.service(API.updateNote, param: param, service: .put, is_raw_form: false) { (model:AddNotesModel, jsonData, jsonSer) in
    //
    //                onSuccess(model.data)
    //            }
    //        }
    //
    func getNoteApi(onSuccess:@escaping(([DraftList]?)->())){
        WebService.service(API.getNote,service: .get,is_raw_form: true){(model:GetDraftNoteModel,jsonData,jsonSer) in
            onSuccess(model.data?.draftList)
        }
    }
    
    func getUserDetailApi(userId:String,onSuccess:@escaping((UserData?)->())){
        
        WebService.service(API.userDetail,urlAppendId: userId,service: .get,is_raw_form: true){(model:GetUserDetailModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    
    func searchUserApi(search:String,
                       userId:String,
                       page:Int,
                       limit:Int,
                       gender:[Int],
                       ethnicity:[String],
                       zodiac:[String],
                       language:[String],
                       minPrice:String,
                       maxPrice:String,
                       hashtags:[String],
                       minage:String,
                       maxage:String,
                       rating:String,
                       loader:Bool,
                       onSuccess:@escaping((GetSearchData?)->())){
        var param = [String:Any]()
        param = [
            "search": search,
            "userId":"",
            "offset": page,
            "limit":limit,
            "gender":gender ,
            "ethnicity":ethnicity,
            "zodiac": zodiac ,
            "language":language,
            "minPrice":minPrice ,
            "maxPrice":maxPrice  ,
            "hashtags":hashtags,
            "minage": minage,
            "maxage":maxage,
            "rating":rating]
        print(param)
        WebService.service(API.allUserList,param: param,service: .post, showHud: loader,is_raw_form: true) { (model:SearchUserModel,jsonData,jsonSer)
            in
            onSuccess(model.data)
        }
    }
    func getTrendingHashtagApi(onSuccess:@escaping((GetHashtagData?)->())){
        
        WebService.service(API.trendingHashtag,service: .get,showHud: false,is_raw_form: true){(model:TrendingHashtagModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func getEthnicityApi(onSuccess:@escaping((GetEthnicData?)->())){
        WebService.service(API.getEthinicity,service: .get,showHud: false,is_raw_form: true){(model:EthnicModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func addEthnicityApi(ethnic:String,
                         onSuccess:@escaping(()->())){
        let param: parameters = ["ethnic":ethnic]
        print(param)
        WebService.service(API.addEthnicity, param: param, service: .post, is_raw_form: true) { (model:CommonModel, jsonData, jsonSer) in
            
            onSuccess()
        }
    }
    
    func getLanguagesApi(onSuccess:@escaping((GetLanguageData?)->())){
        WebService.service(API.getLanguage,service: .get,showHud: false,is_raw_form: true){(model:GetLanguageModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func addLanguagesApi(name: String, onSuccess: @escaping (GetLanguageData?) -> Void) {
        let param: [String: Any] = ["name": name]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
                WebService.service(API.addLanguage, param: jsonString, service: .post,showHud: false, is_raw_form: false) { (model: GetLanguageModel, _, _) in
                    showSwiftyAlert("", model.message ?? "", true)
                    onSuccess(model.data)
                }
            } else {
                print("Failed to convert JSON to string.")
                return
            }
            print("jsonData:--\(jsonData)")
            
        } catch {
            // Print error if JSONSerialization fails
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
    }
    
    func deleteDraft(id:String,onSuccess:@escaping((CommonModel?)->())){
        
        WebService.service(API.deleteDraft,urlAppendId: id,service: .delete,showHud: false,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model)
        }
    }
    
    func draftDetail(id:String,onSuccess:@escaping((DraftDetailData?)->())){
        
        WebService.service(API.draftDetail,urlAppendId: id,service: .get,showHud: false,is_raw_form: true) { (model:DraftDetailModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    
}

