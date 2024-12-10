//
//  EarningVM.swift
//  ask-human
//
//  Created by meet sharma on 18/01/24.
//

import Foundation

class EarningVM{
    func getEarningApi(startDate:String,endDate:String,showLoader:Bool,onSuccess:@escaping((EarningData?)->())){
        let param:parameters = ["weekStartdate":startDate,"weekEnddate":endDate]
        WebService.service(API.getEarning,param: param,service: .get,showHud: showLoader,is_raw_form: true) { (model:EarningModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func withdrawAmount(amount:String,onSuccess:@escaping(()->())){
        let param:parameters = ["ammount":amount]
        print(param)
        WebService.service(API.withdrawAmount,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess()
        }
    }
}
