//
//  SwitcherController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/26.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import Switch

class SwitcherController: UIViewController {
    
    var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSwitchChanged(_ sender: Switch) {
        let off = sender.rightSelected
        if off {
            networkManager.stop()
        } else {
            networkManager.restart()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
