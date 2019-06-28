//
//  FeedbackVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/27/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class FeedbackVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var feedbackUserName: UITextField!
    @IBOutlet weak var feedBackbody: UITextView!

    
    @IBAction func sendFeedBack(_ sender: Any) {
       let databaseRef = Database.database().reference()
        databaseRef.child("feedBack").child("senderName").setValue(feedbackUserName.text)
        databaseRef.child("feedBack").child("feedBack").setValue(feedBackbody.text)
        
        self.ClearFields()
        
    }
    func ClearFields(){
        self.feedbackUserName.text = ""
        self.feedBackbody.text = ""
    }
    
    @IBAction func backToMore(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    
}
