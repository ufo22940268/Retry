//
//  DetailController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/21.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import RealmSwift

class DetailController: UIViewController {
    
    var record: RequestRecord?

    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var requestView: UIView!
    var segmentViews: [UIView]!
    
    @IBAction func onSegmentChanged(_ sender: UISegmentedControl) {
        for i in 0..<sender.numberOfSegments {
            if i == sender.selectedSegmentIndex {
                segmentViews[i].isHidden = false
            } else {
                segmentViews[i].isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentViews = [summaryView, requestView]
    }
}


