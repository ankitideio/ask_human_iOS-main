//
//  ChatVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwDot: UIImageView!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblVwChat: UITableView!
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    //MARK: - ACTION
    
    @IBAction func actionMore(_ sender: UIButton) {
        
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension ChatVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellReceiver = tableView.dequeueReusableCell(withIdentifier: "ReceiverTVC", for: indexPath) as! ReceiverTVC
            return cellReceiver
        }else{
            let cellSender = tableView.dequeueReusableCell(withIdentifier: "SenderTVC", for: indexPath) as! SenderTVC
            return cellSender
        }
    }
    
    
}
