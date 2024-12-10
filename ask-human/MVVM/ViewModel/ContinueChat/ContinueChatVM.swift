//
//  ContinueChatVM.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import Foundation

class ContinueChatVM{
    func continueChatApi(messageId:String,userId:String,amount:Int,onSuccess:@escaping(()->())){
        let param:parameters = ["messageId":messageId,"userId":userId,"amount":amount]
        print(param)
        WebService.service(API.continueChat,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess()
        }
    }
}
