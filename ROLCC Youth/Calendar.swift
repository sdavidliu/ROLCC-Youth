//
//  SecondViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Calendar: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        /*
        let url = NSURL (string: "http://www.rolccyouth.com/new-events/")
        let requestObj = NSURLRequest(URL: url!);
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        webView.loadRequest(requestObj)
        self.view.addSubview(webView)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

