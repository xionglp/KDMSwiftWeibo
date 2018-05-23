//
//  LPPicPickerCollectionView.swift
//  LPStatus
//
//  Created by xlp on 2018/5/23.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

private let ID = "picPickerCellID"
private let margin: CGFloat = 15

class LPPicPickerCollectionView: UICollectionView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        register(UINib.init(nibName: "LPPicPickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ID)
        dataSource = self
        
        //设置collectionview item的大小
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.width - (4 * margin)) / 3
        layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        //设置collectionView的内边距
        self.contentInset = UIEdgeInsetsMake(margin, margin, 0, margin)
    }

}

extension LPPicPickerCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LPPicPickerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! LPPicPickerCollectionViewCell
        return cell
    }
}
