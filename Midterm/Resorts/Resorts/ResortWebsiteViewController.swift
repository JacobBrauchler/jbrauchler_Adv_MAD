//
//  ResortWebsiteViewController.swift
//  Resorts
//
//  Created by Jacob Brauchler on 3/16/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class ResortWebsiteViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    var name = String()
    
    
    func configureView() {
        if name == "Aspen" {
            loadWebPage("https://www.aspensnowmass.com/")
            
        }
        if name == "Eldora" {
            loadWebPage("https://www.eldora.com/")
        }
        if name == "Steamboat" {
            loadWebPage("https://www.steamboat.com/")
            
        }
        if name == "Winter Park" {
            loadWebPage("https://www.winterparkresort.com/")
        }
    }
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url
        //creates a NSURL object
        let url = URL(string: urlString)
        //create a NSURLRequest object
        let request = URLRequest(url: url!)
        //load the NSURLRequest object in our web view
        webView.loadRequest(request)
    }
    
    //UIWebViewDelegate method that is called when a web page begins to load
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start load")
        webSpinner.startAnimating()
    }
    
    //UIWebViewDelegate method that is called when a web page loads successfully
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("stop load")
        webSpinner.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


