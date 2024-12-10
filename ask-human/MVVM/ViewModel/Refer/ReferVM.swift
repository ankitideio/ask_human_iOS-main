//
//  ReferVM.swift
//  ask-human
//
//  Created by meet sharma on 19/06/24.
//

import Foundation

class ReferVM{
    func applyRefer(messageId:String,notesId:String,message:String,onSucess:@escaping((_ message:String?)->())){
        
        let param:parameters = ["messageId":messageId,"notesId":notesId,"message":message]
        print(param)
        WebService.service(API.applyReferInvitation,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSucess(model.message)
        }
    }
    
    func acceptRejectRefer(notesId: String, userId: String, status: String, onSucess: @escaping ((_ message:String?) -> ())) {
        let urlAppendId = "\(notesId)/\(userId)/\(status)"
        print("urlAppendId:--\(urlAppendId)")
        
        WebService.service(API.acceptRejectReferProposal, urlAppendId: urlAppendId, service: .put, is_raw_form: true) { (model: CommonModel, jsonData, jsonSer) in
            onSucess(model.message)
        }
    }
    
    func getAppliedrequests(limit:Int,offset:Int,onSucces:@escaping(([GetRequestsData]?)->())){
        let param:parameters = ["limit":limit,"offset":offset]
        WebService.service(API.appliedRequest,param: param,service: .get,is_raw_form: true) { (model:AppliedRequestsModel,jsonData,jsonSer) in
            onSucces(model.data)
        }
    }
    func getJobCreatedDetail(notesId:String,onSucces:@escaping(([GetDetailData]?)->())){
       
        WebService.service(API.getjobCreatedDetail,urlAppendId: notesId,service: .get,showHud: true,is_raw_form: true) { (model:GetJobCreatedDetailModel,jsonData,jsonSer) in
            onSucces(model.data)
        }
    }
    func getOwnerAppliedrequestsApi(notesId:String,onSucces:@escaping((GetRequests?)->())){
       
        WebService.service(API.appliedUser,urlAppendId: notesId,service: .get,showHud: false,is_raw_form: true) { (model:GetAppliedUserModel,jsonData,jsonSer) in
            onSucces(model.data)
        }
    }

}
