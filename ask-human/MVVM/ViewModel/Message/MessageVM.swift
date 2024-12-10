//
//  MessageVM.swift
//  ask-human
//
//  Created by meet sharma on 27/12/23.
//

import Foundation
import UIKit

class MessageVM{
    func getMessageDetail(id:String,onSuccess:@escaping((MessageDetailData?)->())){
     
        WebService.service(API.messageDetail,urlAppendId: id,service: .get,is_raw_form: true){(model:MessageDetailModel,jsonData,jsonSer) in
            
            onSuccess(model.data)
            
        }
    }
    func getMessageId(messageId:String,onSuccess:@escaping((MessageIdData?)->())){
        
        let param:parameters = ["notificationId":messageId]
        WebService.service(API.getMessageId,param: param,service: .get,showHud: false,is_raw_form: true) { (model:MessageIdModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func fileUpload(image:UIImage,onSuccess:@escaping((FileUploadData?)->())){
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "jpeg", data: image.toData(), key: "file")
        let param:parameters = ["file":imageInfo]
        WebService.service(API.fileUpload,param:param,service:.post,showHud: true,is_raw_form: false) { (model:FileUploadModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
    func fileUploadVideo(video:URL,onSuccess:@escaping((FileUploadData?)->())){
      
        if let videoURL = video as? URL {
            if let videoData = try? Data(contentsOf: videoURL) {
                let videoFileName = "\(video)"
                let videoStruct = ImageStructInfo(
                    fileName: videoFileName,
                    type: "video/MOV",
                    data: videoData,
                    key: "media"
                )
                let param:parameters = ["file":videoStruct]
                WebService.service(API.fileUpload,param:param,service:.post,showHud: true,is_raw_form: false) { (model:FileUploadModel,jsonData,jsonSer) in
                    onSuccess(model.data)
                }
            }
        }
    }

}
