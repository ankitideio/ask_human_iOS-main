//
//  OpenGallaryAndCameraPopupVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 20/01/25.
//

import UIKit
import VisionKit

class OpenGallaryAndCameraPopupVC: UIViewController {
    @IBOutlet var btnExit: UIButton!
    @IBOutlet var btnTakePhoto: UIButton!
    @IBOutlet var btnGallery: UIButton!
    
    var callBack:((_ image:UIImage,_ gender:Int)->())?
    var viewModel = ProfileVM()
    var selectedIdType:Any?
    var selectedGender = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func actionGallary(_ sender: UIButton) {
        openImagePicker(sourceType: .photoLibrary)
    }
    @IBAction func actionCamera(_ sender: UIButton) {
        openDocumentScanner()
    }
    private func openDocumentScanner() {
            if VNDocumentCameraViewController.isSupported {
                let documentCameraViewController = VNDocumentCameraViewController()
                documentCameraViewController.delegate = self
                documentCameraViewController.view.tintColor = .app
                present(documentCameraViewController, animated: true, completion: nil)
            } else {
                // Handle the case where the device does not support scanning
                let alert = UIAlertController(title: "Not Supported",
                                              message: "This device does not support document scanning.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }

    @IBAction func actionExit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
extension OpenGallaryAndCameraPopupVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func openImagePicker(sourceType: UIImagePickerController.SourceType) {
           if UIImagePickerController.isSourceTypeAvailable(sourceType) {
               let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
               imagePicker.sourceType = sourceType
               imagePicker.allowsEditing = true // Allows user to crop/edit the selected image
               self.present(imagePicker, animated: true)
           }
            
       }

       // UIImagePickerControllerDelegate - Image Selected
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true)
           
           if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
               
                   viewModel.scanDocumentApi(document: selectedImage, type: selectedIdType as? Int) { gender in
                       self.callBack?(selectedImage,gender ?? 0)
                       self.dismiss(animated: true)
                       }
           }
       }

       // UIImagePickerControllerDelegate - Cancel Action
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true)
       }
}
// MARK: - VNDocumentCameraViewControllerDelegate
extension OpenGallaryAndCameraPopupVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true, completion: nil)
        if scan.pageCount > 0 {
            let scannedImage = scan.imageOfPage(at: 0)
            viewModel.scanDocumentApi(document: scannedImage, type: selectedIdType as? Int) { gender in
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdAuthenticatedVC") as! IdAuthenticatedVC
//                vc.callBack = { gedner in 
//                    self.callBack?(scannedImage,gender ?? 0)
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true, completion: nil)
        self.navigationController?.dismiss(animated: true)
        print("User canceled scanning.")
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true, completion: nil)
        self.navigationController?.dismiss(animated: true)
        print("Scanning failed with error: \(error.localizedDescription)")
    }
}
