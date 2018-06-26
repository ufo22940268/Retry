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

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var responseView: UIView!
    var segmentViews: [UIView]!
    
    var segmentControllers: [String: SegmentController]! = [String:SegmentController]()
    
    fileprivate func selectSegment(_ sender: UISegmentedControl) {
        for i in 0..<sender.numberOfSegments {
            if i == sender.selectedSegmentIndex {
                segmentViews[i].isHidden = false
            } else {
                segmentViews[i].isHidden = true
            }
        }
    }
    
    @IBAction func onSegmentChanged(_ sender: UISegmentedControl) {
        selectSegment(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentViews = [summaryView, requestView, responseView]
        
        
        for (_, value) in segmentControllers {
            value.record = record
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SegmentController
        segmentControllers[segue.identifier!] = vc
    }
}
