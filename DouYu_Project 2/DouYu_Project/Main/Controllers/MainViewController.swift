//
//  MainViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        
        let homeVc = HomeViewController()
        
        let liveVc = LiveViewController()
        
        let fllowVC = FollowViewController()
        
        self.addChild(homeVc)
        self.addChild(liveVc)
        self.addChild(fllowVC)
        
        
        
    }
    


}
