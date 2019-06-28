//
//  messageCellVC.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/24/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit

class messageCellVC: UITableViewCell {
    
    @IBOutlet weak var usernameLa: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var messageContainer: UIView!
    
    enum msgType {
        case incoming
        case outgoing
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageContainer.layer.cornerRadius = 10
    }

    func setMessagedate(message: MessageModel) {
    usernameLa.text = message.senderName
    msgTextView.text = message.messageText
    }
    func setMsgType(type: msgType){
        if (type == .incoming){
            messageStackView.alignment = .leading
            messageStackView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            msgTextView.textColor = .black
        }else if (type == .outgoing){
            messageStackView.alignment = .trailing
            messageStackView.backgroundColor = #colorLiteral(red: 0.05481565744, green: 0.5201141834, blue: 0.9635997415, alpha: 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
