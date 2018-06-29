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
    var bodyType: BodyType!
    
    enum BodyType {
        case json, text, image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var text:NSAttributedString?
        switch bodyType {
        case .json:
            text = formatJson()
        default:
            text = NSAttributedString(string: bodyData ?? "")
        }
        
        if let text = text {
            body.attributedText = text
        }
    }
    
    func setType(contentType: String) {
        if contentType.contains("json") {
            bodyType = .json
        } else {
            
        }
    }
    
    
    func formatJson() -> NSAttributedString? {
        do {
            //Should format json data.
            let highlightr = Highlightr()
            highlightr?.setTheme(to: "solarized-light")
            
//            bodyData = bodyData.replacingOccurrences(o`f: "\\", with: "")
            let d = bodyData.data(using: .utf8)
            let obj = try JSONSerialization.jsonObject(with: d!, options: .allowFragments)
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            let formattedString = String(bytes: jsonData, encoding: .utf8)
            print("formattedString", formattedString)
            
            return highlightr!.highlight(formattedString!)
        } catch {
            print("data", bodyData)
            print("error", error.localizedDescription)
        }
        
        return NSAttributedString(string:self.bodyData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
