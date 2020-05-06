//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [Message]?
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTable.separatorStyle = .none
        messages = [Message]()
        configureTable(tableView: chatTable)
        title = "Chat"
        self.pullNext();
    }
    
    @objc func pullNext(){
        
        let endPoint = "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"
        
        guard let endpointUrl = URL(string: endPoint) else {
            return;
        }
        
        var request = URLRequest(url: endpointUrl);
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept");
        
        httpResponse(request: request) { (received_data, error) in
            
            guard let successData = received_data else{
                return
            }
            do{
                
                let rootObjec = try JSONSerialization.jsonObject(with: successData, options: []);
                
                if (rootObjec as? [String:Any]) != nil {
                    if let dictionary = rootObjec as? [String: Any] {
                        
                        if let messageArray =  dictionary["data"] as? [[String:Any]]{
                            
                            for message in messageArray {
                            
                                self.messages?.append(Message(dictionary: message));
                            
                            }
                            DispatchQueue.main.async {
                               self.chatTable.reloadData()
                            }
                        }
                    }
                }
                
            }catch{
                
            }
            
        }
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        cell?.setCellData(message: messages![indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
}
