//
//  EditQuestionVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 29/01/25.
//

import UIKit

class EditQuestionVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet var txtVwQuestion: UITextView!
    
    //MARK: - variables
    var viewModel = NoteVM()
    var callBAck:(()->())?
    var question:String?
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        txtVwQuestion.text = question
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        txtVwQuestion.textColor = isDarkMode ? UIColor.white : .black
    }
    
    //MARK: - IBAction
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionSave(_ sender: UIButton) {
        if txtVwQuestion.text.trimWhiteSpace == ""{
            showSwiftyAlert("", "Please enter your question", false)
        }else{
            viewModel.editQuestionApi(note: txtVwQuestion.text ?? "", status: "1"){ data,message in
                Store.question = data?.createNotes?.note ?? ""
                self.dismiss(animated: true)
                self.callBAck?()
            }
        }
        
    }

}
