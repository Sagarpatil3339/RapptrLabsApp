//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfile.layer.cornerRadius = userProfile.bounds.height / 2
        userProfile.clipsToBounds = true
        body.layer.cornerRadius = 6.0
            }
    
   
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
        
        DispatchQueue.global(qos: .background).async {
           
            let endPoint = message.avatarURL;
            
            guard let endpointUrl = endPoint else {
                return;
            }
            var request = URLRequest(url: endpointUrl);
            request.httpMethod = "GET";
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept");
            
            httpResponse(request: request, completionHandler: { (data, error) in
                
                if let receivedData = data {
                    
                    DispatchQueue.main.async {
                        
                        self.userProfile.image = UIImage(data: receivedData);
                        
                    }
                }
            });
        }
    }
}
