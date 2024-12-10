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
        WebService.service(API.addNote, param: param, service: .post, is_raw_form: true) { (model:AddNotesModel, jsonData, jsonSer) in
            
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
                       page:Int,limit:Int,
                       loader:Bool,
                       isRefer:Bool,
                       onSuccess:@escaping((GetSearchData?)->())){
        if Store.filterAgeSelect?["maxAge"] as? String == ""{
            maxAge = "72"
        }else{
            maxAge = Store.filterAgeSelect?["maxAge"] as? String ?? "72"
        }
        if Store.filterAgeSelect?["minAge"] as? String == ""{
            minAge = "10"
        }else{
            minAge = Store.filterAgeSelect?["minAge"] as? String ?? "10"
        }
        var param = [String:Any]()
        
//        if Store.filterdata?["isFilter"] as? Bool ?? false == false{
        if isRefer == true{
            param = [
               "search": search,
               "userId":userId,
               "gender": Store.filterDetail?["Gender"] as? [String] ?? [],
               "ethnicity":Store.filterDetail?["Ethnicity"] as? [String] ?? [],
               "zodiac":  Store.filterDetail?["Zodiac"] as? [String] ?? [],
               "smoke": Store.filterDetail?["Smoke"] as? [String] ?? [],
               "drink": Store.filterDetail?["Drink"] as? [String] ?? [],
               "workout":  Store.filterDetail?["Workout"] as? [String] ?? [],
               "bodytype":  Store.filterDetail?["BodyType"] as? [String] ?? [],
               "minage": minAge,
               "maxage": maxAge]
        }else{
            param = [
               "search": search,
               "userId":"",
               "gender": Store.filterDetail?["Gender"] as? [String] ?? [],
               "ethnicity":Store.filterDetail?["Ethnicity"] as? [String] ?? [],
               "zodiac":  Store.filterDetail?["Zodiac"] as? [String] ?? [],
               "smoke": Store.filterDetail?["Smoke"] as? [String] ?? [],
               "drink": Store.filterDetail?["Drink"] as? [String] ?? [],
               "workout":  Store.filterDetail?["Workout"] as? [String] ?? [],
               "bodytype":  Store.filterDetail?["BodyType"] as? [String] ?? [],
               "minage": minAge,
               "maxage": maxAge]
        }
             
//        }
        
        print(param)
        WebService.service(API.searchNote,param: param,service: .post, showHud: loader,is_raw_form: true) { (model:SearchUserModel,jsonData,jsonSer)
            in
            onSuccess(model.data)
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

