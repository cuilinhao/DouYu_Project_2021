//
//  CycleModel.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class CycleModel: NSObject {

	@objc var title : String = ""
	
    @objc var pic_url : String = ""
	
    @objc var room: [String : NSObject]? {
		
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
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
	
	override func setValue(_ value: Any?, forUndefinedKey key: String) {
		
	}
	
	
}
