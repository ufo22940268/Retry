//
//  SecondViewController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/7.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import Switch
import NetworkExtension
import NEKit
import CocoaLumberjackSwift

class SwitchViewController: UIViewController {

    @IBOutlet weak var `switch`: Switch!
    
    var targetManager:NEVPNManager = NEVPNManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var server:GCDHTTPProxyServer?
    var socks5Proxy:GCDSOCKS5ProxyServer?
    
    @IBAction func toggle(_ sender: Switch) {
    }
}

