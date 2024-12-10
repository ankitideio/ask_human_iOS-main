//
//  VideoVerificationVM.swift
//  ask-human
//
//  Created by meet sharma on 17/01/24.
//

import Foundation

class VideoVerificationVM {
    func uploadVideoVerificationApi(file: URL, onSuccess: @escaping ((_ message:String) -> ())) {
        var imageStructArr = [ImageStructInfo]()
        let videoData = try? Data(contentsOf: file)
            
        let videoFileName = "\(file.absoluteString)"
            let videoStruct = ImageStructInfo(
                fileName: videoFileName,
                type: "video/MOV",
                data: videoData ?? Data(),
                key: "video"
            )
            imageStructArr.append(videoStruct)
        

        let param:parameters = ["video":imageStructArr]
        print(param)
        WebService.service(API.uploadVideoVerification,param:param,service: .post,is_raw_form: false) { (model:CommonModel,jsonData,jsonSer) in
            onSuccess(model.message ?? "")
        }
    }
}

