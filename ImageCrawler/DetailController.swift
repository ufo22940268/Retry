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
    var activeSegment = SummarySegment()

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

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return activeSegment.tableView(tableView, cellForRowAt: indexPath)
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return activeSegment.numberOfSections(in:tableView)
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
}


class SummarySegment: TableSegment {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! DetailInfoCell
        cell.key.text = "jijij"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
