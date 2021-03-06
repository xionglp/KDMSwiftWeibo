//
//  LPPicPickerCollectionViewCell.swift
//  LPStatus
//
//  Created by xlp on 2018/5/23.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

class LPPicPickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var selButton: UIButton!
    @IBOutlet weak var picImageView: UIImageView!
    var picImage: UIImage? {
        didSet{
            if picImage != nil {
                selButton.isUserInteractionEnabled = false
                picImageView.image = picImage
                delButton.isHidden = false
            }else{
                selButton.isUserInteractionEnabled = true
                picImageView.image = nil
                delButton.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func clickAddPicture(_ sender: Any) {
        //多层传递不适合用代理和闭包，可以用通知
        NotificationCenter.default.post(name: picPickerNotificationName, object: nil)
    }
    
    @IBAction func clickDelectPicture(_ sender: Any) {
        NotificationCenter.default.post(name: deletePictureNotificationName, object: picImage)
    }
}
