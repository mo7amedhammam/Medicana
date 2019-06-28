//
//  DepartmentsVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/26/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class DepartmentsVC: UIViewController {
    
    var chosenHospital : hospitalModel?
    var hospitalarray = [insideHospital]()
    
  
    
    @IBOutlet weak var departmentsList: UITextView!
    @IBOutlet weak var wantedDepartment: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departmentsObservation()
        
    }
    

    func departmentsObservation(){

        guard  let departments = chosenHospital?.hospitalDepartments else{
            return
        }
        self.departmentsList.text = departments
//        print(departments)
    }

   
    @IBAction func backToHospitals(_ sender: Any) {
   self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //*********************************
    //*******Booking Details********

    func didBooked(){
        guard let bookedhospital = chosenHospital?.hospitalName, let bookedDepartment = wantedDepartment.text else{
            return
        }
        guard let currentUserId = Auth.auth().currentUser?.uid as? String else{
            return
        }
        let databaseRef = Database.database().reference()
        databaseRef.child("users").child(currentUserId).updateChildValues(["bookedHospital":bookedhospital,"bookedDepartment":bookedDepartment])
        
    }
    
    
    @IBAction func doneBooking(_ sender: Any) {
        if wantedDepartment.text?.isEmpty == false{
        self.didBooked()
            displayerror(errorBody: "Booked Successfuly")
//        self.dismiss(animated: true, completion: nil)
    }
    else{
    displayerror(errorBody: "please type a department name !")
      }
    }
 
    
    
    //    Dismiss alert function && Error display
    func displayerror(errorBody : String){
        let alert = UIAlertController.init(title: "Successful", message: errorBody, preferredStyle: .alert)
        let dismissbutton = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissbutton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
