//
//  EditProfileHashtagVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import UIKit
import AlignedCollectionViewFlowLayout

class EditProfileHashtagVC: UIViewController {
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var txtFldHahstag: UITextField!
    @IBOutlet var btnBAck: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var heightCollvw: NSLayoutConstraint!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var heightCollvwSuiggestHashtag: NSLayoutConstraint!
    @IBOutlet var collVwSuggestHashtag: UICollectionView!
    
    var arrHashtags = [Hashtag]()
    var arrSuggestHashtags = [GetSearchHashtagData]()
    var viewModel = ProfileVM()
    var isMatched = false
    var callBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldHahstag.delegate = self
        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        let nib = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwSuggestHashtag.register(nib, forCellWithReuseIdentifier: "AddHashtagCVC")
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
        arrHashtags = Store.Hashtags?.data?.user?.hashtags ?? []
        updateCollectionViewHeight()
    }
    private func updateCollectionViewHeight() {
        updateHeight(for: collVwHashtag, constraint: heightCollvw)
        updateHeight(for: collVwSuggestHashtag, constraint: heightCollvwSuiggestHashtag)
        }
        
        private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
            collectionView.layoutIfNeeded()
            DispatchQueue.main.async {
                constraint.constant = collectionView.contentSize.height
            }
        }
    @IBAction func actionSave(_ sender: UIButton) {
        viewModel.addHashtagsAppi(hashtags: [arrHashtags]) {message in 
      //  DispatchQueue.global(qos: .background).async {
                self.viewModel.getProfileApi { data in
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.callBack?()
                   }
                }
            //}
        }

    }
    
    @IBAction func actionBAck(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension EditProfileHashtagVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collVwHashtag{
            if arrHashtags.count > 0{
                return arrHashtags.count
            }else{
                return 0
            }
        }else{
            if arrSuggestHashtags.count > 0{
                return arrSuggestHashtags.count
            }else{
                return 0
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwHashtag{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            
                    if arrHashtags.count > 0{
                    cell.viewBack.borderWid = 0
                    cell.lblHashtag.textColor = .black
                    cell.viewBack.layer.cornerRadius = 17
                    cell.viewBtnDelete.isHidden = false
                    cell.btnDelete.tag = indexPath.row
                    cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
                    cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
                    cell.viewBack.backgroundColor = UIColor(hex: "#EDBFD7")
                  if arrHashtags[indexPath.row].isVerified == 1{
                    cell.widthImgVerify.constant = 14
                    cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                    }else{
                    cell.widthImgVerify.constant = 0
                    }
                    cell.imgVwDeleteBtn.image = UIImage(named: "newCross")
                    cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"

            }
            return cell
        }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
                if arrSuggestHashtags.count > 0 {
                    cell.lblHashtag.textColor = .black
                    cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                    if let customFont = UIFont(name: "Nunito-Medium", size: 10) {
                        cell.lblHashtag.font = customFont
                    }
                    cell.viewBack.layer.cornerRadius = 16
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
                        cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                        cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                        cell.lblHashtag.textColor = .black
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
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        if collectionView == collVwSuggestHashtag {

            let selectedHashtag = arrSuggestHashtags[indexPath.row]

                let isAlreadyInHashtags = arrHashtags.contains { $0.title == selectedHashtag.title }
                if !isAlreadyInHashtags {
                    arrHashtags.append(Hashtag(id: selectedHashtag.id, title: selectedHashtag.title, userIDS: [""], isVerified: selectedHashtag.isVerified, usedCount: selectedHashtag.usedCount, createdBy: "", createdAt: "", updatedAt: ""))
                } else {
                    print("Hashtag already exists in arrHashtags.")
                }
            
            collVwHashtag.reloadData()
            collVwSuggestHashtag.reloadData()
            updateCollectionViewHeight()
            heightCollvwSuiggestHashtag.constant = collVwSuggestHashtag.contentSize.height
            heightCollvw.constant = collVwHashtag.contentSize.height
        }
    }

    @objc func actionDelete(sender: UIButton) {
        if arrHashtags.count > 0 {
            view.endEditing(true)
            let index = sender.tag
            let deletedHashtag = arrHashtags[index]
            arrHashtags.remove(at: index)
            collVwHashtag.reloadData()
            collVwSuggestHashtag.reloadData()
            updateCollectionViewHeight()
            heightCollvwSuiggestHashtag.constant = collVwSuggestHashtag.contentSize.height
            heightCollvw.constant = collVwHashtag.contentSize.height

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
extension EditProfileHashtagVC:UITextFieldDelegate{
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldHahstag {
            guard let text = textField.text, !text.isEmpty else { return false }
            let existingHashtag = arrHashtags.first { $0.title?.lowercased() == text.lowercased() }
            if existingHashtag == nil {
                let newHashtag = Hashtag(id: "", title: text, userIDS: [""], isVerified: nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                arrSuggestHashtags.removeAll()
                arrHashtags.append(newHashtag)
                collVwHashtag.reloadData()
                collVwSuggestHashtag.reloadData()
                updateCollectionViewHeight()
                heightCollvwSuiggestHashtag.constant = collVwSuggestHashtag.contentSize.height
                heightCollvw.constant = collVwHashtag.contentSize.height
            } else {
                print("Hashtag already exists")
            }
            textField.text = ""
            textField.resignFirstResponder()
        }
        return true
    }

    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField == txtFldHahstag{
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
                    heightCollvwSuiggestHashtag.constant = collVwSuggestHashtag.contentSize.height
                    heightCollvw.constant = collVwHashtag.contentSize.height

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
                self.heightCollvwSuiggestHashtag.constant = self.collVwSuggestHashtag.contentSize.height
                self.heightCollvw.constant = self.collVwHashtag.contentSize.height
}
            }

    
}
