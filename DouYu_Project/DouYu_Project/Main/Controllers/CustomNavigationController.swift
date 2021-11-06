//
//  CustomNavigationController.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/6.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		//self.navigationController?.navigationBar.backgroundColor = UIColor(red: CGFloat(arc4random()), green: CGFloat(arc4random()), blue: CGFloat(arc4random()), alpha: 1.0)
		
//		self.navigationController?.navigationBar.backgroundColor = UIColor.randomColor()
//
//		self.navigationController?.navigationBar.setBackgroundImage(UIColor.systemGray.toImage(), for: .default)
//		self.navigationController?.navigationBar.barTintColor = UIColor (red:232/255.0, green:77/255.0, blue:122/255.0 ,alpha:1)
		
		configureNavi()
		
    }
    
	func configureNavi() {
		
		//获取系统手势
		guard let systemGes = interactivePopGestureRecognizer else {
			return
		}
		
		//获取手势添加到view中
		guard let gesView = systemGes.view else { return }
		
		
		//3. 获取target/action
		//利用运行时机制查看所有的属性名称
		var count: UInt32 = 0
		
		let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
		
		for i in 0..<count {
			let ivar = ivars[Int(i)]
			let name = ivar_getName(ivar)
			print(String(cString: name!) + "+++++")
		}
		
		let targets = systemGes.value(forKey: "_targets") as? [NSObject]
		guard let targetObj = targets?.first else { return }
		
		
		//取出target
		guard let target = targetObj.value(forKey: "target") else { return  }
		
		//取出Action
		let action  = Selector(("handleNavigationTransition:"))
		
		//创建自己的pan手势
		let panGes = UIPanGestureRecognizer()
		
		gesView.addGestureRecognizer(panGes)
		
		panGes.addTarget(target, action: action)
		
	}

	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		//隐藏push的控制器
		viewController.hidesBottomBarWhenPushed = true
		super.pushViewController(viewController, animated: animated)
	}
    

}
