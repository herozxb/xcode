//
//  ExampleViewController.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 16/5/16.
//  Copyright © 2016年 Egg Swift. All rights reserved.
//

import Foundation
import UIKit
//import DeepLearningKitForiOS

public class myViewController: UIViewController {
    
   
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: UIBarButtonItemStyle.plain, target: self, action: "nextTest:")
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let testViewController = storyboard.instantiateViewController(withIdentifier: "MyViewController")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    public func homePageAction() {
        //        let vc = WebViewController.instanceFromStoryBoard()
        //        vc.hidesBottomBarWhenPushed = true
        //        if let navigationController = navigationController {
        //            navigationController.pushViewController(vc, animated: true)
        //            return
        //        }
        //        present(vc, animated: true, completion: nil)
    }
    
    public func backAction() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func nextTest(sender: AnyObject) {

    }
    
}
