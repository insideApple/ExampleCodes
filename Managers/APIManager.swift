//
//  APIManager.swift
//  ItemBI
//
//  Created by Vivek on 18/12/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

//http://132.148.132.184:82/api/
let kServerURLString = "https://globalapi.deliverload.com/api"
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

   
    
  
    static func testMethos(){
        let headers: HTTPHeaders = [ "Accept": "application/json", "Content-Type": "application/json" ]
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=surat&destinations=navsari&key=AIzaSyDvt_KiUCtdb1kPEw4E4Dt68EuiF8PosAg"
        
        let header: HTTPHeaders = [ "Accept": "application/json", "Content-Type": "application/json" ]
        
        request( url, method: .get, encoding: JSONEncoding.default, headers : header) .responseString {  response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)
            
            
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
//                debugPrint(response)
                if let result = response.result.value {
                    if let dict : NSDictionary = result as? NSDictionary {
//                        print(dict["status_code"]! as! NSNumber)
                       
//                       
//                        if let statusCodeResultStr : String = "\(dict["status_code"])" {
//                            
//                            if let statusCodeResult : Int = Int(statusCodeResultStr.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
//                                if statusCodeResult != 200{
//                                    
//                                    if statusCodeResult == 300 {
//                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                        appDelegate.logout()
//                                    }
//
//                                    let statusMsg = "\(statusCodeResultStr)"
//                                    let errorTuple = (Int(statusCodeResult), statusMsg)
//                                    completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1 )))
//                                    return
//                                }
//                            }
//                        }
                    }
                    
                    completion(.success(result: result as AnyObject))
                    return
                }
                
                
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.logout()
                
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

    static func uploadImage(image :UIImage , fileName : String, methodName: String, HttpMethod : HTTPMethod, params: Parameters, completion: @escaping RequestCompletion){
        let newRequestUrl = kServerURLString + "/\(methodName)"

        guard let data = image.jpegData(compressionQuality: 0.9) else {
            return
        }

      
        
        upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: fileName, fileName: "\(randomString(length: 6)).jpg", mimeType: "image/jpeg")
            for (key, value) in params {
                multipartFormData.append(("\(value)").data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
        }, to:newRequestUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                
                upload.responseJSON { response in
                    //print response.result
                    debugPrint(response)
                    if let result = response.result.value {
                        if let dict : NSDictionary = result as? NSDictionary {
    
                        }
                        
                        completion(.success(result: result as AnyObject))
                        return
                    }
                    
                    
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.logout()
                    
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
                
            case .failure(let encodingError):
                let errorTuple = (401, encodingError.localizedDescription)
                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1)))
                break
                //print encodingError.description
                
            }
        }
    }
    static func uploadDoc(data :Data , fileName : String, methodName: String, HttpMethod : HTTPMethod, params: Parameters, completion: @escaping RequestCompletion){
        let newRequestUrl = kServerURLString + "/\(methodName)"
        

        
        upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: fileName, fileName: "\(randomString(length: 6)).pdf", mimeType: "image/pdf")
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:newRequestUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                
                upload.responseJSON { response in
                    //print response.result
                    debugPrint(response)
                    if let result = response.result.value {
                        if let dict : NSDictionary = result as? NSDictionary {
                            
                        }
                        
                        completion(.success(result: result as AnyObject))
                        return
                    }
                    
                    
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.logout()
//                    
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
                
            case .failure(let encodingError):
                let errorTuple = (401, encodingError.localizedDescription)
                completion(.error(errorTuple: (statusCode: errorTuple.0, message: errorTuple.1)))
                break
                //print encodingError.description
                
            }
        }
    }
    
    static func refreshUserData(){
        
    }

}
