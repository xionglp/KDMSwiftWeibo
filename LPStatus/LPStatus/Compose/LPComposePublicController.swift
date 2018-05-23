//
//  LPComposePublicController.swift
//  LPStatus
//
//  Created by xlp on 2018/5/22.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

class LPComposePublicController: UIViewController {
    
    @IBOutlet weak var composeTextView: LPComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerHCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerCollectionView: LPPicPickerCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItemStyle()
        self.title = "发微博"
        
        //监听键盘通知
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChangeFrame),name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //相册选择照片通知
        NotificationCenter.default.addObserver(self, selector: #selector(picPickerImage), name: picPickerNotificationName, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        composeTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        print(info)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //展示图片
    }
}

// MARK: -  点击事件
extension LPComposePublicController {
    @objc fileprivate func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    //发表微博
    @objc fileprivate func sendItemClick() {
        print("sendItemClick")
    }
    
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
    
    @objc fileprivate func picPickerImage() {
        //判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
        
    }
    
    @IBAction func clickSelPicture(_ sender: Any) {
        print("====")
        //显示collectionview
        //退出键盘
        composeTextView .resignFirstResponder()
        picPickerHCons.constant = UIScreen.main.bounds.height * 0.65
    }
}

extension LPComposePublicController {
    fileprivate func setupNavigationItemStyle(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.closeItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}



