//
//  UserModels.swift
//  dejaMobile
//
//  Created by Awb on 14/05/2019.
//  Copyright (c) 2019 Salaheddine Kably. All rights reserved.
//


import UIKit


enum UserModel
{
    // MARK: - Use cases
    struct Request: Codable
    {

        var user: User?
        var dictionary: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self) else { return nil }
            return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        }
    }
    
    struct Response: Codable
    {
        var user: User?
    }
    
    struct User: Codable {
        
        var name: String?
        var email: String?
        
        init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }
    
}
