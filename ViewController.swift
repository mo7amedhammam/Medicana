//
//  ViewController.swift
//  Medicana
//
//  Created by Mohamed Hammam on 4/12/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource ,
    UITextFieldDelegate ,
    UITableViewDelegate  ,
UITableViewDataSource
{
   
  
    @IBOutlet weak var pickerviewOutlet: UIPickerView!
    @IBOutlet weak var SelectedGender: UILabel!
    

    
//    @IBOutlet weak var moreCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
//        pickerviewOutlet.dataSource=self
//        pickerviewOutlet.delegate=self
        
//        tryAddingData()
    }

    func tryAddingData(){
        let reference = Database.database().reference()
        let users = reference.child("Users")
        users.setValue("mohamed")
    }
    
    
    var morecellsArray = [ "Contact Us","About Medicana" , "Log Out" ]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return morecellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)
        cell.textLabel?.text = morecellsArray[indexPath.row]
        return cell
    }


//    Setting Gender Picker View
    var GenderArray = ["Male","Female"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GenderArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GenderArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedGender.text = GenderArray[row];
    }
  
    
//    Hide Keyboard When tap anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     self.view.endEditing(true)
        }

    //    Activate return Key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var mobilenumberTF: UITextField!
    @IBOutlet weak var GenderLA: UILabel!
    @IBOutlet weak var birthyearTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmpasswordTF: UITextField!
    
    @IBAction func DoneRegisteringBu(_ sender: Any) {
        userRegisteration()
        
    }
    
    // creating a user
    func userRegisteration(){
        guard let emailAddress = usernameTF.text , let password = passwordTF.text , let fullname = fullnameTF.text , let phone = mobilenumberTF.text , let birthyaer = birthyearTF.text , let gender = GenderLA.text,
            let bookedHospital:String = "",
            let bookedDepartment:String  = ""
        else {
            return
        }
        
        if(emailAddress.isEmpty == true || password.isEmpty == true || fullname.isEmpty == true || phone.isEmpty == true || gender.isEmpty == true){
            displayerror(errorBody: "fill in required fields !")
        }

           Auth.auth().createUser(withEmail: emailAddress, password: password) { (result, Error) in
            if (Error == nil){
//            print(result?.user.uid)
//                move to login Screen
             self.performSegue(withIdentifier: "gotouserlogin", sender: self)
                
                guard let createduserid = result?.user.uid
                else {
                    return
                }
//      saving user details to databese with createduserid
          let firereference = Database.database().reference()
                let createduser = firereference.child("users").child(createduserid)
                let userDataArray:[String:Any] = ["username": fullname , "mobilenumber":phone , "birthyear": birthyaer , "gender": gender , "bookedHospital": bookedHospital , "bookedDepartment": bookedDepartment ]
                createduser.setValue(userDataArray)
                
            }
        }
    }
    

    @IBOutlet weak var hospitalnameTF: UITextField!
    @IBOutlet weak var hospitalAddressTF: UITextField!
    @IBOutlet weak var hospitalEmergencyPhoneTF: UITextField!
    @IBOutlet weak var hospitalEmailAddressTF: UITextField!
    @IBOutlet weak var hospitalPasswordTF: UITextField!
    @IBOutlet weak var hospitalconfirmpasswordTF: UITextField!
    @IBOutlet weak var hospitalDepartmentsTextView: UITextView!
    
    @IBAction func doneHospitalRegisteration(_ sender: Any) {
        hospitalRegisteration()
    }
 
    // creating a hospital account
    func hospitalRegisteration(){
        guard let hospitalemailAddress = hospitalEmailAddressTF.text , let hospitalpassword = hospitalPasswordTF.text , let hospitalname = hospitalnameTF.text , let Emergencyphone = hospitalEmergencyPhoneTF.text , let hospitalAddress = hospitalAddressTF.text , let hospitaldepartments = hospitalDepartmentsTextView.text
            else {
                return
        }
        if(hospitalemailAddress.isEmpty == true || hospitalpassword.isEmpty == true){
            displayerror(errorBody: "Username or Password can't be empty")
        }

        Auth.auth().createUser(withEmail: hospitalemailAddress, password: hospitalpassword) { (result, Error) in
            if (Error == nil){
                //            print(result?.user.uid)
                
                guard let createdhospitalid = result?.user.uid else{
                    return
                }
                //      saving hospital details to databese with hospitalid
                let firereference = Database.database().reference()
                let createdhospital = firereference.child("hospitals").child(createdhospitalid)
                let hospitalDataArray:[String:Any] = ["hospitalname": hospitalname , "Emergencynumber":Emergencyphone , "hospitaladdress": hospitalAddress, "hospitalDepartments": hospitaldepartments ]
                createdhospital.setValue(hospitalDataArray)
                
                // move to hospital login view
                self.performSegue(withIdentifier: "gotohospitallogin", sender: self)

                
            }
        }
    }
    
    @IBOutlet weak var loginusernameTF: UITextField!
    @IBOutlet weak var loginpasswordTF: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
      userlogin()
    }
    
    // login as a user or as a hospital
    func userlogin(){
        guard let loginusername = loginusernameTF.text , let loginpassword = loginpasswordTF.text
            else {
                return
        }
        if(loginusername.isEmpty == true || loginpassword.isEmpty == true){
            displayerror( errorBody: "Username or Password can't be empty")
        }else{
        Auth.auth().signIn(withEmail: loginusername, password: loginpassword) { (result, error) in
            if (error == nil){
//                print(result)
                self.performSegue(withIdentifier: "gotomain", sender: self)
            }else{
                self.displayerror(errorBody : "Wrong Username or Password ")
            }
        }
    }
    }
    
    
//    Dismiss alert function && Error display
    func displayerror(errorBody : String){
        let alert = UIAlertController.init(title: "Error", message: errorBody, preferredStyle: .alert)
        let dismissbutton = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissbutton)
        self.present(alert, animated: true, completion: nil)
        
    }
   
    
}

