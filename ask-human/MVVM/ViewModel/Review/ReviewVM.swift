//
//  ReviewVM.swift
//  ask-human
//
//  Created by meet sharma on 24/12/23.
//

import Foundation

class ReviewVM{
    func addReview(messageId:String,userId:String,comment:String,count:Int,onSucces:@escaping(()->())){
        let param:parameters = ["messageId":messageId,"comment":comment,"starCount":count,"userId":userId]
        print(param)
        WebService.service(API.addReview,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
//            showSwiftyAlert("", model.message ?? "", true)
            onSucces()
        }
    }
}
