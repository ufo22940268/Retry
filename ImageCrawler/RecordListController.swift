//
//  FirstViewController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/7.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import NetworkExtension
import RealmSwift

class RecordListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var records: Results<RequestRecord>?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = records?.count {
            return count
        }  else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RequestCell
        let record = records?[indexPath.item]
        cell.url.text = record?.headers.first
        cell.layer.borderWidth = 10
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        records = realm.objects(RequestRecord.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

