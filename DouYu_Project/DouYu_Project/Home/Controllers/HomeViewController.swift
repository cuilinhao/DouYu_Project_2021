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

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        self.tabBarItem.title = "主页"
        

		self.navigationController?.navigationBar.barTintColor =

			UIColor(red: 55/255, green: 186/255, blue: 89/255, alpha: 1)
		

		//修改导航栏文字颜色

		//self.navigationController?.navigationBar.titleTextAttributes =

			//[NSForegroundColorAttributeName: UIColor.white]
		
		self.navigationController?.navigationBar.setBackgroundImage(UIColor.systemGray.toImage(), for: .default)
		
		
    }
    
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let vc = DetailViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
    
    

}


