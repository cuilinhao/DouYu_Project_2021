//
//  NetworkTools.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit
import Alamofire

enum MethodType {
	case get
	case post
}

struct NetworkTools : Encodable {

	static func requestData(_ type: MethodType, UrlString: String, parameters: [String : Any]? = nil, finishedCallBack: @escaping (_ result : Any) -> ()) {
		
		let method = type == .get ? HTTPMethod.get : HTTPMethod.post

		AF.request(UrlString, method: method, parameters: parameters, encoding: JSONParameterEncoder.default as! ParameterEncoding).responseJSON { response in
			
//			guard let result = response.result else {
//				return
//			}
			print(response.result)
			finishedCallBack(response.result)
			
		}
		
		
	}
	
	
}
