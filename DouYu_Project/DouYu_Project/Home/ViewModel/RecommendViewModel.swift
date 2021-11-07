//
//  RecommendViewModel.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit
import Alamofire

class RecommendViewModel {

	lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
	
	lazy var cycleModes : [CycleModel] = [CycleModel]()
	
	lazy var bigDataGroup : AnchorGroup = AnchorGroup()
	
	lazy var prettyGroup : AnchorGroup = AnchorGroup()
	
	
}


//MARK:- 请求数据
extension RecommendViewModel {
	
	//推荐数据
	func requestData(_ finishedCallBack: @escaping () -> ()) {
		
		let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
		
		
		let dGroup = DispatchGroup()
		
		dGroup.enter()
		
		print("_____\(Date.getCurrentTime())")
		//1636292154
		NetworkTools.requestData(.get, UrlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
			
			// 1.将result转成字典类型
			guard let resultDict = result as? [String : NSObject] else { return }
			
			// 2.根据data该key,获取数组
			guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
			
			//遍历字典，并转成模型对象
			self.bigDataGroup.tag_name = "热门"
			self.bigDataGroup.icon_name = "home_header_hot"
			
			for dict in dataArray {
				
				let anchor = AnchorModel(dict: dict)
				self.bigDataGroup.anchors.append(anchor)
			}
			
			dGroup.leave()
			
		}
	}
	
	
	
	
	//颜值数据
	
	
	//2- 12 部分游戏数据
	
	
	//无线轮播数据
	
	
	
}
