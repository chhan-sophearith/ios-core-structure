//
//  ApiManager.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

public typealias Parameters = [String: Any]

class ApiManager {
    
    static let shared = ApiManager()
    public typealias success = (_ response: Data) -> Void
    public typealias HTTPHeaders = [String: String]
    
    func getHeader()-> HTTPHeaders {
        let headers: HTTPHeaders = [
           // "Authorization": "Bearer \(Session.shared.getHeaderToken())",
            "Content-Type": "application/json",
            "Authorize" : "4ee0d884634c0b04360c5d26060eb0dac61209c0db21d84aa9b315f1599e9a41",
            "Auth" :  "6213cbd30b40d782b27bcaf41f354fb8aa2353a9e59c66fba790febe9ab4cf44",
            "lang" : "en"
         ]
        return headers
    }
    
    func apiConnection(url: URL, method: HTTPMethod, param: Parameters?, headers: HTTPHeaders?, res: @escaping success) {
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.url = url
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        // add headers
//        if headers == nil {
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        } else {
//            if let header = headers {
//                for (key, value) in header {
//                    request.setValue(value, forHTTPHeaderField: key)
//                }
//            }
//        }
        
        // add parameters
        do {
            if let param = param {
                request.httpBody = try JSONSerialization.data(withJSONObject: param , options:[])
            }
        } catch let error as NSError {
            print("error", error.localizedDescription)
        }
       
        // request to api
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                Loading.shared.hideLoading()
            }
           
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    res(data!)
                } else {
                    print("error_code: \(httpResponse.statusCode)")
                    self.mapingError(data: data!)
                }
            }
        })
        task.resume()
    }
    
    func mapingError(data: Data){
          print("error_data: \(data.toJSON() as Any)")
          Validator.validateModel(model: ErrorModel().self, data: data, fun: "") { (res) in
              DispatchQueue.main.async {
                  AlertMessage.shared.showAlert(message: res.message ?? "")
              }
          }
    }
    
    func getList(success: @escaping success) {
        let url = URL(string: ApiKey.baseUrl + ApiEndPoint.getList)
        apiConnection(url: url!,
                      method: .GET,
                      param: nil,
                      headers: nil,
                      res: success)
    }
}
