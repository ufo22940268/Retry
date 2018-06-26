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
 
    override func updateViews() {
        print("update in summary")
        let dateString = DateInRegion(absoluteDate: self.record.date!).string(dateStyle: .medium, timeStyle: .medium)
        date.text = dateString
        tableView.reloadData()
    }
}
