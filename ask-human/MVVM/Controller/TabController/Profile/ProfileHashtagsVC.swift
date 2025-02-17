//
//  ProfileHashtagsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import UIKit
import AlignedCollectionViewFlowLayout

class ProfileHashtagsVC: UIViewController {
    @IBOutlet var viewBAckTextArea: UIView!
    @IBOutlet var heightVWTExtarea: NSLayoutConstraint!
    @IBOutlet var heightTxtFldHashtag: NSLayoutConstraint!
    @IBOutlet var btnSave: GradientButton!
    @IBOutlet var txtFldHashtag: UITextField!
    @IBOutlet var heightBtnSave: NSLayoutConstraint!
    @IBOutlet var heightImgVwAsk: NSLayoutConstraint!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnBAck: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var imgVwAsk: UIImageView!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var heightCollVwHashtag: NSLayoutConstraint!
    @IBOutlet var collVwSuggestHashtag: UICollectionView!
    var arrHashtags = [Hashtag]()
    var viewModel = ProfileVM()
    var arrSuggestHashtags = [GetSearchHashtagData]()
    var isMatched = false
    var isEdit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        viewBAckTextArea.isUserInteractionEnabled = true
        viewBAckTextArea.addGestureRecognizer(tapGesture)

        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        collVwSuggestHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 30)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
        let alignedFlowLayoutCollVwHashtag1 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwSuggestHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag1
        if let flowLayout1 = collVwSuggestHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout1.estimatedItemSize = CGSize(width: 0, height: 30)
            flowLayout1.itemSize = UICollectionViewFlowLayout.automaticSize
        }
        lblScreenTitle.text = "Hashtag"
        arrSuggestHashtags.removeAll()
        txtFldHashtag.text = ""
        arrHashtags = Store.Hashtags?.data?.user?.hashtags ?? []
        
        if arrHashtags.count > 0{
            isEdit = false
            btnEdit.isHidden = false
            heightTxtFldHashtag.constant = 0
            btnSave.isHidden = true
            lblSubtitle.text = "Here are your hashtags – update them anytime!"
            heightImgVwAsk.constant = 160
            collVwHashtag.reloadData()
            updateCollectionViewHeight()
        }else{
            isEdit = false
            btnEdit.isHidden = true
            heightTxtFldHashtag.constant = 30
            btnSave.isHidden = false
            lblSubtitle.text = ""
            heightImgVwAsk.constant = 0
            heightCollVwHashtag.constant = 0
            collVwHashtag.reloadData()
        }

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
    private func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnBAck.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblSubtitle.textColor = .white
        }else{
            btnBAck.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            lblSubtitle.textColor = .black

        }
    }

    // Selector function to handle the tap gesture
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        print("viewBackTextArea was tapped")
            if arrHashtags.count == 0{
                txtFldHashtag.becomeFirstResponder()
            }
    }

    private func updateCollectionViewHeight() {
        updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwHashtag)
        }
        
        private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
            collectionView.layoutIfNeeded()
            DispatchQueue.main.async {
               // constraint.constant = collectionView.contentSize.height
                if collectionView == self.collVwHashtag{
                    let calculatedHeight = collectionView.contentSize.height
                    constraint.constant = min(calculatedHeight, 200)
                    
                }else{
                    constraint.constant = collectionView.contentSize.height
                }
            }
        }

    @IBAction func actionSave(_ sender: GradientButton) {
        guard (!arrHashtags.isEmpty) else {
            showSwiftyAlert("", "At least add 1 hashtag is required.", false)
            return
        }

        viewModel.addHashtagsAppi(hashtags: [arrHashtags]) { message in
            
                self.viewModel.getProfileApi { data in
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = "Hashtag updated successfully"
                        vc.callBack = {
                            DispatchQueue.main.async {
                                self.uiSet()
                            }
                        }
                        self.navigationController?.present(vc, animated: false)
                    }
                }
        }

    }
    @IBAction func actionEdit(_ sender: UIButton) {
        btnEdit.isHidden = true
        isEdit = true
        lblScreenTitle.text = "Edit Hashtag"
        heightTxtFldHashtag.constant = 30
        txtFldHashtag.isHidden = false
        btnSave.isHidden = false
        lblSubtitle.text = ""
        heightImgVwAsk.constant = 0
        updateCollectionViewHeight()
        collVwSuggestHashtag.reloadData()
        collVwHashtag.reloadData()
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
    }
}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension ProfileHashtagsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collVwSuggestHashtag{
            if arrSuggestHashtags.count > 0{
                return arrSuggestHashtags.count
            }else{
                return 0
            }
        }else{
            if arrHashtags.count > 0 {
                return arrHashtags.count
            } else {
                return 0
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwSuggestHashtag{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            
                    if arrSuggestHashtags.count > 0{
                        cell.lblHashtag.textColor = .black
                        cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                        if let customFont = UIFont(name: "Nunito-Medium", size: 10) {
                            cell.lblHashtag.font = customFont
                        }
                        cell.viewBack.layer.cornerRadius = 12
                        cell.viewBtnDelete.isHidden = true
                        cell.viewBack.borderWid = 0
                        let suggestHashtag = arrSuggestHashtags[indexPath.row]
                        cell.lblHashtag.text = "#\(suggestHashtag.title ?? "")"
                            isMatched = arrHashtags.contains { $0.title == suggestHashtag.title }
                        if isMatched {
                            cell.viewBack.backgroundColor = .app
                            cell.imgVwVerify.image = UIImage(named: "whiteverify")
                            cell.lblHashtag.textColor = .white
                        } else {
                            cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                            cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                            cell.lblHashtag.textColor = .black
                        }

                        if suggestHashtag.isVerified == 1 {
                            cell.widthImgVerify.constant = 14
                        } else {
                            cell.widthImgVerify.constant = 0
                        }
                        cell.viewUserCount.setGradientBackground(
                            colors: [UIColor(hex: "#F10B81"), UIColor(hex: "#950D98")],
                            startPoint: CGPoint(x: 0.0, y: 0.0),
                            endPoint: CGPoint(x: 1.0, y: 1.0)
                        )
                        isMatched = arrHashtags.contains { $0.title == suggestHashtag.title }
                        if isMatched {
                            cell.viewBack.backgroundColor = .app
                            cell.imgVwVerify.image = UIImage(named: "whiteverify")
                            cell.lblHashtag.textColor = .white
                        } else {
                            let isDarkMode = traitCollection.userInterfaceStyle == .dark
                            
                            cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                            cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                            cell.lblHashtag.textColor = isDarkMode ? UIColor.white : .black
                        }

                        if suggestHashtag.usedCount == 0 {
                            cell.viewUserCount.isHidden = true
                        } else if suggestHashtag.usedCount ?? 0 < 100 {
                            cell.viewUserCount.isHidden = false
                            cell.widthViewUsedCount.constant = 16
                            cell.heightUsedCount.constant = 16
                            cell.viewUserCount.layer.cornerRadius = 8
                        } else {
                            cell.viewUserCount.isHidden = false
                            cell.widthViewUsedCount.constant = 20
                            cell.heightUsedCount.constant = 20
                            cell.viewUserCount.layer.cornerRadius = 10
                        }
                        cell.lblUsedCount.text = formatUsedCount(suggestHashtag.usedCount ?? 0)
                }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            if arrHashtags.count > 0{
                cell.viewBack.layer.cornerRadius = 12
                if isEdit{
                    cell.viewBtnDelete.isHidden = false
                }else{
                    cell.viewBtnDelete.isHidden = true
                }
                    
                cell.btnDelete.tag = indexPath.row
                cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
                cell.viewUserCount.isHidden = true
               
                cell.viewBack.borderWid = 0
                
                let isDarkMode = traitCollection.userInterfaceStyle == .dark
                cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") :  UIColor(hex: "#EDBFD7")
                cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
                cell.lblHashtag.textColor = isDarkMode ? UIColor.white : .black
                
                if arrHashtags[indexPath.row].isVerified == 1{
                    cell.widthImgVerify.constant = 14
                    cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                }else{
                    cell.widthImgVerify.constant = 0
                }
                cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        if collectionView == collVwSuggestHashtag {
            guard indexPath.row < arrSuggestHashtags.count else {
                print("Error: indexPath out of range")
                return
            }

            let selectedHashtag = arrSuggestHashtags[indexPath.row]

                let isAlreadyInHashtags = arrHashtags.contains { $0.title == selectedHashtag.title }
                if !isAlreadyInHashtags {
                    arrHashtags.append(Hashtag(id: selectedHashtag.id, title: selectedHashtag.title, userIDS: [""], isVerified: selectedHashtag.isVerified, usedCount: selectedHashtag.usedCount, createdBy: "", createdAt: "", updatedAt: ""))
                } else {
                    print("Hashtag already exists in arrHashtags.")
                }
            if arrHashtags.count > 0{
                isEdit = true
            }else{
                isEdit = false
            }
            collVwHashtag.reloadData()
            collVwSuggestHashtag.reloadData()
            updateCollectionViewHeight()
            heightCollVwHashtag.constant = collVwSuggestHashtag.contentSize.height
        }
    }

    @objc func actionDelete(sender: UIButton) {
        if arrHashtags.count > 0 {
            view.endEditing(true)
            let index = sender.tag
            arrHashtags.remove(at: index)
            collVwHashtag.reloadData()
            collVwSuggestHashtag.reloadData()
            updateCollectionViewHeight()
            heightCollVwHashtag.constant = collVwSuggestHashtag.contentSize.height
        }
    }

    func formatUsedCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return "\(count / 1_000_000)M+"
        } else if count >= 1_000 {
            return "\(count / 1_000)K+"
        } else if count % 100 == 0 {
            return "\(count)"
        } else if count > 100 {
            return "\(count / 100 * 100)+"
        } else {
            return "\(count)"
        }
    }

}
// MARK: - UITextFieldDelegate
extension ProfileHashtagsVC:UITextFieldDelegate{
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldHashtag {
            guard let text = textField.text, !text.isEmpty else { return false }
            let existingHashtag = arrSuggestHashtags.first { $0.title?.lowercased() == text.lowercased() }
            if existingHashtag == nil {
                let newHashtag = Hashtag(id: "", title: text, userIDS: [""], isVerified: nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                arrSuggestHashtags.removeAll()
                arrHashtags.append(newHashtag)
                
                if arrHashtags.count > 0{
                    isEdit = true
                }else{
                    isEdit = false
                }

                collVwHashtag.reloadData()
                collVwSuggestHashtag.reloadData()
                updateCollectionViewHeight()
                heightCollVwHashtag.constant = collVwSuggestHashtag.contentSize.height
            } else {
                print("Hashtag already exists")
            }
            textField.text = ""
            textField.resignFirstResponder()
        }
        return true
    }

    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == txtFldHashtag{
             if string.contains(" ") {
                            return false
                        }
                let currentText = (textField.text ?? "") as NSString
                        let newText = currentText.replacingCharacters(in: range, with: string)
                print("newText:--\(newText)")
                if newText == ""{
                    arrSuggestHashtags.removeAll()
                    collVwSuggestHashtag.reloadData()
                    updateCollectionViewHeight()
                    heightCollVwHashtag.constant = collVwSuggestHashtag.contentSize.height
                }else{
                    arrSuggestHashtags.removeAll()
                    getSearchHashtags(searchText: newText)
                }
            }
            return true
           
        }
    func getSearchHashtags(searchText:String){
        viewModel.getSearchHashtagApi(searchBy: searchText) { data
            in
            self.arrSuggestHashtags = data
            self.collVwSuggestHashtag.reloadData()
            self.updateCollectionViewHeight()
            self.heightCollVwHashtag.constant = self.collVwSuggestHashtag.contentSize.height
        }
            }

    
}
