//
//  AnchorModel.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class AnchorModel: NSObject {

	/// 房间ID
	@objc var room_id : Int = 0
	/// 房间图片对应的URLString
    @objc var vertical_src : String = ""
	/// 判断是手机直播还是电脑直播
	// 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    @objc var isVertical : Int = 0
	/// 房间名称
    @objc var room_name : String = ""
	/// 主播昵称
    @objc var nickname : String = ""
	/// 观看人数
    @objc var online : Int = 0
	/// 所在城市
    @objc var anchor_city : String = ""
	
	  init(dict: [String : Any]) {
		super.init()
          
          print("____model:\(dict)")

          setValuesForKeys(dict)
	}


    
    override func setValue(_ value: Any?, forKey key: String) {
        //MARK:这句话很关键,一定要有 :解决setValuesForKeys解析数据没有值的问题
        //xcode升级到4.0以后发现系统方法改为了 setValuesForKeys,运行发现数据解析成功,但是转model的时候发现没有值
        //https://blog.csdn.net/chenqiangblock/article/details/80302449?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_title~default-0.essearch_pc_relevant&spm=1001.2101.3001.4242.1
        super.setValue(value, forKey: key)
        print(" test no key:\(key)")
    }
    
    override  func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("no key:\(key)")
    }
	
}
