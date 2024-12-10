//
//  DisputeVM.swift
//  ask-human
//
//  Created by meet sharma on 24/12/23.
//

import Foundation

class DisputeVM{
    func getDisputeResonList(onSuccess:@escaping((DisputeReasonData?)->())){
        WebService.service(API.disputeReasonList,service: .get,is_raw_form: true) { (model:DisputeReasonModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    
    func addDispute(reasonId:String,messageId:String,comment:String,onSuccess:@escaping((_ message:String)->())){
        
        let param:parameters = ["reasonId":reasonId,"messageId":messageId,"comment":comment]
        print(param)
        WebService.service(API.addDispute,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message ?? "")
        }
    }
    func getMyDispute(onSuccess:@escaping((MyDisputeData?)->())){
        WebService.service(API.myDispute,service: .get,is_raw_form: true) { (model:MyDisputeModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func getDispute(onSuccess:@escaping((MyDisputeData?)->())){
        WebService.service(API.getDispute,service: .get,is_raw_form: true) { (model:MyDisputeModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
}
