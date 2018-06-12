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

class SwitchViewController: UIViewController {

    @IBOutlet weak var `switch`: Switch!
    
    var targetManager:NEVPNManager = NEVPNManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTarget()
    }
    
    fileprivate func createTarget() {
        let newManager = NETunnelProviderManager()
        newManager.protocolConfiguration = NETunnelProviderProtocol()
        newManager.localizedDescription = "ImageCrawler"
        newManager.protocolConfiguration?.serverAddress="192.168.20.130:7888"
        newManager.isEnabled = true
        newManager.saveToPreferences { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                newManager.loadFromPreferences(completionHandler: {(error: Error?) -> Void in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        self.targetManager = newManager
                    }
                })
            }
        }
    }
    
    func setupTarget() {
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) in
            if managers!.count > 0 {
                print("have config")
                self.targetManager = managers!.first!
            } else {
                print("add config")
                self.createTarget()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggle(_ sender: Switch) {
        let isOff = sender.rightSelected
        print(targetManager.connection.status.rawValue)
        print((targetManager.localizedDescription)!)
        print("protocal", targetManager.protocolConfiguration!)
        if !isOff {
            do {
                try targetManager.connection.startVPNTunnel()
            } catch {
                print(error.localizedDescription)
            }
        } else{
            targetManager.connection.stopVPNTunnel()
        }
    }
}

