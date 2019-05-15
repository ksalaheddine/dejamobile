//
//  NetworkManager.swift
//  dejaMobile
//
//  Created by Awb on 14/05/2019.
//  Copyright © 2019 Salaheddine Kably. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking {
    typealias CompletionHandler = (Any?,Int?) -> Void
    func makeRequest(from url: String, methode: HTTPMethod, query queryParams: [String: Any]?, parameters params: Parameters?, path pathParams: String?, completion: @escaping CompletionHandler)
}

class NetworkManager: Networking {
    
    static let shared = NetworkManager()
    
    private let manager: Alamofire.SessionManager = {
        return Alamofire.SessionManager()
    }()

    
    func makeRequest(from baseUrl:String, methode: HTTPMethod, query queryParams: [String: Any]? = nil, parameters params: Parameters? = nil, path pathParams: String? = nil, completion: @escaping Networking.CompletionHandler) {
    
        // add headers
        let headers = [
            "Accept": "application/json,application/pdf,application/jpg, image/jpeg",
            "Content-Type": "application/json",
            "Accept-Encoding":"gzip"
        ]

        //add params to request in case of get method
        //add query params
        var url = baseUrl
        if let query = queryParams{
            for (key,value) in query{
                url = "\(url)&\(key)=\(value)"
            }
        }
    
        print("request ------- \n\(url) ")
        
        manager.request(url, method:methode, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            print("Response status: \(String(describing: response.response?.statusCode ?? -1))")
            print("Response value: \(String(describing: response.value))")
            if let body  = response.request?.httpBody {
                print("request body: \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "default")")
            }
            switch (response.result) {
            case .success:
                print("response \(response.result.value ?? "no data") ")
                completion(response.data,(response.response?.statusCode))
                break
            case .failure( let error):
                print("response \(error.localizedDescription ) ")
                if let status = response.response?.statusCode {
                    completion(response.data,status)
                } else {
                    completion(nil,nil)
                }
                break
            }
        }
    
    }
}
