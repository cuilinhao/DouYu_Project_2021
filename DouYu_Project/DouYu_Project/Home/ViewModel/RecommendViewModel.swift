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

//1636354986
//http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1636354986
extension RecommendViewModel {
    
    func test() {
        
        NetworkTools.requestGETData(.get, UrlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { result in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                
                print("_____error___")
                return
            }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                print("123")
                return
            }
            
            print(">>>>>>>\(dataArray)")
            
        }
        
    }
    
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
        
		NetworkTools.requestGETData(.get, UrlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
			
			// 1.将result转成字典类型
			guard let resultDict = result as? [String : NSObject] else { return }
			
			// 2.根据data该key,获取数组
			guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                print("123")
                return
            }
			
			//遍历字典，并转成模型对象
			self.bigDataGroup.tag_name = "热门"
			self.bigDataGroup.icon_name = "home_header_hot"
			
			for dict in dataArray {
				
				let anchor = AnchorModel(dict: dict)
				self.bigDataGroup.anchors.append(anchor)
			}
            
            print("____第一部分:\(self.bigDataGroup.anchors)")
			dGroup.leave()
		}
        
        //颜值数据
        dGroup.enter()
        NetworkTools.requestGETData(.get, UrlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { result in
            
            //将rusult 转成字典
            guard let resultDic = result as? [String : NSObject] else { return }
            //获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            print("____颜值:\(self.prettyGroup.anchors)")
            dGroup.leave()
        }
        
        //2- 12 部分游戏数据
        
        dGroup.enter()
        NetworkTools.requestGETData(.get, UrlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { result in
            
            guard let  resultDic = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            print("____游戏:\(self.anchorGroups)")
            dGroup.leave()
        }
        
        
        dGroup.notify(queue: .main) {
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
         
            print("___total:\(self.anchorGroups)")
            finishedCallBack()
        }
	}

    //无线轮播数据
    func requestCycleData(finishCallBack : @escaping () -> ()) {
        
        NetworkTools.requestGETData(.get, UrlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { result in
            
            guard let  resultDic = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //字典转模型
            for dict  in dataArray  {
                self.cycleModes.append(CycleModel(dict: dict))
            }
            
            finishCallBack()
        }
        
    }
    
   
    
}
