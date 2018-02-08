//
//  DetailViewController.swift
//  myDropIt
//
//  Created by Xibo Zhang on 17/4/9.
//  Copyright (c) 2017年 Xibo Zhang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var url:NSString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: self.url as String)
        let request = NSURLRequest(url: url! as URL)
        self.webView.loadRequest(request as URLRequest)
        self.webView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        NSLog("finish")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
