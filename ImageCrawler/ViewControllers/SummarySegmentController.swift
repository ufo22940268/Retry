    //
//  SummarySegmentController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/25.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

class SummarySegmentController: SegmentController {
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var responseSize: UILabel!
    @IBOutlet weak var requestSize: UILabel!
    
    override func updateViews() {
        print("update in summary")
        let dateString = DateInRegion(absoluteDate: self.record.date!).string(dateStyle: .medium, timeStyle: .medium)
        date.text = dateString
        
        if let request = self.record.request {
            requestSize.text = formatByteCount(size: request.size)
        }
        
        if let response = self.record.response {
            responseSize.text = formatByteCount(size: response.size)
        }

        
        tableView.reloadData()
    }
    
    
    func formatByteCount(size: Int) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB, .useMB, .useBytes]
        return bcf.string(fromByteCount: Int64(size))
    }
}
