//
//  WebViewVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 10/07/24.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    @IBOutlet var webView: WKWebView!
    var url = ""
    var callback:((_ message:String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
    }

    func uiSet() {
        guard let url = URL(string: url) else {
            print("Invalid URL string.")
            return
        }
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
        
    }

}

extension WebViewVC: WKNavigationDelegate {
    // MARK: - WKNavigationDelegate Methods
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        print("decidePolicyFor - url: \(url)")
        if url == URL(string: "https://api.askhuman.ai/cancel"){
            self.navigationController?.popViewController(animated: true)
            fetchURLResponse(url: url)
         
            decisionHandler(.cancel)
            
        }else if url == URL(string: "https://api.askhuman.ai/success"){
            self.navigationController?.popViewController(animated: true)
            fetchURLResponse(url: url)
          
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
        
    }
    private func fetchURLResponse(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching URL response: \(error.localizedDescription)")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                if let message = self.extractMessage(from: responseString) {
                  
                    self.callback?(message)
                } else {
                    print("")
                }
            }
        }
        task.resume()
    }

    private func extractMessage(from htmlString: String) -> String? {
        // Use a simple HTML parsing to extract the message within the <h1> tag
        let pattern = "<h1>(.*?)</h1>"
        if let range = htmlString.range(of: pattern, options: .regularExpression) {
            let message = htmlString[range]
            let cleanMessage = message.replacingOccurrences(of: "<h1>", with: "").replacingOccurrences(of: "</h1>", with: "")
            return cleanMessage
        }
        return nil
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation - webView.url: \(String(describing: webView.url?.description))")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let nserror = error as NSError
        if nserror.code != NSURLErrorCancelled {
            webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish - webView.url: \(String(describing: webView.url?.description))")
    }
}
