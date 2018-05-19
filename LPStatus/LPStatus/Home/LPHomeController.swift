//
//  LPHomeController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/14.
//  Copyright © 2016年 xlp. All rights reserved.
//  首页控制器

//  加载微博的图片， 先获取数据， 将数据保存在一个组数中【NSURL】
//  计算picView，collectionView的尺寸， 添加collectionViewCell并附上相应的数据

import UIKit

 class LPHomeController: LPBaseVisitorController{

    let cellID : String = "HomeCell"
    
    @IBOutlet weak var homeTableView: UITableView!
    //MARK: - 懒加载
    fileprivate lazy var naviTitleBtn : LPNaviCustomTItleButton = LPNaviCustomTItleButton()
    fileprivate lazy var popoverVc : LPPopoverController = LPPopoverController()
    fileprivate lazy var statusArr : [LPHomeStatusViewModel] = [LPHomeStatusViewModel]()

    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            return
        }
        setupCustomNavigationBarItem() //自定义导航栏按钮
        requestStatuesData() //请求首页数据
    
        self.automaticallyAdjustsScrollViewInsets = false
        homeTableView.estimatedRowHeight = 500 //估计高度
        homeTableView.rowHeight = UITableViewAutomaticDimension //自动计算
    }
}

// MARK: - 请求数据
extension LPHomeController{
    fileprivate func requestStatuesData(){
        // 1. 显示请求微博数据
        // 2. 将json数据转成模型对象
        // 3. 模型对象的时间和来源属性处理
        
        guard let accessToken = LPUserAccountViewModel.shareInstance.account?.access_token else {
            return
        }
        
        LPNetworkingTools.shareInstance.requestHomeStatuesData(accessToken: accessToken) { (resultData, errorData) in
            guard let requestData = resultData else {
                return
            }
            //请求数据处理， 将后台获取的json数据转换成模型数据
            for statusDict in requestData {
                let status = LPHomeStatues(dict: statusDict)
                let statusViewModel = LPHomeStatusViewModel(homeStatus: status)
                self.statusArr.append(statusViewModel)
            }
            self.homeTableView.reloadData()
        }
    }
}

// MARK: - 代理方法
extension LPHomeController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 定义一个cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)! as! LPHomeTableViewCell
        cell.viewModel = self.statusArr[indexPath.row]
        return cell
    }
    
}

// MARK: - 自定义UI界面
extension LPHomeController{
    // 设置自定义导航栏的Item
    fileprivate func setupCustomNavigationBarItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(inageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(inageName: "navigationbar_pop")
        naviTitleBtn .setTitle("coder_xlp", for: .normal)
        naviTitleBtn .addTarget(self, action: #selector(LPHomeController.clickNaviTitleButton(titleBtn:)), for: .touchUpInside)
        navigationItem.titleView = naviTitleBtn
    }
}

// MARK: - 事件监听函数
extension LPHomeController {
    @objc fileprivate func clickNaviTitleButton(titleBtn:LPNaviCustomTItleButton){
        titleBtn.isSelected = !titleBtn.isSelected
        popoverVc.modalPresentationStyle = .custom
        popoverVc.transitioningDelegate = self
        present(popoverVc, animated: true, completion: nil)
        
    }
}

// MARK: - 代理方法
extension LPHomeController : UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return LPPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


