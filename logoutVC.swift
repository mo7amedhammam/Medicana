//
//  logoutVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/20/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class logoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
//        self.performSegue(withIdentifier: "gotouserlogin", sender: self)

        let loginscreen = self.storyboard?.instantiateViewController(withIdentifier: "loginSB") as! ViewController
        self.present(loginscreen , animated: true , completion: nil)
        
    }
    @IBAction func contactUsButton(_ sender: Any) {
        performSegue(withIdentifier: "feedbackVC", sender: self)
    }
    
    @IBAction func aboutUsPressed(_ sender: Any) {
        performSegue(withIdentifier: "aboutUsVC", sender: self)
    }
 
    
    
}
