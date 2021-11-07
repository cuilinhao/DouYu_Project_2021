//
//  CycleModel.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class CycleModel: NSObject {

	var title : String = ""
	
	var pic_url : String = ""
	
	var room: [String : NSObject]? {
		
		didSet {
			
			guard let room = room else { return }
			anchor = AnchorModel(dict: room)
		}
	}
	
	//主播信息对应的模型对象
	var anchor: AnchorModel?
	
	init(dict : [String : NSObject]) {
		
		super.init()
		setValuesForKeys(dict)
	}
	
	override func setValue(_ value: Any?, forUndefinedKey key: String) {
		
	}
	
	
}
