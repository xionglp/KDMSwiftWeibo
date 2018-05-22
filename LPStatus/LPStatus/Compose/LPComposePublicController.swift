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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LPComposePublicController.closeItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false

        self.title = "发微博"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        composeTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LPComposePublicController: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.composeTextView.placeholdelLabel.isHidden = textView.hasText
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}

extension LPComposePublicController {
    @objc fileprivate func closeItemClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendItemClick() {
        print("sendItemClick")
    }
}

//class LPComposePublicController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

