//
//  BaseGameModel.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class BaseGameModel: NSObject {

	// MARK:- 定义属性
	@objc var tag_name : String = ""
    @objc var icon_url : String = ""
	
	// MARK:- 自定义构造函数
	override init() {
		
	}
	
	init(dict : [String : Any]) {
		super.init()
		
		setValuesForKeys(dict)
	}
	
    override func setValue(_ value: Any?, forKey key: String) {
        
        super.setValue(value, forKey: key)
        print(" test no key:\(key)")
    }
    
    override  func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("no key:\(key)")
    }
    
	//override func setValue(_ value: Any?, forUndefinedKey key: String) {}
	
}
