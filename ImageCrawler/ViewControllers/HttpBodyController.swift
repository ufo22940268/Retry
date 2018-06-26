//
//  HttpBodyController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/26.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit

class HttpBodyController: UIViewController {

    @IBOutlet weak var body: UILabel!
    var bodyData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        body.text = bodyData
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
