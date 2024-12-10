//
//  APIRequest.swift
//  AffroppleApp
//
//  Created by apple on 11/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

struct WebService {
    static var spinner : NVActivityIndicatorView?
    static let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    
    static func service<Model: Codable>(_ api:API,urlAppendId: Any? = nil,param: Any? = nil, service: Services = .post ,showHud: Bool = true, headerAppendId: String? = nil,is_raw_form:Bool = false,isLogin:Bool = false,response:@escaping (Model,Data,Any) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            var fullUrlString = baseURL + api.rawValue
            if let idAppend =  urlAppendId {
                fullUrlString =  baseURL + api.rawValue + "/\(idAppend)"
            }
            
            if service == .get {
                if let param = param {
                    if let paramDict = param as? [String: Any] {
                        fullUrlString += self.getString(from: paramDict)
                    } else if let paramString = param as? String {
                        fullUrlString += "?\(paramString)"
                    } else {
                        assertionFailure("Parameter must be a Dictionary or String.")
                    }
                }
            }
            print(fullUrlString)
            guard let encodedString = fullUrlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
                return
            }
            
            var request = URLRequest(url: URL(string: encodedString)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 2000)
            
            request.httpMethod = service.rawValue
            
            if Store.authKey != "" {
                request.setValue(Store.authKey ?? "", forHTTPHeaderField: DefaultKeys.Authorization.rawValue)
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if service == .delete {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                if let param = param {
                    if let paramString = param as? String {
                        let postData = NSMutableData(data: paramString.data(using: .utf8)!)
                        request.httpBody = postData as Data
                    } else if let paramDict = param as? [String: Any] {
                        var paramStr = self.getString(from: paramDict)
                        paramStr.removeFirst()
                        let postData = NSMutableData(data: paramStr.data(using: .utf8)!)
                        request.httpBody = postData as Data
                    }
                }
            }
            if service == .post || service == .put {
                if let parameter = param {
                    if let paramString = parameter as? String {
                        request.httpBody = paramString.data(using: .utf8)
                    } else if let paramDict = parameter as? [String: Any] {
                        if is_raw_form {
                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                            let postData = try? JSONSerialization.data(withJSONObject: paramDict, options: .prettyPrinted)
                            request.httpBody = postData
                        } else {
                            let body = createMultipartFormData(paramDict)
                            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                            request.httpBody = body
                        }
                    } else {
                        assertionFailure("Parameter must be a Dictionary or String.")
                    }
                }
            }
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            if showHud{
                showLoader()
            }
            session.dataTask(with: request) { (data, jsonResponse, error) in
                if showHud{
                    DispatchQueue.main.async {
                        hideLoader()
                    }
                }
                if error != nil{
                    WebService.showAlert(error!.localizedDescription)
                }else{
                    if let jsonData = data{
                        do{
                            let jsonSer = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String: Any]
                            print(jsonSer)
                            let status = jsonSer["statusCode"] as? Int ?? 0
                            let error = jsonSer["message"] as? String ?? ""
                            if status == 200{
                                let decoder = JSONDecoder()
                                let model = try decoder.decode(Model.self, from: jsonData)
                                DispatchQueue.main.async {
                                    response(model,jsonData,jsonSer)
                                }
                            }else if status == 400{
                                if isLogin == true{
                                    if error == "Your account is not approve. Please contact admin"{
                                        showSwiftyAlert("", "Our verification team is diligently reviewing the details provided during registration, and we appreciate your patience during this process. We strive to complete the verification within the shortest possible time.", false)
                                    }else{
                                        showAlert(error)
                                    }
                                }else{
                                    showAlert(error)
                                }
                            }else{
                                showAlert(error)
                            }
                            
                        }catch let err{
                            print(err)
                            WebService.showAlert(err.localizedDescription)
                        }
                    }
                }
            }.resume()
        }
        
        else
        {
            self.showAlert(constantMessages.internetError.instance)
        }
    }
    
    private static func showAlert(_ message: String){
        DispatchQueue.main.async {
            showSwiftyAlert("", message, false)
        }
    }
    private static func showLoader()
    {
        spinner =  NVActivityIndicatorView.init(frame: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame) ?? CGRect(x: 0, y: 0, width: 320, height: 568), type: .circleStrokeSpin, color: .black, padding: 170)
        spinner?.startAnimating()
        (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(spinner!))
        spinner?.startAnimating()
    }
    
    static func hideLoader()
    {
        DispatchQueue.main.async {
            spinner?.stopAnimating()
        }
    }
    private static func getString(from dict: Dictionary<String,Any>) -> String{
        var stringDict = String()
        stringDict.append("?")
        for (key, value) in dict{
            let param = key + "=" + "\(value)"
            stringDict.append(param)
            stringDict.append("&")
        }
        stringDict.removeLast()
        return stringDict
    }
    private static func createMultipartFormData(_ parameters: [String: Any]) -> Data {
        var formData = Data()
        
        for (key, value) in parameters {
            if let imageInfo = value as? ImageStructInfo {
                formData.append("--\(boundary)\r\n")
                formData.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imageInfo.fileName)\"\r\n")
                formData.append("Content-Type: \(imageInfo.type)\r\n\r\n")
                formData.append(imageInfo.data)
                formData.append("\r\n")
            } else if let images = value as? [ImageStructInfo] {
                for imageInfo in images {
                    formData.append("--\(boundary)\r\n")
                    formData.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imageInfo.fileName)\"\r\n")
                    formData.append("Content-Type: \(imageInfo.type)\r\n\r\n")
                    formData.append(imageInfo.data)
                    formData.append("\r\n")
                }
            } else {
                formData.append("--\(boundary)\r\n")
                formData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                formData.append("\(value)\r\n")
            }
        }
        
        formData.append("--\(boundary)--\r\n")
        return formData
    }
    
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}

extension UIImage {
    func toData() -> Data{
        return self.jpegData(compressionQuality: 0.5)!
    }
    func isEqualToImage(image: UIImage) -> Bool
    {
        let data1: Data = self.pngData()!
        let data2: Data = image.pngData()!
        return data1 == data2
    }
}

struct ImageStructInfo: Encodable {
    let fileName: String
    let type: String
    let data: Data
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case fileName
        case type
        case data
        case key
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(type, forKey: .type)
        try container.encode(data.base64EncodedString(), forKey: .data)
        try container.encode(key, forKey: .key)
    }
}
