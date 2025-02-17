//
//  AddHashtagVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 03/01/25.
//

import UIKit
import AlignedCollectionViewFlowLayout

class AddHashtagVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var viewTextAreaGtay: UIView!
    @IBOutlet var viewBAck: UIView!
    @IBOutlet var viewAdHashtag: UIView!
    @IBOutlet var heightCollVwSuggestHashtag: NSLayoutConstraint!
    @IBOutlet var collVwSuggestHashtag: UICollectionView!
    @IBOutlet var heighCollvwHAshtag: NSLayoutConstraint!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var txtfldHashtag: UITextField!
    //MARK: - variables
    var arrHashtags = [Hashtag]()
    var arrSuggestHashtags = [GetSearchHashtagData]()
    var viewModel = ProfileVM()
    var callBack:((_ arrHashtag:[String],_ isSkip:Bool)->())?
    var isClick = true
    var isComing = false
    var isMatched = false
    var arrNewHashtags = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    private func uiSet(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        viewTextAreaGtay.isUserInteractionEnabled = true
        viewTextAreaGtay.addGestureRecognizer(tapGesture)
        let nib = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib, forCellWithReuseIdentifier: "AddHashtagCVC")
        collVwHashtag.delegate = self
        collVwHashtag.dataSource = self
        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwSuggestHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        let alignedFlowLayoutCollVwHashtag2 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwSuggestHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag2
        
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.invalidateLayout() 
        }
        if let flowLayoutSuggest = collVwSuggestHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutSuggest.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayoutSuggest.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayoutSuggest.invalidateLayout()
        }
    }
    private func darkMode() {
        let isDark = traitCollection.userInterfaceStyle == .dark
        viewTextAreaGtay.backgroundColor = isDark ? UIColor(hex: "#333333") : UIColor(hex: "#D9D9D9").withAlphaComponent(0.5)
        let placeholderColor =  isDark ? UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0) : .placeholder
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor
        ]
        txtfldHashtag.attributedPlaceholder = NSAttributedString(string: "#hashtag", attributes: attributes)
    }

    @objc func handleViewTap() {
        if arrHashtags.count == 0{
            txtfldHashtag.becomeFirstResponder()
        }
    }
    private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        
        // Ensure collection view has been fully laid out before getting content size
        DispatchQueue.main.async {
            let contentHeight = collectionView.contentSize.height
            let minHeight: CGFloat = 60
            let maxHeight: CGFloat = 200
            
            // Set the constraint constant within the min and max bounds
            if collectionView == self.collVwSuggestHashtag{
                if self.arrSuggestHashtags.count > 0{
                    constraint.constant = min(max(contentHeight, minHeight), maxHeight)
                }else{
                    constraint.constant = min(max(contentHeight, 0), 0)
                }
                
            }else{
                constraint.constant = min(max(contentHeight, minHeight), maxHeight)
            }
            
        }
    }

    
    // MARK: - IBAction
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func actionSkip(_ sender: UIButton) {
        if isClick{
            isClick = false
            if isComing {
                self.dismiss(animated: true)
            }else{
                
                callBack?([""], true)
            }
            
        }
    }
    @IBAction func actionSearch(_ sender: GradientButton) {
        if isClick {
               isClick = false
               if isComing {
                   let hashtagTitles = arrNewHashtags.compactMap { $0 }
                    Store.searchHastag = hashtagTitles
                   self.dismiss(animated: true)
                   callBack?(hashtagTitles, false)

               } else {
                   let hashtagTitles = arrHashtags.compactMap { $0.title }
                   Store.searchHastag = hashtagTitles
                   callBack?(hashtagTitles, false)
               }
           }
    }
}
// MARK: - UITextFieldDelegate
extension AddHashtagVC:UITextFieldDelegate{
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtfldHashtag {
            guard let text = textField.text, !text.isEmpty else { return false }
            let existingHashtag = arrHashtags.first { $0.title?.lowercased() == text.lowercased() }
            if existingHashtag == nil {
                let newHashtag = Hashtag(id: "", title: text, userIDS: [""], isVerified: nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                arrSuggestHashtags.removeAll()
                arrHashtags.append(newHashtag)
                arrNewHashtags.append(text)
                collVwHashtag.reloadData()
                collVwSuggestHashtag.reloadData()
                updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwSuggestHashtag)
                updateHeight(for: collVwHashtag, constraint: heighCollvwHAshtag)
                updateheightCollVwSuggestHashtags()
                updateheightCollVwHashtags()
                
            } else {
                print("Hashtag already exists")
            }
            textField.text = ""
            textField.resignFirstResponder()
        }
        return true
    }

    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField == txtfldHashtag{
             if string.contains(" ") {
                            return false
                        }

                let currentText = (textField.text ?? "") as NSString
                        let newText = currentText.replacingCharacters(in: range, with: string)
                print("newText:--\(newText)")
                if newText == ""{
                        arrSuggestHashtags.removeAll()
                    DispatchQueue.main.async {
                        self.collVwSuggestHashtag.reloadData()
                        self.updateheightCollVwSuggestHashtags()
                        self.updateHeight(for: self.collVwSuggestHashtag, constraint: self.heightCollVwSuggestHashtag)
                    }
                }else{
                   // arrSuggestHashtags.removeAll()
                    getSearchHashtags(searchText: newText)
                }
            }
            return true
           
        }
    func getSearchHashtags(searchText:String){
            viewModel.getSearchHashtagApi(searchBy: searchText) { [weak self] data
                in
                guard let self = self else { return }
                self.arrSuggestHashtags = data
                self.collVwSuggestHashtag.reloadData()
                self.updateHeight(for: self.collVwSuggestHashtag, constraint: self.heightCollVwSuggestHashtag)
                self.updateheightCollVwSuggestHashtags()
                    }
            }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension AddHashtagVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collVwHashtag{
            if arrHashtags.count > 0{
                return arrHashtags.count
            }else{
                return 0
            }
        }else{
            if arrSuggestHashtags.count > 0{
                return  arrSuggestHashtags.count
            }else{
                return 0
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwHashtag{
            guard indexPath.row < arrHashtags.count else {
                fatalError("Index out of range for arrHashtags at \(indexPath.row)")
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            if arrHashtags.count > 0{
                
                cell.viewBack.borderWid = 0
                cell.viewBack.layer.cornerRadius = 12
                cell.viewBtnDelete.isHidden = false
                cell.btnDelete.tag = indexPath.row
                cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
                cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
                let isDarkMode = traitCollection.userInterfaceStyle == .dark
                cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
                cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EE0C81").withAlphaComponent(0.20)
                cell.lblHashtag.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#373737")
                if arrHashtags[indexPath.row].isVerified == 1 {
                    cell.widthImgVerify.constant = 14
                    cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                } else {
                    cell.widthImgVerify.constant = 0
                }
            }
            
            return cell
        }else{
            guard indexPath.row < arrSuggestHashtags.count else {
                fatalError("Index out of range for arrSuggestHashtags at \(indexPath.row)")
            }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
                
                if arrSuggestHashtags.count > 0 {
                    if let customFont = UIFont(name: "Nunito-Medium", size: 10) {
                        cell.lblHashtag.font = customFont
                    }
                    cell.viewBack.layer.cornerRadius = 12
                    cell.viewBtnDelete.isHidden = true

                    let suggestHashtag = arrSuggestHashtags[indexPath.row]
                    cell.lblHashtag.text = "#\(suggestHashtag.title ?? "")"
                    if isComing{
                        isMatched = arrNewHashtags.contains { $0 == suggestHashtag.title }
                    }else{
                        isMatched = arrHashtags.contains { $0.title == suggestHashtag.title }
                    }
                    if isMatched {
                        cell.imgVwVerify.image = UIImage(named: "whiteverify")
                        cell.viewBack.backgroundColor = .app
                        cell.lblHashtag.textColor = .white
                    } else {
                        cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                        if traitCollection.userInterfaceStyle == .dark {
                            cell.viewBack.backgroundColor = UIColor(hex: "#610D38")
                            cell.lblHashtag.textColor = UIColor(hex: "#CCCCCC")
                            cell.viewBack.borderWid = 0
                        }else{
                            cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                            cell.lblHashtag.textColor = .black
                            cell.viewBack.borderWid = 0
                        }
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

                    if suggestHashtag.usedCount == 0 {
                        cell.viewUserCount.isHidden = true
                    } else if suggestHashtag.usedCount ?? 0 < 100 {
                        cell.viewUserCount.isHidden = false
                        cell.widthViewUsedCount.constant = 16
                        cell.heightUsedCount.constant = 16
                        cell.viewUserCount.layer.cornerRadius = 8
                    } else {
                        cell.viewUserCount.isHidden = false
                        cell.widthViewUsedCount.constant = 18
                        cell.heightUsedCount.constant = 18
                        cell.viewUserCount.layer.cornerRadius = 9
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

            if isComing {
                let isAlreadyInSearch = arrNewHashtags.contains { $0 == selectedHashtag.title }
                if !isAlreadyInSearch {
                    arrNewHashtags.append(selectedHashtag.title ?? "")
                    arrHashtags.append(Hashtag(id: "", title: selectedHashtag.title, userIDS: [""], isVerified: selectedHashtag.isVerified, usedCount: selectedHashtag.usedCount, createdBy: "", createdAt: "", updatedAt: ""))
                } else {
                    print("Hashtag already exists in Store.searchHastag.")
                }
            } else {
                let isAlreadyInHashtags = arrHashtags.contains { $0.title == selectedHashtag.title }
                if !isAlreadyInHashtags {
                    arrHashtags.append(Hashtag(id: "", title: selectedHashtag.title, userIDS: [""], isVerified: selectedHashtag.isVerified, usedCount: selectedHashtag.usedCount, createdBy: "", createdAt: "", updatedAt: ""))
                } else {
                    print("Hashtag already exists in arrHashtags.")
                }
                
            }

            collVwHashtag.reloadData()
            collVwSuggestHashtag.reloadData()
            updateHeight(for: collVwHashtag, constraint: heighCollvwHAshtag)
            updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwSuggestHashtag)
            
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
                updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwSuggestHashtag)
                updateHeight(for: collVwHashtag, constraint: heighCollvwHAshtag)
                updateheightCollVwSuggestHashtags()
                updateheightCollVwHashtags()

            }
        }
    func updateheightCollVwHashtags() {
        heighCollvwHAshtag.constant = collVwHashtag.contentSize.height
    }
    func updateheightCollVwSuggestHashtags() {
        heightCollVwSuggestHashtag.constant = collVwSuggestHashtag.contentSize.height
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
