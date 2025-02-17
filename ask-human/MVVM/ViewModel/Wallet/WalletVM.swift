//
//  WalletVM.swift
//  ask-human
//
//  Created by meet sharma on 26/02/24.
//

import Foundation
// Struct for BankAccountDetails
struct BankDetaill{
    let bankId: String?
    let country: String?
    let currency: String?
    let accountHolderName: String?
    let accountHolderType: String?
    let routingNumber: String?
    let accountNumber: String?
    let idNumber: String?
    let isDefault: String?

    init(bankId: String?, country: String?, currency: String?, accountHolderName: String?, accountHolderType: String?, routingNumber: String?, accountNumber: String?, idNumber: String?, isDefault: String?) {
        self.bankId = bankId
        self.country = country
        self.currency = currency
        self.accountHolderName = accountHolderName
        self.accountHolderType = accountHolderType
        self.routingNumber = routingNumber
        self.accountNumber = accountNumber
        self.idNumber = idNumber
        self.isDefault = isDefault
    }
    }

class WalletVM{
    func getWalletDetail(showHud:Bool,onSuccess:@escaping((WalletData?)->())){
        
        WebService.service(API.getWalletDetails,service: .get,showHud:showHud,is_raw_form: true) { (model:WalletModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func addWalletAmount(ammount:Int,onSuccess:@escaping((GetWalletData?)->())){
        let param:parameters = ["ammount": ammount]
        WebService.service(API.addWalletAmount,param: param,service: .post,is_raw_form: true) { (model:AddWalletModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    
    func addBankApi(bankAccountDetails: BankDetaill, onSuccess: @escaping ((_ message: String?) -> ())) {
        do {
            let isDefault = bankAccountDetails.isDefault ?? ""
            let country = bankAccountDetails.country ?? ""
            let currency = bankAccountDetails.currency ?? ""
            let accountHolderName = bankAccountDetails.accountHolderName ?? ""
            let accountHolderType = bankAccountDetails.accountHolderType ?? ""
            let routingNumber = bankAccountDetails.routingNumber ?? ""
            let accountNumber = bankAccountDetails.accountNumber ?? ""
            let idNumber = bankAccountDetails.idNumber ?? ""
            
            let bankAccountDetailsDict: [String: Any] = [
                "country": country,
                "currency": currency,
                "account_holder_name": accountHolderName,
                "account_holder_type": accountHolderType,
                "routing_number": routingNumber,
                "account_number": accountNumber,
                "idNumber": idNumber,
                "isDefault": isDefault
            ]
            
            let param: [String: Any] = [
                "bankAccountDetails": bankAccountDetailsDict
            ]
            
            print("Parameters: \(param)")
            
            // Convert the dictionary to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON String: \(jsonString)")
                
                WebService.service(API.addBank, param: jsonString, service: .post, is_raw_form: true) { (model: CommonModel, jsonData, jsonSer) in
                    onSuccess(model.message)
                }
            }
        } catch {
            print("Error converting parameters to JSON: \(error)")
        }
    }
    func getBankDetailsApi(loader:Bool,onSccess:@escaping((ExternalAccounts?)->())){
        WebService.service(API.bankList,service: .get,showHud: loader,is_raw_form: true) { (model:BankListModel,jsonData,jsonSer) in
            onSccess(model.data?.externalAccounts)
        }
    }
    func DeleteBankApi(bankAccountId:String,onSuccess:@escaping(( _ message: String?)->())){
        let param:parameters = ["bankAccountId":bankAccountId]
        print(param)
        WebService.service(API.deleteBank,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message)
        }
    }
    func DefaultBankApi(bankAccountId:String,onSuccess:@escaping(( _ message: String?)->())){
        let param:parameters = ["bankAccountId":bankAccountId]
        print(param)
        WebService.service(API.defaultBank,param: param,service: .post,is_raw_form: true) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message)
        }
    }
}
