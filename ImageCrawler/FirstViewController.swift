//
//  FirstViewController.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/7.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import Kingfisher

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RequestImageCell
        cell.image.kf.setImage(with: URL(string: "https://assets.materialup.com/uploads/a21b79fc-ec9b-4365-93aa-26dc28de0593/teaser.png"))
        cell.layer.borderWidth = 10
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

