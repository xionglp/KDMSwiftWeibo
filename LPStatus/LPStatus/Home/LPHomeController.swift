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
import SDWebImage
import MJRefresh

 class LPHomeController: LPBaseVisitorController{

    let cellID : String = "HomeCell"
    
    @IBOutlet weak var homeTableView: UITableView!
    //MARK: - 懒加载
    fileprivate lazy var naviTitleBtn : LPNaviCustomTItleButton = LPNaviCustomTItleButton()
    fileprivate lazy var popoverVc : LPPopoverController = LPPopoverController()
    fileprivate lazy var statusArr : [LPHomeStatusViewModel] = [LPHomeStatusViewModel]()
    fileprivate lazy var tipLabel: UILabel = UILabel()

    // MARK: - 系统回调函数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            return
        }
        setupCustomNavigationBarItem() //自定义导航栏按钮
        
        self.automaticallyAdjustsScrollViewInsets = false
        homeTableView.estimatedRowHeight = 500 //估计高度
        homeTableView.rowHeight = UITableViewAutomaticDimension //自动计算
        
        //添加下拉刷新控件
        setupRefreshHeaderView()
        setupRefreshFooterView()
        setupTipLabel()
    }
}

// MARK: - 请求数据
extension LPHomeController{
    fileprivate func requestStatuesData(loadNewData: Bool){
        
        // 获取since_id/max_id, 加载最新数据和更多数据要用到
        var since_id = 0
        var max_id = 0
        if loadNewData {
            since_id = statusArr.first?.homeStatus?.mid ?? 0
        } else {
            max_id = statusArr.last?.homeStatus?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }

        guard let accessToken = LPUserAccountViewModel.shareInstance.account?.access_token else {
            return
        }
        
        LPNetworkingTools.shareInstance.requestHomeStatuesData(accessToken: accessToken, since_id: since_id, max_id: max_id) { (resultData, error) in

            self.homeTableView.mj_header.endRefreshing()
            self.homeTableView.mj_footer.endRefreshing()
            guard let requestData = resultData else {
                return
            }
            var tempStatus: [LPHomeStatusViewModel] = [LPHomeStatusViewModel]()
            for statusDict in requestData {
                let status = LPHomeStatues(dict: statusDict)
                let statusViewModel = LPHomeStatusViewModel(homeStatus: status)
                tempStatus.append(statusViewModel)
            }
            
            if loadNewData {
                self.statusArr = tempStatus + self.statusArr
            }else {
                self.statusArr += tempStatus
            }
            
            //显示顶部提示框
            self.showTipLabel(count: tempStatus.count)
            self.homeTableView.reloadData()
        }
    }
    
    fileprivate func showTipLabel(count :Int){
        tipLabel.isHidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "\(count)条新数据"
        UIView .animate(withDuration: 1.0, animations: {
            self.tipLabel.transform = CGAffineTransform.init(translationX: 0, y: 35)
        }) { (_) in
            UIView .animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                self.tipLabel.transform = CGAffineTransform.identity
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
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
    
    fileprivate func setupRefreshHeaderView(){
        guard let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(LPHomeController.loadNewStatuses)) else {
            return
        }
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放更新", for: .pulling)
        header.setTitle("加载中...", for: .refreshing)
        homeTableView.mj_header = header
        homeTableView.mj_header.beginRefreshing()
    }
    
    fileprivate func setupRefreshFooterView(){
        guard let footer = MJRefreshAutoFooter.init(refreshingTarget: self, refreshingAction: #selector(LPHomeController.loadMoreStatues)) else {
            return
        }
        homeTableView.mj_footer = footer
    }
    
    fileprivate func setupTipLabel(){
        navigationController?.view .insertSubview(tipLabel, belowSubview: (navigationController?.navigationBar)!)
        tipLabel.frame = CGRect.init(x: 0, y: 64 - 35, width: UIScreen.main.bounds.width, height: 35)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = NSTextAlignment.center
        tipLabel.isHidden = true
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
    
    @objc fileprivate func loadNewStatuses(){
        requestStatuesData(loadNewData: true)
    }
    
    @objc fileprivate func loadMoreStatues(){
        requestStatuesData(loadNewData: false)
    }
}

// MARK: - 代理方法
extension LPHomeController : UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return LPPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


