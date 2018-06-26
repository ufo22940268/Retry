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
    var record: RequestRecord!
    @IBOutlet weak var type: UILabel!
    
    override func viewDidLoad() {
        record = RealmUtil.get().objects(RequestRecord.self).first
        header.text = record.request?.header
        type.text = record.request?.parseField(field: "Content-Type")
    }
}
