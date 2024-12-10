//
//  WebService.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import FLAnimatedImage

struct WebService {
    static var spinner : NVActivityIndicatorView?
    static let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    static var loaderView: FLAnimatedImageView?
        static var fullScreenView: UIView?

    var gradientColors: [UIColor] = [UIColor.red, UIColor.blue]
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
            if service == .post  {
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
            if service == .put{
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
//            let sessionConfiguration = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfiguration)
            let session = URLSession(configuration: .default, delegate: MyURLSessionDelegate(), delegateQueue: nil)
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
//
//                               showAlert(error)
                                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: error)
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
 
    static func showLoader() {
            guard let window = UIApplication.shared.keyWindow else { return }

            // Create the full-screen view
            let fullScreenView = UIView(frame: window.bounds)
            fullScreenView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

            // Create the loader view
            let loaderView = FLAnimatedImageView()
            loaderView.frame = CGRect(x: 0, y: 0, width: 130, height: 100)
            loaderView.center = fullScreenView.center
        let currentTraitCollection = UITraitCollection.current
          if currentTraitCollection.userInterfaceStyle == .dark {
              loaderView.backgroundColor = UIColor(hex: "6C6C6C")
          } else {
              loaderView.backgroundColor = .white
          }
            loaderView.layer.cornerRadius = 10
            loaderView.contentMode = .scaleAspectFill
            loaderView.clipsToBounds = true

            // Load GIF
            if let path = Bundle.main.path(forResource: "ASK", ofType: "gif"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let gifData = FLAnimatedImage(animatedGIFData: data)
                loaderView.animatedImage = gifData
            }

            // Add loader view to the full-screen view
            fullScreenView.addSubview(loaderView)

            // Add the full-screen view to the window
            window.addSubview(fullScreenView)
            self.loaderView = loaderView
            self.fullScreenView = fullScreenView
        }
        
        static func hideLoader() {
            DispatchQueue.main.async {
                loaderView?.removeFromSuperview()
                loaderView = nil
                
                fullScreenView?.removeFromSuperview()
                fullScreenView = nil
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

struct ImageStructInfo: Codable {
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
        try container.encode(data, forKey: .data)
        try container.encode(key, forKey: .key)
    }
}


class MyURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
