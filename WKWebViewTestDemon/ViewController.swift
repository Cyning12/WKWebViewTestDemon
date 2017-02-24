//
//  ViewController.swift
//  WKWebViewTestDemon
//
//  Created by 刘新宁 on 2017/2/23.
//  Copyright © 2017年 刘新宁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func gotoWeb(_ sender: UIButton) {
        let webViewController = UIStoryboard.init(name: "RouteWebViewController", bundle: nil).instantiateInitialViewController()
        let navgationController = UINavigationController.init(rootViewController: webViewController!)
        self.present(navgationController, animated: true, completion: nil)
    }
}

