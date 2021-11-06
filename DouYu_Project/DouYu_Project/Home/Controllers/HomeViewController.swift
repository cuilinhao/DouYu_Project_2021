//
//  HomeViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

	
        view.backgroundColor = .white
        self.tabBarItem.title = "主页"
		self.navigationController?.navigationBar.barTintColor =
			UIColor(red: 55/255, green: 186/255, blue: 89/255, alpha: 1)
		//修改导航栏文字颜色
		//self.navigationController?.navigationBar.titleTextAttributes =
			//[NSForegroundColorAttributeName: UIColor.white]
		self.navigationController?.navigationBar.setBackgroundImage(UIColor.systemGray.toImage(), for: .default)
		
		self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
		
		configureNavigaiton()
    }
    
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = DetailViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
    
}


//MARK:- initUI
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
	}
	
}

