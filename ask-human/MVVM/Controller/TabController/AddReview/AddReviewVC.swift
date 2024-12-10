//
//  AddReviewVC.swift
//  ask-human
//
//  Created by meet sharma on 18/11/23.
//

import UIKit
import FloatRatingView
import IQKeyboardManagerSwift

class AddReviewVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet var btnCross: UIButton!
    @IBOutlet weak var backGroundVw: UIView!
    
    @IBOutlet var txtVwReview: IQTextView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    
    @IBOutlet weak var ratingVw: FloatRatingView!
    
    var viewModel = ReviewVM()
    var messageId = ""
    var userId = ""
    var callBack:(()->())?
    var isReview = false
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        btnDismiss.gradientButton("Dismiss", startColor: UIColor(red: 240/255, green: 11/255, blue: 128/255, alpha: 1.0), endColor: UIColor(red: 122/255, green: 13/255, blue: 158/255, alpha: 1.0), textSize: 15.0, fontFamily: "Poppins-Medium")
        txtVwReview.contentInset = UIEdgeInsets(top: 7, left: 12, bottom: 12, right: 7)
        backGroundVw.layer.cornerRadius = 40
        backGroundVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnDismiss.setTitleColor(.white, for: .normal)
            btnDismiss.borderCol = .white
            btnCross.setImage(UIImage(named: "crosswhite"), for: .normal)
            backGroundVw.backgroundColor = UIColor(hex: "#161616")
            ratingVw.backgroundColor = UIColor(hex: "#161616")
            txtVwReview.backgroundColor = UIColor(hex: "#161616")
            let placeholderText = "Write you review here"
            let placeholderColor = UIColor(hex: "#FFFFFF")
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor,
                .font: UIFont.systemFont(ofSize: 14)
            ]
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            txtVwReview.attributedPlaceholder = attributedPlaceholder
             
        }else{
            let placeholderText = "Write you review here"
            let placeholderColor = UIColor(hex: "#000000").withAlphaComponent(0.60)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor,
                .font: UIFont.systemFont(ofSize: 14)
            ]
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            txtVwReview.attributedPlaceholder = attributedPlaceholder
            ratingVw.backgroundColor = .white
            txtVwReview.backgroundColor = .white
            backGroundVw.backgroundColor = .white
            btnCross.setImage(UIImage(named: "crossBlack"), for: .normal)
            btnDismiss.setTitleColor(.black, for: .normal)
            btnDismiss.borderCol = UIColor(hex: "#DCDCDC")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    
        {
            
            let touch = touches.first
            if touch?.view != self.backGroundVw
            { self.dismiss(animated: true, completion: nil) }
            
        }
    
    //MARK: - ACTION
    
    @IBAction func acionCross(_ sender: UIButton) {
    }
    @IBAction func actionDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func actionAddRating(_ sender: GradientButton) {
        if ratingVw.rating == 0{
            
            showSwiftyAlert("", "Please add the review", false)
            
        }else{
            
            viewModel.addReview(messageId: messageId, userId: userId, comment: txtVwReview.text ?? "", count: Int(ratingVw.rating)) {
                
                self.dismiss(animated: true)
                self.callBack?()

            }
        }
            }
    
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}


   

