//
//  DocumentScannerVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 24/12/24.
//

import UIKit
import VisionKit

class DocumentScannerVC: UIViewController, VNDocumentCameraViewControllerDelegate {

    @IBOutlet var viewCamera: UIView!
    @IBOutlet var imgVwDocuments: UIImageView!
    
    var callBack: ((_ image: UIImage) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDocumentScanner()
    }

    private func openDocumentScanner() {
            if VNDocumentCameraViewController.isSupported {
                let documentCameraViewController = VNDocumentCameraViewController()
                documentCameraViewController.delegate = self
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
    
    // MARK: - Button Actions
    @IBAction func actionUpload(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - VNDocumentCameraViewControllerDelegate
       
       func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
           controller.dismiss(animated: true, completion: nil)
           // Process the scanned documents
           for pageIndex in 0..<scan.pageCount {
               let scannedImage = scan.imageOfPage(at: pageIndex)
               // Use the scannedImage as needed
               print("Scanned Image: \(scannedImage)")
           }
       }
       
       func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
           controller.dismiss(animated: true, completion: nil)
           print("User canceled scanning.")
       }
       
       func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
           controller.dismiss(animated: true, completion: nil)
           print("Scanning failed with error: \(error.localizedDescription)")
       }
}
