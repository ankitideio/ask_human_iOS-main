//
//  ContractsVM.swift
//  ask-human
//
//  Created by meet sharma on 21/12/23.
//

import Foundation

class ContractsVM{
    func allContractApi(page:Int,limit:Int,showLoader:Bool,filterStatus:Int,selectedIndexParam:Int,onSucces:@escaping((ContractData?)->())){
        var param: parameters
        if selectedIndexParam == 0{
            param = ["offset":page,"limit":limit]
            
        }else{
            param = ["offset":page,"limit":limit,"filterStatus":filterStatus]
        }
        print(param)
        
            WebService.service(API.allContractsList,param: param,service: .get,showHud: showLoader,is_raw_form: true) { (model:ContractModel,jsonData,jsonSer) in
                onSucces(model.data)
            }
        
    }
    func myContractApi(page:Int,limit:Int,showLoader:Bool,filterStatus:Int,selectedIndexParam:Int,onSucces:@escaping((ContractData?)->())){
        let param:parameters
        if selectedIndexParam == 0{
            param = ["offset":page,"limit":limit]

        }else{
            param = ["offset":page,"limit":limit,"filterStatus":filterStatus]

        }
        print(param)
        
        WebService.service(API.contractList,param: param,service: .get,showHud: showLoader,is_raw_form: true) { (model:ContractModel,jsonData,jsonSer) in
            onSucces(model.data)
        }
    }
}

