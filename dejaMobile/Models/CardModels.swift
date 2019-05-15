//
//  cardModel.swift
//  dejaMobile
//
//  Created by Awb on 15/05/2019.
//  Copyright © 2019 Salaheddine Kably. All rights reserved.
//

import Foundation

enum CardModel
{
    // MARK: - Use cases
    struct Request: Codable
    {
        var card: Card?
        var dictionary: [String: Any]? {
            guard let data = try? JSONEncoder().encode(card) else { return nil }
            return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        }
    }
    
    struct Response: Codable
    {
        var cardList: [Card]?
    }
    
    struct Card: Codable
    {
        var id: String?
        var cardName: String?
        var cardNumber: Int?
        var cardExp: String?
        var active: Bool?
        var credit: String?
        
        init(_ id: String, cardName: String, cardNumber: Int, cardExp: String, active: Bool, credit: String) {
            self.id = id
            self.cardName = cardName
            self.cardNumber = cardNumber
            self.cardExp = cardExp
            self.active = active
            self.credit = credit
        }
    }
    
    
}
