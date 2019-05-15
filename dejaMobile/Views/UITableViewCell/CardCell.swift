//
//  CardCell.swift
//  dejaMobile
//
//  Created by Awb on 15/05/2019.
//  Copyright © 2019 Salaheddine Kably. All rights reserved.
//
import UIKit


class CardCell: UITableViewCell {
    
    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var statut: UILabel!
    @IBOutlet weak var cardExp: UILabel!
    @IBOutlet weak var credit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill (_ card: CardModel.Card) {
        cardName.text = card.cardName
        cardNumber.text = "XXX XXXX XXXX \(String(describing: card.cardNumber!))"
        credit.text = "\(card.credit!) €"
        cardExp.text = formatDate(dateExp: card.cardExp!)
        if(card.active!) {
            statut.text = "active"
                cardIcon.image = UIImage(named: "card-icon-active")
            
        }else {
            statut.text = "Disabled"
            cardIcon.image = UIImage(named: "card-icon-inactive")
        }
        
    }
    
    func formatDate(dateExp : String) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        guard let date: Date = dateFormatter.date(from: dateExp) else {
            fatalError("Formet Date Error")
        }
        dateFormatter.dateFormat = "MM/yy"
        let dateString: String = dateFormatter.string(from: date)
        
        return dateString
    }
}
