//
//  UserViewController.swift
//  dejaMobile
//
//  Created by Awb on 14/05/2019.
//  Copyright © 2019 Salaheddine Kably. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addUser(_ sender: Any) {
   
        validateValue()
        if(!(fullName.text?.isEmpty)! && !(email.text?.isEmpty)!) {
            addUser(userName: fullName.text!, userEmail: email.text!)
        }
        
        
    }

    func validateValue(){
        if((fullName.text?.isEmpty)!) {  let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your name here..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                if let name = alert.textFields?.first?.text {
                    self.fullName.text?.write(name)
                }
            }))
            
            self.present(alert, animated: true)
        }
        if((email.text?.isEmpty)!){
            let alert = UIAlertController(title: "What's your email?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your email here..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                if let email = alert.textFields?.first?.text {
                    self.email.text?.write(email)
                }
            }))
            
            self.present(alert, animated: true)
        }
            
        }

    
    
    func addUser(userName: String, userEmail: String) {
        let url = "https://5cd42826b231210014e3d5ec.mockapi.io/cards/enroll"
        let userParams = UserModel.User(name: userName, email:userEmail)
        var params: UserModel.Request = UserModel.Request()
        var userResponse: UserModel.Response?
        params.user = userParams
        
        NetworkManager.shared.makeRequest(from: url, methode: .post, parameters: params.dictionary) { (response, status) in
            do {
                if status! >= 200 && status! < 400  {
                    userResponse = try JSONDecoder().decode(UserModel.Response.self, from: response as! Data)
                    print("SUCCESS ====>",userResponse!)
                    let vc = CardViewController(nibName: "CardViewController", bundle: nil)
                    vc.user = (userResponse?.user)!
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("ERROR ====> status no valid")
                }
            } catch {
                print("ERROR ====> ",error)
            }
        }
        
    }


}

