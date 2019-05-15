//
//  CardViewController.swift
//  dejaMobile
//
//  Created by Awb on 14/05/2019.
//  Copyright © 2019 Salaheddine Kably. All rights reserved.
//

import UIKit
import Alamofire

class CardViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardTableView: UITableView!
    
    var user: UserModel.User?
    var cardList: [CardModel.Card]?
    
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = user?.name
        getCardList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CardCell
        if  let c = tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardCell{
            cell = c
        }else{
            let nib = Bundle.main.loadNibNamed("CardCell", owner: self, options: nil)! as NSArray
            cell = nib[0] as! CardCell
        }

        cell.fill(cardList![indexPath.row])
        
        return cell
    }
    
    func getCardList() {
        let url = "https://5cd42826b231210014e3d5ec.mockapi.io/cards/cardList"
        var cardListResponse: Array<CardModel.Card> = []
        
        NetworkManager.shared.makeRequest(from: url, methode: .get) { (response, status) in
            do {
                if status! >= 200 && status! < 400  {
                    cardListResponse = try JSONDecoder().decode(Array<CardModel.Card>.self, from: response as! Data)
                    self.cardList = cardListResponse
                    print("SUCCESS ====>",self.cardList!)
                    self.cardTableView.reloadData()
                } else {
                    print("ERROR ====> status no valid")
                }
            } catch {
                print("ERROR ====> ",error)
            }
        }
        
    }
    
//    func addCard(userName: String, userEmail: String) {
//        let url = "https://5cd42826b231210014e3d5ec.mockapi.io/cards/enroll"
//        let params: CardModel.Request = CardModel.Request(name: userName, email: userEmail)
//        var user: CardModel.Response?
//
//
//        NetworkManager.shared.makeRequest(from: url, methode: .post, parameters: params.dictionary) { (response, status) in
//            do {
//                if status! >= 200 && status! < 400  {
//                    user = try JSONDecoder().decode(CardModel.Response.self, from: response as! Data)
//                    print("SUCCESS ====>",user!)
//                } else {
//                    print("ERROR ====> status no valid")
//                }
//            } catch {
//                print("ERROR ====> ",error)
//            }
//        }
//
//    }
    
    
}
