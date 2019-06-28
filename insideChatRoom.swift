//
//  insideChatRoom.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/22/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase
//import FirebaseAuth

class insideChatRoom: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    
  var chosenRoom:Room?
  var chatMessages = [MessageModel]()

    @IBOutlet weak var messagesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.separatorStyle = .none
        messagesTableView.allowsSelection = false
        self.navigationItem.title = chosenRoom?.roomName
//        observeMessages()
        messageObservation()
        self.hideKeyboardWhenTappedAround()
    }
 
    
    func messageObservation(){
        
        guard let tappedRoomId = chosenRoom?.roomID else{
            return
        }
        let databaseRef = Database.database().reference()
            databaseRef.child("rooms").child(tappedRoomId).child("messages").observe(.childAdded) { (snapshot) in
//                print(snapshot)
                
                if let DataArray = snapshot.value as? [String:Any]{
                    guard let senderName = DataArray["senderName"] as? String ,
                          let messageText = DataArray["messageText"] as? String,
                          let userid = DataArray["senderid"] as? String else{
                        return
                    }
                  let message = MessageModel.init(messageKey: snapshot.key, senderName: senderName, messageText: messageText, userID: userid)
                    self.chatMessages.append(message)
                    self.messagesTableView.reloadData()
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.chatMessages[indexPath.row]
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messageCellID") as! messageCellVC
        
        cell.setMessagedate(message: message)
//        cell.usernameLa.text = message.senderName
//        cell.msgTextView.text = message.messageText
        if(message.userID == Auth.auth().currentUser?.uid){
            cell.setMsgType(type: .outgoing)
        }else{
            cell.setMsgType(type: .incoming)
        }
        return cell
    }
   
  
    @IBOutlet weak var messageTF: UITextField!
    
    func getUserNameWithId( id : String, cpmpletion: @escaping(_ userName:String?) ->()){
        
        let  databaseRef = Database.database().reference()
        let user = databaseRef.child("users").child(id)
        user.child("username").observeSingleEvent(of: .value) { (snapeddata) in
            if let receivedusername = snapeddata.value as? String{
                cpmpletion(receivedusername)
            }else{
                cpmpletion(nil)
            }
        }
    }
    
    
    func sendMessage(text: String, completion: @escaping (_ isSuccess:Bool) -> ())
    {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        getUserNameWithId(id: userID) { (userName) in
    
            if let receivedusername = userName {
                if let roomId = self.chosenRoom?.roomID, let currentUserId = Auth.auth().currentUser?.uid{
                    let messageDetails : [String:Any] = ["senderName":receivedusername , "messageText":text,"senderid":currentUserId]
                    let  databaseRef = Database.database().reference()
                    let accessedRoom = databaseRef.child("rooms").child(roomId)
                    accessedRoom.child("messages").childByAutoId().setValue(messageDetails, withCompletionBlock: { (error, ref) in
                        if (error == nil){
                        completion(true)
                            self.messageTF.text = ""
                        }
                      else{
                     completion(false)
                          }
                    })
                }
                
                //                print("welcome : \(receivedusername)")
            }
          }
        }
        
    
    @IBAction func sendBu(_ sender: UIButton) {
        guard let chatText = self.messageTF.text, chatText.isEmpty == false  else{
            return
        }
        sendMessage(text: chatText) { (isSuccess) in
            if (isSuccess){
                print("message sent ")
                self.messageTF.text = ""
            }
        }
    }
    
    @IBAction func backToRoomsBU(_ sender: Any) {

        let Rooms = self.storyboard?.instantiateViewController(withIdentifier: "startOver") as! UITabBarController
      self.present(Rooms , animated: true , completion: nil)

//        self.dismiss(animated: true, completion: nil) //to remove old one from ram
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
}
}
