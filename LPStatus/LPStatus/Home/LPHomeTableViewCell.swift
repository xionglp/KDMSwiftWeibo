//
//  LPHomeTableViewCell.swift
//  LPStatus
//
//  Created by xlp on 2018/5/18.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit
import SDWebImage

class LPHomeTableViewCell: UITableViewCell {
    
    //MARK: -属性
    @IBOutlet weak var contentWCons: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: LPHomeStatusViewModel? {
        //监听属性的变化， 相当于oc中的重写setter方法
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconImageView.sd_setImage(with:nil, placeholderImage: UIImage(named: "avatar_default_small"))
            avatarImageView.image = viewModel.verifiedImage
            membersImageView.image = viewModel.vipImage
            nameLabel.text = viewModel.homeStatus?.statusUser?.screen_name
            dateLabel.text = viewModel.created_at_text
            sourceLabel.text = viewModel.sourceText
            contentLabel.text = viewModel.homeStatus?.text
            nameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentWCons.constant = UIScreen.main.bounds.width - (2 * 15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
