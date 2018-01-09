//
//  APIManager.swift
//  ItemBI
//
//  Created by Vivek on 18/12/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit


let kServerURLString = "https://itembi.iqdesk.co.il/api/api_public"
typealias ErrorTuple = (statusCode: Int?, message: String)
private let kUnknownError = "error"


class APIManager {
    
    enum Response {
        case success(result: AnyObject)
        case error(errorTuple: ErrorTuple)
        
        var result: AnyObject? {
            switch self {
            case .success(let result):
                return result
            default:
                return nil
            }
        }
        
        var errorMessage: String? {
            switch self {
            case .error(let tuple):
                return tuple.message
            default:
                return nil
            }
        }

    }
  
    
    typealias RequestCompletion = (_ response: Response) -> Void

   
    
    /**  General request method */
    static func askQuestionWithQuestion(que : String, completion: @escaping RequestCompletion){
//        let parameters: Parameters = ["uuid": UserManager.DeviceUDID ?? "" , "question" : que]
//        let newRequestUrl = kServerURLString + "/question"
//        request(newRequestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                print("Progress: \(progress.fractionCompleted)")
//            }
//            .validate { request, response, data in
//                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//                return .success
//            }
//            .responseJSON { response in
//                debugPrint(response)
//                if let result = response.result.value {
//                    completion(.success(result: result as AnyObject))
//
//                    //                    completion(success(result: result))
//                    return
//                }
//
//
//                print(response.description)
//                print(response.result.value)
//
//
//
//                let data = response.data ?? NSData() as Data
//
//                let jsonObject : NSDictionary! = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//
//                var message: String?
//
//                if let string = jsonObject?["message"] as? String {
//                    message = string
//                } else if let error = response.result.error?.localizedDescription {
//                    message = error
//                }
//
//                let statusCode = response.response?.statusCode
//
//
//
//                let errorTuple = (statusCode, message ?? NSLocalizedString(kUnknownError, comment: ""))
//                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1)))
//        }
//    }
        
        let parameters: Parameters = ["uuid": UserManager.DeviceUDID! , "question" : que]
        let newRequestUrl = kServerURLString + "/question"
        
     
        request(newRequestUrl, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON{ response in
                debugPrint(response)
                if let result = response.result.value {
                    completion(.success(result: result as AnyObject))
                    
                    //                    completion(success(result: result))
                    return
                }
                
                
                print(response.description)
                print(response.result.value)
                
                
                
                let data = response.data ?? NSData() as Data
                
                let jsonObject : NSDictionary! = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                var message: String?
                
                if let string = jsonObject?["message"] as? String {
                    message = string
                } else if let error = response.result.error?.localizedDescription {
                    message = error
                }
                
                let statusCode = response.response?.statusCode
                
                
                
                let errorTuple = (statusCode, message ?? NSLocalizedString(kUnknownError, comment: ""))
                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1)))
        }
    }
    
   static func makeRequestWithMethod(methodName: String, HttpMethod : HTTPMethod, params: Parameters, completion: @escaping RequestCompletion){
        
        let newRequestUrl = kServerURLString + "/\(methodName)"

        
        request(newRequestUrl, method: HttpMethod, parameters: params, encoding: URLEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON{ response in
                debugPrint(response)
                if let result = response.result.value {
                    if let dict : NSDictionary = result as? NSDictionary {
                        if let statusCodeResult : Int = dict["status_code"] as? Int {
                            if statusCodeResult != 200{
                                
                                let statusMsg = VPLocalizationManager.string(key: "code_\(statusCodeResult)")
                                let errorTuple = (statusCodeResult, statusMsg)
                                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1 )))
                            }
                        }
                    }
                    
                    completion(.success(result: result as AnyObject))
                    return
                }
                
                
                let data = response.data ?? NSData() as Data
                
                let jsonObject : NSDictionary! = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                var message: String?
                
                if let string = jsonObject?["message"] as? String {
                    message = string
                } else if let error = response.result.error?.localizedDescription {
                    message = error
                }
                
                let statusCode = response.response?.statusCode
                
                
                
                let errorTuple = (statusCode, message ?? NSLocalizedString(kUnknownError, comment: ""))
                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1)))
        }
    }
    
   static func fetchData(){
        self.makeRequestWithMethod(methodName: "getData", HttpMethod: .get, params:Parameters()) { (response) in
            print("Result data : \(response.result ?? "" as AnyObject)")
        }
    }
    
    static func checkVersion(){
        self.makeRequestWithMethod(methodName: "getVersion", HttpMethod: .get, params:Parameters()) { (response) in
            print("Result Version : \(response.result ?? "" as AnyObject)")
            if let responseDict : NSDictionary = response.result as? NSDictionary{
                let data = responseDict["data"] as! NSDictionary
                if let languageVersion = data["language_version"]{
                    let languageVerInt = Int(languageVersion as! String)
                    if  UserManager.LanguageVersion! != languageVerInt!{
                        UserManager.LanguageVersion = languageVerInt
                        self.downloadLanguage()
                    }
                }
            }
        }
    }
    
    static func downloadLanguage(){
        self.makeRequestWithMethod(methodName: "getData", HttpMethod: .get, params:Parameters()) { (response) in
            print("Result data : \(response.result ?? "" as AnyObject)")
            if let dict : NSDictionary = response.result as? NSDictionary{
                if let dataArray : [NSDictionary] = dict["data"] as? [NSDictionary]{
                    for datasDict : NSDictionary in dataArray{
                        if datasDict["type"] as! String == "languages"{
                            getLanguageFile(langArray: datasDict["datas"] as! [NSDictionary])
                        }
                    }
                }
            }
        }
    }
    
    static func getLanguageFile(langArray : [NSDictionary]){
        
        for dictLan : NSDictionary in langArray {
            downloadLanguageFileWith(name: dictLan["language"] as! String, fileUrl: URL.init(string: dictLan["iphone_file_url"] as! String)!)
        }
    }
    
    static func downloadLanguageFileWith(name : String , fileUrl : URL){
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(name)
            documentsURL.appendPathExtension("plist")
            return (documentsURL, [.removePreviousFile])
        }
        
        download(fileUrl, to: destination).responseData { response in
            if let destinationUrl = response.destinationURL {
                print(destinationUrl)
            }
        }
    
    }
    

}
