//
//  LPHomeTableViewCell.swift
//  LPStatus
//
//  Created by xlp on 2018/5/18.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit
import SDWebImage

private let mainMargin: CGFloat = 15
private let picMargin: CGFloat = 10
private let imageWH = (UIScreen.main.bounds.width - 2 * (mainMargin + picMargin)) / 3

class LPHomeTableViewCell: UITableViewCell {
    //MARK: -属性
    @IBOutlet weak var contentWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var BottomMarginCons: NSLayoutConstraint!
    @IBOutlet weak var picCollectionView: LPHomePicCollectionView!
    @IBOutlet weak var retweetTopCons: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetView: UIView!
    
    var viewModel: LPHomeStatusViewModel? {
        //监听属性的变化， 相当于oc中的重写setter方法
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconImageView .sd_setImage(with: viewModel.iconImageUrl! as URL, placeholderImage: UIImage(named: "avatar_default_small"))
            avatarImageView.image = viewModel.verifiedImage
            membersImageView.image = viewModel.vipImage
            nameLabel.text = viewModel.homeStatus?.statusUser?.screen_name
            dateLabel.text = viewModel.created_at_text
            sourceLabel.text = viewModel.sourceText
//            contentLabel.text = viewModel.homeStatus?.text
            let attribute = KDMFindEmoticon.shareIntance.findAttrString(statusText: viewModel.homeStatus?.text ?? "", font: contentLabel.font)
            contentLabel.attributedText = attribute
            nameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            //根据配图的个数动态计算picView的尺寸
            let picSize = calculatePicViewSize(count: viewModel.picUrls.count)
            picViewWCons.constant = picSize.width
            picViewHCons.constant = picSize.height
            BottomMarginCons.constant = viewModel.picUrls.count == 0 ? 1 : 15
            //设置配图数据
            picCollectionView.picurls = viewModel.picUrls
            
            //转发微博的正文
            if viewModel.homeStatus?.retweeted_status != nil {
                if let screenName = viewModel.homeStatus?.retweeted_status?.statusUser?.screen_name, let retweetText = viewModel.homeStatus?.retweeted_status?.text {
                    let retweetText : String = "@" + "\(screenName): " + retweetText
                    let attribute = KDMFindEmoticon.shareIntance.findAttrString(statusText: retweetText, font: retweetLabel.font)
                    retweetLabel.attributedText = attribute
                }else{
                    retweetLabel.text = nil
                }
                retweetTopCons.constant = 15
                picCollectionView.backgroundColor = UIColor.init(red: 250, green: 250, blue: 250, alpha: 0)
            }else{
                retweetLabel.text = nil
                retweetTopCons.constant = 0
                picCollectionView.backgroundColor = UIColor.white
            }
            
            //设置转发微博的背景
            retweetView.isHidden = viewModel.homeStatus?.retweeted_status != nil ? false : true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentWCons.constant = UIScreen.main.bounds.width  - (2 * mainMargin)
        
        //设置item的大小
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:imageWH, height:imageWH)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension LPHomeTableViewCell {
     fileprivate func calculatePicViewSize(count: Int) -> CGSize {
        //没有配图
        if count == 0 {
            return CGSize(width:0, height:0)
        }
        
        //四张配图 展示田字格
        if count == 4 {
            let picViewWH = imageWH * 2 + picMargin + 1
            return CGSize(width:picViewWH, height:picViewWH)
        }
        
        //其他张配图
        //计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        let picViewH = rows * imageWH + (rows - 1) * picMargin
        let picViewW = UIScreen.main.bounds.width - 2 * mainMargin
        return CGSize(width: picViewW, height: picViewH)
    }
}
