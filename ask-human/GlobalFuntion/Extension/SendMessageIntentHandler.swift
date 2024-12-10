//
//  SendMessageIntentHandler.swift
//  ask-human
//
//  Created by Ideio Soft on 28/08/24.
//
//
import Foundation
import Intents

class SendMessageIntentHandler: NSObject, INSendMessageIntentHandling {
    func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        let success = Bool.random() // Randomly set success for testing

        if success {
            print("Handling success case")
            Store.openUrl = "Success"
            let response = INSendMessageIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("Handling failure case")
            Store.openUrl = "Failure"
            let response = INSendMessageIntentResponse(code: .failure, userActivity: nil)
            completion(response)
        }
    }
}




