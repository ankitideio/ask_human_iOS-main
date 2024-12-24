//
//  SearchNoteVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import AVFoundation
import TOCropViewController
import AVKit
import Kingfisher



class SearchNoteVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet var btnUpload: UIButton!
    @IBOutlet var viewNotificationCount: UIView!
    @IBOutlet var lblNotificationCount: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnDraft: UIButton!
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet weak var clsnVwAddPhotos: UICollectionView!
    @IBOutlet weak var txtVwNote: UITextView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwShadow: UIView!
    
    //MARK: - VARIABLES
    var viewModel = NoteVM()
    let imagePickerController = UIImagePickerController()
    var draftId = ""
    var isComing = false
    var arrImages = [Any]()
    var viewModelFile = MessageVM()
    var viewModelEarning = EarningVM()
    var currentWeekStartDate: Date = Date()
    var calendar = Calendar.current
    var page:Int?
    var wordsAfterHash: [String] = []
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
        darkMode()
        arrImages.removeAll()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("getnotifyCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfGetNotificationCount(notification:)), name: Notification.Name("GetNotificationCount"), object: nil)


        uiSet()
        if isComing == true{
            btnBack.isHidden = false
        }else{
            btnBack.isHidden = true
        }
        
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
              }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
        uiSet()
        getNotificationCount()
