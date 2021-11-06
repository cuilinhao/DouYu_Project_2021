//
//  HomeViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
	
	fileprivate lazy var pageTitleView: PageTitleView = {
		
		let titles = ["推荐", "游戏","娱乐", "去玩","魔兽","三元","chinaJoy","西游记"]
		let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH - 44, width: kScreenH, height:40)
		let titleView = PageTitleView(frame: titleFrame, titles: titles)
		
		//codeTest
		//titleView.backgroundColor = .systemRed
		
		return titleView
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


//MARK:- Action
extension HomeViewController {
	
	func test()  {
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = DetailViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}

