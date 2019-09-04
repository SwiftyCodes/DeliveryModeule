//
//  APIManager.swift
//  SampleProject
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class APIManager: APIManagerProtocol {
    
    typealias CompletionBlock = (_ response: Data?, _ error: Error?,  _ statuscode : Int?) -> Void
    
    func GETApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock){
        Alamofire.request(url, method: .get, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("GETApi Error : ",error )
                    completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , dataResponse.response?.statusCode)
                    return
                }
                
                if dataResponse.data != nil{
                    let json = dataResponse.data
                    completion(json, nil,dataResponse.response?.statusCode)
                }else{
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
        }
    }
    
    func POSTApi(_ url: String, param: [String: Any]?, header : [String : String]?, completion: @escaping CompletionBlock) {
        
        print("Header------>>>>>",header ?? "")
        _ =  Alamofire.request(url, method: .post, parameters: param , encoding: JSONEncoding.default, headers: header).responseJSON{ (dataResponse) in
            
            
            debugPrint(dataResponse.timeline)
            guard dataResponse.result.isSuccess else {
                let error = dataResponse.result.error!
                print("POSTApi Error : ",error )
                completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , dataResponse.response?.statusCode)
                return
            }
            if dataResponse.data != nil{
                let json = dataResponse.data
                
                completion(json , nil, dataResponse.response?.statusCode)
            }else{
                completion(nil , nil,dataResponse.response?.statusCode)
            }
        }
    }

    func PUTApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock){
        Alamofire.request(url, method: .put, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("PUTApi Error : ",error )
                    completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , dataResponse.response?.statusCode)
                    return
                }
                if dataResponse.data != nil{
                    let json = dataResponse.data
                    
                    completion(json , nil,dataResponse.response?.statusCode)
                }else{
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
                print("GETApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
    }
    
    func DELETEApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock){
        Alamofire.request(url, method: .delete, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("GETApi Error : ",error )
                    completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , dataResponse.response?.statusCode)
                    return
                }
                if dataResponse.data != nil{
                    let json = dataResponse.data
                    
                    completion(json , nil,dataResponse.response?.statusCode)
                }else{
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
                print("GETApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
    }
    
    func UploadFile(_ url :String , _ data:Data, _ fileName:String , _ docID:String ,_ group:String , completion: @escaping CompletionBlock)  {
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "*/*")
            let data = docID.data(using:.utf8)
            multipartFormData.append(data!, withName: "id")
            multipartFormData.append(group.data(using: .utf8)!, withName: "to")
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:[:],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    guard response.result.isSuccess else {
                                        completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                        return
                                    }
                                    if response.data != nil{
                                        let json = response.data
                                        completion(json , nil,response.response?.statusCode)
                                    }else{
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                completion(nil , encodingError,nil)
                            }
        })
    }
    
    
    
    func UploadRecord(_ url :String , _ data:Data, _ fileName:String? , paremes:[String:Any]? , header:[String:String]?, completion:@escaping CompletionBlock)  {
        print("File Name:",fileName!)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "file_name", fileName: fileName!, mimeType: "*/*")
            if let param = paremes{
                let record_for = (param["record_for"] as! String).data(using:.utf8)
                multipartFormData.append(record_for!, withName: "record_for")
                
                let record_name = (param["record_name"] as! String).data(using:.utf8)
                multipartFormData.append(record_name!, withName: "record_name")
                
                let doctor_name = (param["doctor_name"] as! String).data(using:.utf8)
                multipartFormData.append(doctor_name!, withName: "doctor_name")
                
                let description = (param["description"] as! String).data(using:.utf8)
                multipartFormData.append(description!, withName: "description")
                
                let record_type = (param["record_type"] as! String).data(using:.utf8)
                multipartFormData.append(record_type!, withName: "record_type")
                
                let created_at = (param["created_at"] as! String).data(using:.utf8)
                multipartFormData.append(created_at!, withName: "created_at")
                
            }
            
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    guard response.result.isSuccess else {
                                        let error = response.result.error
                                        completion( nil, error,response.response?.statusCode)
                                        return
                                    }
                                    if response.data != nil{
                                        let json = response.data
                                        completion( json, NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                    }else{
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , nil)
                            }
        })
    }
    
    func UploadProfilePicFile(_ url :String , data:Data, fileName:String ,header : [String:String]?, completion:@escaping CompletionBlock)  {
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "image/*")
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    //debugPrint(response)
                                    guard response.result.isSuccess else {
                                        completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                        return
                                    }
                                    if response.data != nil{
                                        let json = response.data
                                        completion(json , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                    }else{
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , nil)
                            }
        })
    }
    
    func UploadFamilyMemberPic(_ url :String , data:Data, fileName:String ,id : Int,header : [String:String]?, completion:@escaping CompletionBlock)  {
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "profile_pic", fileName: fileName, mimeType: "image/*")
            let idData = id.description.data(using:.utf8)
            
            multipartFormData.append(idData!, withName: "id")
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    //debugPrint(response)
                                    guard response.result.isSuccess else {
                                        let error = response.result.error
                                        completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                        return
                                    }
                                    if response.data != nil{
                                        let json = response.data
                                        completion(json , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , response.response?.statusCode)
                                    }else{
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                completion(nil , NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil) , nil)
                            }
        })
    }
    
    func loadImage(_ url:String)  ->UIImage?{
        var image:UIImage?
        print(url)
        Alamofire.download(url)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    image =  UIImage(data: data)
                }
        }
        return image
    }
    
//    func downloadFile(_ url :String , _ name :String , progressCircle:MBProgressHUD, completion:@escaping (_ url:URL?)->()) {
//     let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//     print("Document Directory -->>",path)
//     let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
//     print("DESTINATION--->>>>",destination)
//     Alamofire.download(
//     url,
//     method: .get,
//     parameters: [:],
//     encoding: JSONEncoding.default,
//     headers: nil,
//     to: destination).downloadProgress(closure: { (progress) in
//     progressCircle.progress = Float(progress.fractionCompleted)
//     print("PROGRESS_____>>>>>>>>",progress)
//     }).response(completionHandler: { (DefaultDownloadResponse) in
//
//     print("Document Directory -->>",destination)
//     print("Document Directory -->>",DefaultDownloadResponse.destinationURL ?? "")
//     DispatchQueue.main.async {
//     progressCircle.hide(animated: true)
//     }
//     completion(DefaultDownloadResponse.destinationURL)
//     })
//     }
//
}


