//
//  HomeController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/21.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import RealmSwift

class HomeController: UITabBarController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    let realm = RealmUtil.get()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(HomeController.reset(sender:)))
        let copyItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(HomeController.copy(sender:)))
        
        navigationBar.rightBarButtonItems = [item, copyItem]
    }
    
    @objc func reset(sender: UINavigationItem) {
        try! realm.write {
            realm.deleteAll()
        }
        
    }
    
    @objc func copy(sender: UINavigationItem) {
        DebugUtil.copyRealm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
