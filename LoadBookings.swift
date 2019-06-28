//
//  LoadBookings.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/27/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class LoadBookings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      self.loadBooked()
    }

    
    @IBOutlet weak var bookedHospNameLable: UILabel!
    @IBOutlet weak var bookedDepNameLable: UILabel!
    func loadBooked (){
        guard let currentUserId = Auth.auth().currentUser?.uid as? String else{
            return
        }
        let databaseRef = Database.database().reference()
        
        databaseRef.child("users").child(currentUserId).observe(.value, with: { (snapshot) in
            let data = snapshot.value as? [String:Any]
            let bookedHospital = data?["bookedHospital"] as? String
            let bookedDepartment = data?["bookedDepartment"] as? String
            self.bookedHospNameLable.text = bookedHospital
            self.bookedDepNameLable.text = bookedDepartment
        })
        
    }



}