//        if Store.openSiri == false{
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
//                self.openSiri()
//                Store.openSiri = true
//            }
//        }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
       getNotificationCount()
        uiSet()
    }
    @objc func methodOfGetNotificationCount(notification: Notification) {
        
        getNotificationCount()
        
    }

    func openSiri(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SiriPopUpVC") as! SiriPopUpVC
        vc.modalPresentationStyle = .overFullScreen
        vc.callBack = { (voiceText) in
            self.txtVwNote.text = voiceText
            
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnUpload.setImage(UIImage(named: "mediaDark"), for: .normal)
            lblNotificationCount.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblName.textColor = .white
            lblScreenTitle.textColor = .white
            lblTitleMessage.textColor = .white
            btnDraft.backgroundColor = .white
            btnDraft.setTitleColor(.black, for: .normal)
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            txtVwNote.tintColor = .white
            
            
        }else{
            btnUpload.setImage(UIImage(named: "mediaLight"), for: .normal)
            txtVwNote.tintColor = .black
            lblNotificationCount.textColor = .white
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            lblName.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblScreenTitle.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblTitleMessage.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            btnDraft.backgroundColor = .black
            btnDraft.setTitleColor(.white, for: .normal)
            
        }
    }
    
    func getNotificationCount() {
        if WebSocketManager.shared.socket?.status == .connected{
            let param: parameters = ["userId": Store.userDetail?["userId"] as? String ?? ""]
            WebSocketManager.shared.getNotificationCount(dict: param)
            WebSocketManager.shared.notificationCount = { data in
                Store.notifyCount = data?[0].unreadCount ?? 0
                print("Received notification count data1111: \(data ?? [])")
                
                if data?[0].unreadCount ?? 0 > 0 {
                    self.viewNotificationCount.isHidden = false
                    self.lblNotificationCount.isHidden = false
                    self.lblNotificationCount.text = data?[0].unreadCount ?? 0 > 9 ? "9+" : "\(data?[0].unreadCount ?? 0)"
                } else {
                    self.viewNotificationCount.isHidden = true
                    self.lblNotificationCount.isHidden = true
                    self.lblNotificationCount.text = ""
                }
            }
        }
    }
    
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                uiSet()
                clsnVwAddPhotos.reloadData()
            }
        }
   
    func uiSet(){
      
        getEarning()
       
     
        
        if Store.isComingDraft == true{
            
            viewModel.draftDetail(id: draftId) { data in
                self.txtVwNote.text = data?.notesDraftDetails?.note ?? ""

                guard let media = data?.notesDraftDetails?.media else { return }

                for item in media {
                    if !self.arrImages.contains(where: { $0 as? String == item }) {
                        self.arrImages.append(item)
                    }
                }
                self.clsnVwAddPhotos.reloadData()
            }

            
        }
        lblName.text = "Hi, \(Store.userDetail?["userName"] as? String ?? "")"
    
        vwShadow.addTopShadow(shadowColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13), shadowOpacity: 0.9, shadowRadius: 5, offset: CGSize(width: 0.0, height : -5.0))
    }
    
    func getEarning(){
        
        calendar.firstWeekday = 1
           let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeekStartDate))!
           let endDate = calendar.date(byAdding: .day, value: 6, to: startDate)!
           let todayDate = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMM d yyyy"
          let date = dateFormatter.date(from: dateFormatter.string(from: todayDate)) ?? Date()
        if let date1 = dateFormatter.date(from: dateFormatter.string(from: startDate)),
           let date2 = dateFormatter.date(from: dateFormatter.string(from: endDate)) {
            
                dateFormatter.dateFormat = "yyyy-M-dd"
                let formattedDate1 = dateFormatter.string(from: date1)
                let formattedDate2 = dateFormatter.string(from: date2)
                print("StartDate",formattedDate1,"EndDate",formattedDate2)
            viewModelEarning.getEarningApi(startDate: formattedDate1, endDate: formattedDate2, showLoader: false) { data in
                Store.totalEarning = data?.walletBalance ?? 0
                
            }
        } else {
            print("Error converting date strings to Date objects.")
        }
        
    }

    
    func imageUploadApi(image:UIImage){
        viewModelFile.fileUpload(image: image) { data in
            self.arrImages.insert(data?.imageUrl ?? "", at:0)
            self.clsnVwAddPhotos.reloadData()
            print("Imageesss",self.arrImages)
        }
    }
    func videoUploadApi(videoUrl:URL){
        viewModelFile.fileUploadVideo(video: videoUrl){ data in
            self.arrImages.insert(data?.imageUrl ?? "", at:0)
            self.clsnVwAddPhotos.reloadData()
            print("Imageesss",self.arrImages)
        }
    }
    //MARK: - ACTIONS
    
    @IBAction func actionUpload(_ sender: UIButton) {
        if arrImages.count >= 5 {
            showSwiftyAlert("", "You can only upload up to 5 images and videos.", false)
            return
        }else{
            chooseImage()
        }
    }
    @IBAction func actionNotifications(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        vc.isComing = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionSaveDraft(_ sender: UIButton) {
        
        if Store.isComingDraft == true{
            updateNoteApi(status: "0", isComing: false)
            
        }else{
            addNoteApi(status: "0", isComing: false)
            
        }
        
        
    }
    
    @IBAction func actionSearch(_ sender: GradientButton) {
        let wordsWithHash = getWordsAfterHash(from: txtVwNote.text)

        if !wordsWithHash.isEmpty {
            print("Words after # are: \(wordsWithHash)")
            Store.hashtagForSearchUser = wordsWithHash
        } else {
            print("No words found after #")
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            if Store.isComingDraft == true{
                self.updateNoteApi(status: "1", isComing: true)
                
            }else{
                
                self.addNoteApi(status: "1", isComing: true)
                
            }
        }
    }
    
    func addNoteApi(status:String,isComing:Bool){
        
        if txtVwNote.text.trimWhiteSpace.isEmpty == true{
            if arrImages.isEmpty{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.message = "Please upload a photo or enter text."
                vc.modalPresentationStyle = .overFullScreen
                
                self.navigationController?.present(vc, animated:false)
            }else{
                var arrUpdateImage = [Any]()
                arrUpdateImage = arrImages
                print(arrUpdateImage)
//                if Store.totalEarning ?? 0 > 0 {
                    viewModel.addNoteApi(note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message  in
                        if isComing == true{
                            Store.notesId = data?.createNotes?.id ?? ""
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
                            Store.isRefer = false
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                            vc.message = message ?? ""
                            vc.isComing = false
                            vc.modalPresentationStyle = .overFullScreen
                            vc.callBack = {
                                SceneDelegate().tabBarHomeVCRoot()
                            }
                            self.navigationController?.present(vc, animated:false)
                        }
                        
                    }
//                }else{
//                    if isComing == true{
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
//                        vc.modalPresentationStyle = .overFullScreen
//                        vc.message = "You have insufficient funds for your search. First Add funds to continue."
//                        vc.isComing = true
//                        vc.callBack = {
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
//                            vc.isComing = true
//                            vc.callBack = {
//                                self.getEarning()
//                            }
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
//                        self.navigationController?.present(vc, animated: false)
//                    }else{
//                        viewModel.addNoteApi(note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message  in
//                            if isComing == true{
//                                Store.notesId = data?.createNotes?.id ?? ""
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
//                                Store.isRefer = false
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }else{
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
//                                vc.message = message ?? ""
//                                vc.isComing = false
//                                vc.modalPresentationStyle = .overFullScreen
//                                vc.callBack = {
//                                    SceneDelegate().tabBarHomeVCRoot()
//                                }
//                                self.navigationController?.present(vc, animated:false)
//                            }
//
//                        }
//
//                    }
//
//                }
            }
            }else{
                var arrUpdateImage = [Any]()
                arrUpdateImage = arrImages
               // if Store.totalEarning ?? 0 > 0 {
                    viewModel.addNoteApi(note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message  in
                        if isComing == true{
                            Store.notesId = data?.createNotes?.id ?? ""
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
                            Store.isRefer = false
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                            vc.message = message ?? ""
                            vc.isComing = false
                            vc.callBack = {
                                SceneDelegate().tabBarHomeVCRoot()
                            }
                            vc.modalPresentationStyle = .overFullScreen
                            self.navigationController?.present(vc, animated:false)
                        }
                    }
//                }else{
//                    if isComing == true{
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
//                        vc.modalPresentationStyle = .overFullScreen
//                        vc.message = "You have insufficient funds for your search. First Add funds to continue."
//                        vc.isComing = true
//                        vc.callBack = {
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
//                            vc.isComing = true
//
//                            vc.callBack = {
//                                self.getEarning()
//                            }
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
//                        self.navigationController?.present(vc, animated: false)
//                    }else{
//                        viewModel.addNoteApi(note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message  in
//                            if isComing == true{
//                                Store.notesId = data?.createNotes?.id ?? ""
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
//                                Store.isRefer = false
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }else{
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
//                                vc.message = message ?? ""
//                                vc.isComing = false
//                                vc.modalPresentationStyle = .overFullScreen
//                                vc.callBack = {
//                                    SceneDelegate().tabBarHomeVCRoot()
//                                }
//                                self.navigationController?.present(vc, animated:false)
//                            }
//
//                        }
//                    }
//                }
            }
    }
    func updateNoteApi(status:String,isComing:Bool){
        
         if txtVwNote.text == "" {
             if arrImages.isEmpty{
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                 vc.message = "Please upload a photo or enter text."
                 vc.modalPresentationStyle = .overFullScreen
                 self.navigationController?.present(vc, animated:false)
             }else{
                 var arrUpdateImage = [Any]()
                 arrUpdateImage = arrImages
//                 arrUpdateImage.remove(at: 0)
                 print(arrUpdateImage)
                 viewModel.updateNoteApi(id: draftId, note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message in
                     if isComing == true{
                         Store.notesId = data?.createNotes?.id ?? ""
                         let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
                         Store.isRefer = false
                         self.navigationController?.pushViewController(vc, animated: true)
                     }else{
                         let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                         vc.message = message ?? ""
                         vc.isComing = false
                         vc.callBack = {
                             let vc = self.storyboard?.instantiateViewController(withIdentifier: "DraftListVC") as! DraftListVC
                             vc.isComing = 1
                             self.navigationController?.pushViewController(vc, animated: true)
                         }
                         vc.modalPresentationStyle = .overFullScreen
                         self.navigationController?.present(vc, animated:false)

                     }
                     
                     
                 }
             }
             }else{
                 var arrUpdateImage = [Any]()
                 arrUpdateImage = arrImages
                 print(arrUpdateImage)
                 viewModel.updateNoteApi(id: draftId, note: txtVwNote.text ?? "", media: arrUpdateImage, status: status) { data,message in
                     if isComing == true{
                         Store.notesId = data?.createNotes?.id ?? ""
                        
                         let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
                         Store.isRefer = false
                         Store.isComingDraft = false
                         self.navigationController?.pushViewController(vc, animated: true)
                     }else{
                         let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                         vc.message = message ?? ""
                         vc.isComing = false
                         vc.modalPresentationStyle = .overFullScreen
                         vc.callBack = {
                             let vc = self.storyboard?.instantiateViewController(withIdentifier: "DraftListVC") as! DraftListVC
                             vc.isComing = 1
                             self.navigationController?.pushViewController(vc, animated: true)

                         }
                         self.navigationController?.present(vc, animated:false)

                     }
                     
                 }
             }
     }
    func chooseImage() {
           let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)

           // Check if the device has a camera
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                   self.showImagePicker(sourceType: .camera)
               }
               alertController.addAction(cameraAction)
           }

           // Add Photo Library option
           let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
               self.showImagePicker(sourceType: .photoLibrary)
           }
           alertController.addAction(photoLibraryAction)

           // Add Cancel option
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alertController.addAction(cancelAction)

           present(alertController, animated: true, completion: nil)
       }

       func showImagePicker(sourceType: UIImagePickerController.SourceType) {
         
           imagePickerController.sourceType = sourceType
           imagePickerController.delegate = self
           imagePickerController.mediaTypes = ["public.image", "public.movie"]
     
           present(imagePickerController, animated: true, completion: nil)
       }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let mediaType = info[.mediaType] as? String {
            
            if mediaType == "public.image" {
                if let image = info[.originalImage] as? UIImage {
                    imageUploadApi(image: image)
                }
               
            } else if mediaType == "public.movie" as String {
                if let videoURL = info[.mediaURL] as? URL {
                    let urlString = videoURL.absoluteString
                   videoUploadApi(videoUrl: videoURL)
                }
            }
            print("SelectData====",arrImages)
            picker.dismiss(animated: true, completion: nil)
        }
               
    }

    func generateThumbnail(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
                let thumbnail = UIImage(cgImage: thumbnailCGImage)
                
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
                print("Error generating thumbnail: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    
}
//MARK: -UITextViewDelegate
extension SearchNoteVC:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        applyTextAttributes(to: textView)
       }
       
    func applyTextAttributes(to textView: UITextView) {
        let text = textView.text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        
        // Split the text by lines
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
        var offset = 0
        
        for line in lines {
            let words = line.split(separator: " ")
            for word in words {
                let wordString = String(word)
                let range = NSRange(location: offset + (line as NSString).range(of: wordString).location, length: wordString.count)
                
                if word.hasPrefix("#") && word.count > 1 {
                    let boldFont = UIFont.boldSystemFont(ofSize: 14)
                    attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
                    attributedString.addAttribute(.font, value: boldFont, range: range)
                }
            }
            // Add the length of the current line plus the newline character to the offset
            offset += line.count + 1
        }
        
        textView.attributedText = attributedString
    }

   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (txtVwNote.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        return numberOfChars <= 200
    }
}
//MARK: - UICollectionViewDelegate
extension SearchNoteVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotosCVC", for: indexPath) as! AddPhotosCVC
        
            let data = arrImages[indexPath.row] as? String ?? ""
            if data.contains(".png") == true  || data.contains(".jpeg") == true  || data.contains(".jpg") == true{
                cell.imgVwUpload.image = nil
                cell.imgVwUpload.imageLoad(imageUrl: arrImages[indexPath.row] as? String ?? "")
                cell.imgVwPlay.isHidden = true
            }else{
                cell.imgVwUpload.image = nil
                cell.imgVwPlay.isHidden = false
                let urlString = arrImages[indexPath.row] as? String ?? ""
                if let videoURL = URL(string: urlString) {
                    cell.imgVwUpload.kf.indicatorType = .activity
                    cell.imgVwUpload.kf.indicator?.startAnimatingView()
                    
                    generateThumbnail(url: videoURL) { thumbnail in
                        if let thumbnail = thumbnail {
                                cell.imgVwUpload.kf.indicator?.stopAnimatingView()
                                cell.imgVwUpload.image = thumbnail
                            
                            print("Thumbnail loaded")
                        } else {
                            
                            print("Failed to load thumbnail")
                        }
                    }
                }
        }
            cell.imgVwUpload.layer.cornerRadius = 10
            cell.imgVwUpload.clipsToBounds = true
            cell.imgVwUpload.contentMode = .scaleAspectFill
            cell.btnCross.isHidden = false
            cell.btnCross.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
            cell.btnCross.tag = indexPath.row
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2-12, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if arrImages.count >= 5 {
//            showSwiftyAlert("", "You can only upload up to 5 images and videos.", false)
//            return
//        }else{
//                let data = arrImages[indexPath.row] as? String ?? ""
//                if data.contains(".MOV") == true{
//                    let videoURL = arrImages[indexPath.row]
//                    let url = URL(string: videoURL as? String ?? "")
//                    let player = AVPlayer(url: url!)
//                    let playerViewController = AVPlayerViewController()
//                    playerViewController.player = player
//                    self.present(playerViewController, animated: true) {
//                        playerViewController.player!.play()
//                    }
//                }else{
                    let data = arrImages[indexPath.row] as? String ?? ""
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
                    
                    if data.contains(".png") == true  {
                        vc.uploadImg = arrImages[indexPath.row] as? String ?? ""
                        
                    }else{
                        vc.uploadImg = arrImages[indexPath.row]
                        
                    }
                    
                    vc.modalPresentationStyle = .overFullScreen
                    self.navigationController?.present(vc, animated: true)
//                }
//        }
        
    }
    @objc func deleteImage(sender: UIButton) {
        if arrImages.count > 0{
            arrImages.remove(at: sender.tag)
        }
        clsnVwAddPhotos.reloadData()
    }
}

//MARK: - getWordAfterHash
extension SearchNoteVC{
    func getWordsAfterHash(from sentence: String) -> [String] {
        // Split the sentence by spaces
        let components = sentence.split(separator: " ")
        
        // Filter components that start with '#' and have letters after it
        let wordsAfterHash = components.filter {
            $0.hasPrefix("#") && $0.count > 1
        }
        .map { String($0.dropFirst()) } // Remove the '#' and keep the rest
        
        return wordsAfterHash
    }

}
