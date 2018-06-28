//
//  RequestSegmentController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/25.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation

import UIKit
import SwiftDate

class RequestSegmentController: SegmentController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func updateViews() {
        header.text = self.record.request?.header
        type.text = self.record.request?.parseField(field: "Content-Type")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "body" {
            let bodyController = segue.destination as! HttpBodyController
            if let request = record.request {
                bodyController.bodyData = request.payload
                bodyController.setType(contentType: request.parseField(field: "Content-Type"))
            }
        }
    }
}
