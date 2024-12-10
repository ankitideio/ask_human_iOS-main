//
//  InvitationVM.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/12/23.
//

import Foundation
import UIKit
class InvitationVM{

    
    func acceptRejectInvitationApi(messageId:String,
                                   isStatus:String,
                                   onSuccess:@escaping((_ message:String?)->())){
        let param: [String: Any] = ["messageId": messageId,
                                        "isStatus": isStatus]
        print(param)
//        "isStatus": "1 = accept or 2 = reject or 3 = Complete Contract"
                    WebService.service(API.accepReject,param: param, service: .put, is_raw_form: true) { (model: CommonModel, jsonData, jsonSer) in
//                        showSwiftyAlert("",model.message ?? "", true)
                        onSuccess(model.message ?? "")
                    }
               }
    
    func sendInvitationApi(inviteId:String,
                           onSuccess:@escaping((_ message:String?)->())){
        let param: [String: Any] = ["inviteId": inviteId,
                                        "notesId": Store.notesId ?? ""]
            
      print(param)
      WebService.service(API.sendInvitation,param: param, service: .post, is_raw_form: true) { (model: CommonModel, jsonData, jsonSer) in
          onSuccess(model.message ?? "")
          }
                
        }
    
    func sendReferInvitation(notesId:String,notificationId:String,referTo:[String],messageId:String,
                           onSuccess:@escaping((_ message:String?)->())){
        let param: [String: Any] = ["messageId": messageId,
                                    "notesId":notesId,
                                    "notificationId":notificationId,
                                    "referTo":referTo]
            
      print(param)
        
      WebService.service(API.referInvitation,param: param, service: .post, is_raw_form: true) { (model: CommonModel, jsonData, jsonSer) in
          onSuccess(model.message ?? "")
          }
                
        }
    
    func sendMultipleInvitationsApi(inviteId:[String],
                           notesId:String,
                                    onSuccess:@escaping((_ message:String)->())){
        let param: parameters = ["inviteId": inviteId,
                                 "notesId": notesId]
        
        print(param)
        
        WebService.service(API.sendMultipleInvitation,param: param,service: .post,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in 
            
            onSuccess(model.message ?? "")
            
        }
    }
    func endDispute(messageId:String,onSuccess:@escaping((_ message:String)->())){
        let param:parameters = ["messageId":messageId]
        WebService.service(API.endDispute,param: param,service: .put,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message ?? "")
        }
    }
  
}
