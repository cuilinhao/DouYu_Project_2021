//
//  CollectionGameCell.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/10.
//

import Foundation
import UIKit
//GameCellID

class CollectionGameCell:UICollectionViewCell {
    
    
	@IBOutlet weak var titleLab: UILabel!
	
	@IBOutlet weak var iconImagView: UIImageView!
	
	//MARK:- 定义模型属性
	//AnchorModel
	
	var baseGame: AnchorModel? {
		
		didSet {
			
			//https://apic.douyucdn.cn/upload/avatar_v3/202108/a989a9bc7ce74a009ebf26c1d07254de_small.jpg
			//
			titleLab.text = "nickname"
			
			let iconURL = URL(string: "https://apic.douyucdn.cn/upload/avatar_v3/202108/a989a9bc7ce74a009ebf26c1d07254de_small.jpg")!
			iconImagView.kf.setImage(with: iconURL, placeholder: UIImage(named: "aaa"))
			
		}
	}
	
	func updateUI() {
		
		titleLab.text = "nickname"
		
		let iconURL = URL(string: "https://apic.douyucdn.cn/upload/avatar_v3/202108/a989a9bc7ce74a009ebf26c1d07254de_small.jpg")!
		iconImagView.kf.setImage(with: iconURL, placeholder: UIImage(named: "aaa"))
		
	}
	
	

}


extension CollectionGameCell {
	
}
