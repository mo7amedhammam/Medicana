//
//  roomViewController.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/18/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class roomVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var roomNameTF: UITextField!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var roomArray = [Room]()

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self
        roomsobservation()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eachroom = self.roomArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomcell")!
        cell.textLabel?.text = eachroom.roomName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let selectedRoom = self.roomArray[indexPath.row]
    
        let chatRoomVC = self.storyboard?.instantiateViewController(withIdentifier: "gotomessagesVC") as! insideChatRoom
        
        chatRoomVC.chosenRoom = selectedRoom //must be before present to pass it's value
        self.present(chatRoomVC,animated: true,completion: nil)
  
    }
    
    
    @IBAction func creatroomBU(_ sender: Any) {
        guard let roomName = self.roomNameTF.text , roomName.isEmpty != true else {
            return
        }
       let firebaseref = Database.database().reference()
        let room = firebaseref.child("rooms").childByAutoId()
        
        let dataArray:[String:Any] = ["roomName" : roomName]
        room.setValue(dataArray) { (error, errorRef) in
            if (error == nil){
                self.roomNameTF.text = ""
            }else{
                
            }
        }
    }
    
    func roomsobservation(){
let fireRef = Database.database().reference()
        fireRef.child("rooms").observe(.childAdded) { (snapedData) in
//            print(receivedData)
            if let receivedDataAsArray = snapedData.value as? [String:Any]{
                if let receivedRoomName = receivedDataAsArray["roomName"] as? String{
                    let room = Room.init(roomID: snapedData.key, roomName: receivedRoomName)
                    	 self.roomArray.append(room)
                    self.tableViewOutlet.reloadData()
                }
            }
            
        }
    }
    
    //    Hide Keyboard When tap anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

