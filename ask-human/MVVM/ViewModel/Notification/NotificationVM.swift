//
//  NotificationVM.swift
//  ask-human
//
//  Created by meet sharma on 15/12/23.
//

import Foundation

class NOtificationVM{
    func notificationsApi(page:Int,limit:Int,showLoader:Bool,onSuccess:@escaping((NotificationModel?)->())){
        let param:parameters = ["offset":"","limit":""]
        print(param)
        WebService.service(API.notifications,service: .get,showHud: showLoader,is_raw_form: true){(model:NotificationModel,jsonData,jsonSer) in
            
            onSuccess(model)
            
        }
    }
//    func readNotificationsApi(notificationId:String,onSuccess:@escaping(()->())){
//        WebService.service(API.notificationRead,urlAppendId: notificationId,service: .get,is_raw_form: true){(model:CommonModel,jsonData,jsonSer) in
//            
//            onSuccess()
//            
//        }
//    }
}
