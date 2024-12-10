//
//  VideoIdentificationVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/01/24.
//

import UIKit
import AVFoundation
import AVKit


class VideoIdentificationVC: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
//MARK: - OUTLETS
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var imgVwProfile: UIImageView!
    @IBOutlet var btnUpload: GradientButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet weak var vwVideo: UIView!
    
    let imagePickerController = UIImagePickerController()
    var remainingTime: Int = 15
    var timer: Timer?
    var videoURL: URL?
    var viewModel = VideoVerificationVM()
    var captureSession: AVCaptureSession!
    var videoOutput: AVCaptureMovieFileOutput!
    var status:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
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
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            lblTimer.textColor = .white
            lblTitleMessage.textColor = .white
        }else{
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            lblTimer.textColor = UIColor(hex: "#4C4C4C")
            lblTitleMessage.textColor = UIColor(hex: "#4C4C4C")
        }
        }
    
    
    func uiSet(){
        self.lblTimer.isHidden = false
        btnUpload.setTitle("Start Recording", for: .normal)
        btnStop.isHidden = true
        setupCaptureSession()
        setupPreviewLayer()
        startCaptureSession()
      
    }
  
    
    @objc func updateTimer() {
          if remainingTime > 0 {
              remainingTime -= 1
              lblTimer.text = "\(remainingTime) seconds"

          } else {
              self.btnStop.isHidden = true
              
              stopRecording()
            
          }
      }
    
    func startRecording(){
        remainingTime = 15
        btnUpload.isHidden = true
        lblTimer.isHidden = false
        lblTimer.text = "\(remainingTime) seconds"
        btnStop.isHidden = false
         btnStop.setTitle("Stop", for: .normal)
        
        let outputPath = NSTemporaryDirectory() + ".mov"
              let outputURL = URL(fileURLWithPath: outputPath)
     
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        videoOutput.startRecording(to: outputURL, recordingDelegate: self)
    }
    
    func stopRecording() {
        status = 1
        self.lblTimer.isHidden = true
        timer?.invalidate()
        self.btnUpload.isHidden = false
        self.btnStop.isHidden = false
        self.btnStop.setTitle("Retake", for: .normal)
        self.btnUpload.setTitle("Upload", for: .normal)
        stopCaptureSession()
        videoOutput.stopRecording()
      
       }

    func setupCaptureSession() {
        captureSession = AVCaptureSession()

        // Set up input (front camera)
        if let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
            let videoInput = try? AVCaptureDeviceInput(device: frontCamera) {
            captureSession.addInput(videoInput)
        }

        // Set up audio input
        if let audioDevice = AVCaptureDevice.default(for: .audio),
            let audioInput = try? AVCaptureDeviceInput(device: audioDevice) {
            if captureSession.canAddInput(audioInput) {
                captureSession.addInput(audioInput)
            }
        }

        // Set up output (e.g., movie file output)
        
        videoOutput = AVCaptureMovieFileOutput()
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
    }
     func setupPreviewLayer() {
         let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         previewLayer.videoGravity = .resizeAspectFill
         previewLayer.frame = vwVideo.layer.bounds
         vwVideo.layer.addSublayer(previewLayer)
     }
     
    func startCaptureSession() {
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
     
     func stopCaptureSession() {
         captureSession.stopRunning()
     }
   
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func actionViewVideo(_ sender: UIButton) {
     
        if let url = videoURL {
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        } else {
          
            print("Error: The video URL is nil.")
        }

    }
    @IBAction func actionUpload(_ sender: GradientButton) {
        if status == 0 {
          startRecording()

        } else {
            stopRecording()
            videoOutput.stopRecording()
            print("Upload----------")
            viewModel.uploadVideoVerificationApi(file: videoURL ?? URL(fileURLWithPath: "")) { message in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.message = message
                vc.callBack = {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "reviewVideoVC") as! reviewVideoVC
        //            vc.videoURL = outputFileURL
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                self.navigationController?.present(vc, animated: false)
               
            }
           
        }
    }
 
    
    @IBAction func actionStop(_ sender: UIButton) {
        if status == 1{
           
            setupCaptureSession()
            setupPreviewLayer()
            startCaptureSession()
            startRecording()
            status = 2
        }else{
            stopRecording()
//            remainingTime = 15
//            let outputPath = NSTemporaryDirectory() + ".mov"
//                  let outputURL = URL(fileURLWithPath: outputPath)
//         
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//            videoOutput.startRecording(to: outputURL, recordingDelegate: self)
//            btnStop.setTitle("Stop", for: .normal)
        
        }
        
      
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        SceneDelegate().notificationsRoot(selectTab: 2)
        
    }
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
          print("Start")
      }
      
      func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
          print(outputFileURL)
          videoURL = outputFileURL
          print(outputFileURL.dataRepresentation)
      }
}

