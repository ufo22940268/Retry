//
//  HttpBodyController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/26.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import Highlightr

class HttpBodyController: UIViewController {

    @IBOutlet weak var body: UILabel!
    var bodyData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        body.text = bodyData
        if let text = formatJson() {
            body.attributedText = text
        }
    }
    
    
    func formatJson() -> NSAttributedString? {
        do {
            //Should format json data.
            let highlightr = Highlightr()
            
//            bodyData = bodyData.replacingOccurrences(of: "\\", with: "")
//            let d = bodyData.data(using: .utf8)
//            let obj = try JSONSerialization.jsonObject(with: d!, options: .allowFragments)
//            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//            let formattedString = String(bytes: jsonData, encoding: .utf8)
            return highlightr!.highlight(bodyData)
        } catch {
            print("data", bodyData)
            print("error", error.localizedDescription)
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
