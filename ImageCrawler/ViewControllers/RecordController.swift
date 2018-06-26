//
//  RecordController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/20.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import RealmSwift

class RecordController: UITableViewController {

    var records: Results<RequestRecord>?
    
    let realm = RealmUtil.get()
    
    var token:NotificationToken?
    @IBOutlet var table: UITableView!
    
    func loadRecords() {
        records = realm.objects(RequestRecord.self).sorted(byKeyPath: "date", ascending: false)
        print("records count: \(records?.count)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecords()
        token = records!.observe { [weak self] changes in
            self?.loadRecords()
            self?.table.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = records?.count {
            return count
        }  else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "请求"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRecords()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "record", for: indexPath) as! RecordCell
        if let record = records?[indexPath.item] {
            //Set hostname
            if let firstLine = record.request?.header {
                cell.url.text = record.request?.parseHost()
            }
            
            //Set date
            let formatter = DateFormatter()
            formatter.dateFormat = "aaa hh:mm:ss"
            formatter.amSymbol = "上午"
            formatter.pmSymbol = "下午"
            cell.date.text = formatter.string(from:record.date!)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detail" {
            let detailController = segue.destination as! DetailController
            if let record = records?[table.indexPathForSelectedRow!.item]  {
                detailController.record = record
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    deinit {
        token?.invalidate()
    }
}
