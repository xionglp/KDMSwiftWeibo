//
//  LPHomePicCollectionView.swift
//  LPStatus
//
//  Created by xlp on 2018/5/19.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

class LPHomePicCollectionView: UICollectionView {
    
    var picurls: [NSURL]! {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }
}


extension LPHomePicCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picurls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCollectionViewCell", for: indexPath) as! LPHomePicCollectionViewCell
        cell.imageUrl = picurls[indexPath.row]
        return cell
    }
}

class LPHomePicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    
    var imageUrl: NSURL? {
        didSet{
            guard let imageUrl = imageUrl  else {
                return
            }
            picImageView .sd_setImage(with: imageUrl as URL, placeholderImage: UIImage(named:"empty_picture"))
        }
    }
}
