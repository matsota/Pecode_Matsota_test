//
//  WebViewViewController.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import WebKit

class WebViewViewController: UIViewController, Storyboarding {
    
    //MARK: - Implementation
    public var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        self.view.insertSubview(webView, at: 0)
    }
    
}
