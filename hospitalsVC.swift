//
//  hospitalsVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/26/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class hospitalsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var hospitalsTabelView: UITableView!
    
    var hospitals = [hospitalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hospitalsTabelView.delegate = self
        self.hospitalsTabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.hospitalsObservation()
    }
    
    
    func hospitalsObservation(){
        let databaseRef = Database.database().reference()
        databaseRef.child("hospitals").observe(.childAdded) { (snapshot) in
            print(snapshot)
            
            
            if let hospitalDataArray = snapshot.value as? [String:Any]{
                
                 if let hospitalName = hospitalDataArray["hospitalname"] as? String,
                    let hospitalCity = hospitalDataArray["hospitaladdress"] as? String,
                    let hospitalEmergencyNumber = hospitalDataArray["Emergencynumber"] as? String,
                    let hospitalDepartments = hospitalDataArray["hospitalDepartments"] as? String
                {
                    let hospital = hospitalModel.init(hospitalID: snapshot.key, hospitalName: hospitalName, hospitalCity: hospitalCity, hospitalEmergencyNumber: hospitalEmergencyNumber, hospitalDepartments: hospitalDepartments)

                    self.hospitals.append( hospital)
                    self.hospitalsTabelView.reloadData()
                    
                }
                
            }
            
        }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hospital = self.hospitals[indexPath.row]
        let cell = hospitalsTabelView.dequeueReusableCell(withIdentifier: "hospitalCellId") as!
hospitalsCell
        
        cell.hospitalNameLa.text = hospital.hospitalName
        cell.hospitalCityLa.text = hospital.hospitalCity
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedhospital = self.hospitals[indexPath.row]
        
        //.......................
       let departVc = self.storyboard?.instantiateViewController(withIdentifier: "departmentsVC") as! DepartmentsVC
        
        //must be before present to pass it's value
        departVc.chosenHospital = selectedhospital
        present(departVc, animated: true, completion: nil)


    }

}
