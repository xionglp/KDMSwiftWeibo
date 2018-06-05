//
//  LPComposePublicController.swift
//  LPStatus
//
//  Created by xlp on 2018/5/22.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit
import SVProgressHUD

class LPComposePublicController: UIViewController {
    
    @IBOutlet weak var composeTextView: LPComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerHCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerCollectionView: LPPicPickerCollectionView!
    fileprivate lazy var composeTitleView: LPComposeTitleView = LPComposeTitleView()
    fileprivate lazy var picImages: [UIImage] = [UIImage]()
    fileprivate lazy var emoticonVc = KDMEmotionViewController.init { [weak self] (emoticon) in
        self?.composeTextView.insertEmoticon(emoticon: emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.becomeFirstResponder()
        setupNavigationItemStyle()
        composeTitleView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        self.navigationItem.titleView = composeTitleView
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextView代理方法
extension LPComposePublicController: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        composeTextView.placeholdelLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}

extension LPComposePublicController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker .dismiss(animated: true, completion: nil)
        picImages.append(image)
        picPickerCollectionView.picImages = picImages
    }
}

// MARK: -  点击事件
extension LPComposePublicController {
    @objc fileprivate func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    //发表微博
    @objc fileprivate func sendItemClick() {
        composeTextView.resignFirstResponder()
        //拿到textview输入的文字信息
        let statusText = composeTextView.getEmoticonString()
        print(statusText)
        
        //调用发布的接口
        if let image = picImages.first {
            LPNetworkingTools.shareInstance.requestSendStatus(statusText: statusText, image: image) { (isSuccess) in
                if !isSuccess {
                    SVProgressHUD.showError(withStatus: "发送微博失败")
                    return
                }
                SVProgressHUD.showSuccess(withStatus: "发送微博成功")
                self.dismiss(animated: true, completion: nil)
            }
            
        }else{
            LPNetworkingTools.shareInstance.requestSendStatus(statusText: statusText) { (isSuccess) in
                if !isSuccess {
                    SVProgressHUD.showError(withStatus: "发送微博失败")
                    return
                }
                SVProgressHUD.showSuccess(withStatus: "发送微博成功")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    //键盘通知
    @objc fileprivate func keyboardWillChangeFrame(note: NSNotification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        let margin = UIScreen.main.bounds.height - y
        toolBarBottomCons.constant = margin
        UIView .animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    //相册
    @objc fileprivate func picPickerImage() {
        //判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    
    //删除照片
    @objc fileprivate func deletePicture(noti: NSNotification){
        guard let image = noti.object as? UIImage else {
            return
        }
        //拿到图片在数组中的索引
        guard let index = picImages.index(of: image) else {
            return
        }
        picImages.remove(at: index)
        picPickerCollectionView.picImages = picImages
    }

    //选择照片
    @IBAction func clickSelPicture(_ sender: Any) {
        composeTextView .resignFirstResponder()
        picPickerHCons.constant = UIScreen.main.bounds.height * 0.7
    }
    
    //弹出表情键盘
    @IBAction func emoticonClick(_ sender: Any) {
        composeTextView.resignFirstResponder()
        composeTextView.inputView = composeTextView.inputView != nil ? nil : emoticonVc.view
        composeTextView.becomeFirstResponder()
    }
}

//MARK:- 自定义函数
extension LPComposePublicController {
    fileprivate func setupNotification(){
        //1.监听键盘通知
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChangeFrame),name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //2.相册选择照片通知
        NotificationCenter.default.addObserver(self, selector: #selector(picPickerImage), name: picPickerNotificationName, object: nil)
        //3.删除照片通知
        NotificationCenter.default.addObserver(self, selector: #selector(deletePicture), name: deletePictureNotificationName, object: nil)
    }
    
    //导航栏点击按钮
    fileprivate func setupNavigationItemStyle(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}



