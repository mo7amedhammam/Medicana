//
//  MoreVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/17/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit
import Firebase

class homeVC: UIViewController    // UITableViewDelegate  ,
//    UITableViewDataSource
 {
    
    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser == nil){
            self.performSegue(withIdentifier: "gotologin", sender: self)
        }
    }

//    @IBOutlet weak var moreTableViewOutlet: UITableView!
//
//    @IBOutlet weak var moreCellImage: UIImageView!
//    override func viewDidLoad() {
//        super.viewDidLoad()

        // Do any additional setup after loading the view.
//    }
    
//    var morecellsArray = [ "Contact Us","About Medicana" , "Log Out" ]
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return morecellsArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)
//        cell.textLabel?.text = morecellsArray[indexPath.row]
//        return cell
//    }
//
//    //    setting image for more table view
//    var aboutUsImage: UIImage = UIImage(named: "about-25")!
//    var contactUsImage: UIImage = UIImage(named: "contact-25")!
//    var logoutImage: UIImage = UIImage(named: "exit-25")!
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row==0{
//            moreCellImage.image = contactUsImage
////            moreCellImage.imageView?.image = contactUsImage
//        }
//        else  if indexPath.row==1{
//            moreCellImage.image = aboutUsImage
//
////            moreCellImage.imageView?.image = aboutUsImage
//        }
//        else{
//             moreCellImage.image = logoutImage
////            moreCellImage.imageView?.image = logoutImage
//        }



//}


    

}
