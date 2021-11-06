//
//  HomeViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
	
	fileprivate lazy var pageTitleView: PageTitleView = { [weak self] in
		
		let titles = ["推荐", "游戏","娱乐", "去玩","魔兽","三元","chinaJoy","西游记"]
		let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH - 44, width: kScreenH, height:40)
		let titleView = PageTitleView(frame: titleFrame, titles: titles)
		
		//设置代理
		titleView.delegate = self
		
		return titleView
	}()
	
	lazy var pageContentView: PageContentView = {
		
		let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
		let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH - 44, width: kScreenW, height: contentH)
		
		var childVcs = [UIViewController]()
		childVcs.append(RecommendViewController())
		childVcs.append(GameViewController())
		childVcs.append(AmuseViewController())
		childVcs.append(FunnyViewController())
		
		
		let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
		
		contentView.delegate = self
		
		return contentView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
		initUI()
    }
    
}


//MARK:- initUI
extension HomeViewController {
	
	func initUI() {
		
		configureNavigaiton()
		
		view.addSubview(pageTitleView)
		view.addSubview(pageContentView)
		
	}
}

extension HomeViewController {
	
	func configureNavigaiton()  {
		
		//设置左侧item
		navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
		
		//设置右侧item
		let size = CGSize(width: 40, height: 40)
		let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
		let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
		let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
		
		navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
		
		//有作用
		navigationController?.navigationBar.backgroundColor = UIColor.lightGray
		//navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
		//self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
		
	}
	
}

extension HomeViewController: PageTitleViewDelegate {
	
	func pagetitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
		
		print("___pagetitle Delegate")
		pageContentView.setCurrentIndex(index)
		
	}
}

extension HomeViewController: PageContentViewDelegate {
	func pageContent(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
		
		print("___pageContent Delegate")
		
		pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targeIndex: targetIndex)
	}
}

//MARK:- Action
extension HomeViewController {
	
	func test()  {
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = DetailViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}

