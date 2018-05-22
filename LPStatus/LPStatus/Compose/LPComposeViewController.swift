//
//  LPComposeViewController.swift
//  LPStatus
//
//  Created by xlp on 2018/5/22.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

class LPComposeViewController: UIViewController {
    
    @IBOutlet weak var composeTextView: LPComposeTextView!
    fileprivate lazy var titleView: UIView = UIView()
    fileprivate lazy var navView: LPComposeTitleView = LPComposeTitleView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposeViewController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposeViewController.closeItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
//        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
//        navigationItem.titleView = titleView
        self.title = "发微博"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        composeTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LPComposeViewController: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.composeTextView.placeholdelLabel.isHidden = textView.hasText
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}

extension LPComposeViewController {
    @objc fileprivate func closeItemClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendItemClick() {
        print("sendItemClick")
    }
}




