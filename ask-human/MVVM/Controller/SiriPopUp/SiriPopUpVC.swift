//
//  SiriPopUpVC.swift
//  ask-human
//
//  Created by Ideio Soft on 23/08/24.
//

import UIKit
import SwiftGifOrigin
import AVFoundation
import Speech

class SiriPopUpVC: UIViewController,SFSpeechRecognizerDelegate, AVAudioRecorderDelegate, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var imgVwSiri: UIImageView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-IN"))!
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var isRecording = false
    private var silenceTimer: Timer?
    
    private let silenceTimeout: TimeInterval = 5.0
    private let speechTimeout: TimeInterval = 3.0
    private var speachText:String = ""
    let speechSynthesizer = AVSpeechSynthesizer()
    var callBack:((_ voiceText:String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      uiSet()
        speechSynthesizer.delegate = self // Set the delegate

        let utterance = AVSpeechUtterance(string: "I am Ask Human how can I help you today?")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        speechSynthesizer.speak(utterance)
    }
    
    func uiSet() {
        if let gifImage = UIImage.gif(name: "siri") {
            imgVwSiri.image = gifImage
        } else {
            print("Failed to load GIF.")
        }
    }
    func requestSpeechRecognitionAuthorization(completion: @escaping () -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    completion()
                case .denied, .restricted, .notDetermined:
                    // Handle cases where the user denied or hasn't authorized speech recognition
                    print("Speech recognition authorization denied or restricted.")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    func startRecording() {
        if isRecording {
            stopRecording()
            return
        }

        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .default, options: .defaultToSpeaker)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else { return }
        recognitionRequest.shouldReportPartialResults = true
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio Engine couldn't start.")
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {

                self.speachText = result.bestTranscription.formattedString
                self.resetSilenceTimer(dueToSpeech: true) // Reset timer due to detected speech
            } else if let error = error {
                print("Error during speech recognition: \(error.localizedDescription)")
                self.stopRecording()
            }
        }
        
        isRecording = true
        resetSilenceTimer(dueToSpeech: false) // Start the timer with silence timeout initially
    }

    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        silenceTimer?.invalidate()
        isRecording = false
    }

    func resetSilenceTimer(dueToSpeech: Bool) {
        silenceTimer?.invalidate()
        let timeout = dueToSpeech ? speechTimeout : silenceTimeout
        silenceTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { _ in
            self.stopRecording()
            print("Stopped recording due to silence.")
            self.callBack?(self.speachText)
            
            self.dismiss(animated: true)
           
        }
    }

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        // Handle changes in speech recognizer availability
    }

    // MARK: - AVSpeechSynthesizerDelegate

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Start recording after the speech has finished
        requestSpeechRecognitionAuthorization {
            self.startRecording()
        }
    }
}
