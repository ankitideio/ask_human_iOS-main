//
//  SuggestMessageVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class SuggestMessageVC: UIViewController {

    //MARK: - OUTLETS
    
    @IBOutlet weak var tblVwMessage: UITableView!
    @IBOutlet weak var txtFldMessage: UITextField!
    @IBOutlet weak var lblName: UILabel!
    
    //MARK: - VARIABLE
    
    var arrMessage = ["Explain quantum computing in simple terms","Got any creative ideas for a 10 years old’s birthday?","How do I make an HTTP request in javascript?"]
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
              }
    
    //MARK: - ACTIONS
    
    @IBAction func actionRefresh(_ sender: UIButton) {
        
    }
    
    @IBAction func actionSend(_ sender: UIButton) {
        
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension SuggestMessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestMessageTVC", for: indexPath) as! SuggestMessageTVC
        cell.lblMessage.text = arrMessage[indexPath.row]
        return cell
    }
    
    
}
