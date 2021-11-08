//
//  TestAlamofire.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/8.
//

import UIKit
import Alamofire


private let testUrl = "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1636292154"
private let url = "https://httpbin.org/get"

struct Login : Encodable {
    let email : String
    let password : String
}


//let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
struct Game: Encodable {
    let limit: String
    let offset : String
    let time : String
}


class TestAlamofire {

    
    /**
     从 Alamofire 5 开始，此功能已被删除，被更改为 AF ，它是对 Session.default 的引用
     //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1636292154
     */
    
    func testRequest1() {
        /**
         success(Optional(9107 bytes))
         >>>>>>success(Optional(9107 bytes))
         >>>>>>>Optional(Optional(9107 bytes))
         >>>>>>Optional(9107 bytes)
         
        AF.request("http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1636292154").response { response in
            
            print(response)
            
            print(">>>>>>\(response.result)")
            print(">>>>>>>\(String(describing: response.value))")
            
            print(">>>>>>\(String(describing: response.data))")
        }
         */
        
        /*
         22>>>>>>success({
             args =     {
             };
             headers =     {
                 Accept = "11";
                 "Accept-Encoding" = "br;q=1.0, gzip;q=0.9, deflate;q=0.8";
                 "Accept-Language" = "en;q=1.0";
                 Host = "httpbin.org";
                 "User-Agent" = "DouYu_Project/1.0 (cuilinhao.com.cn.DouYu-Project; build:1; iOS 15.0.0) Alamofire/5.4.4";
                 "X-Amzn-Trace-Id" = "Root=1-6188824b-0dec2d176a9b53ee76ee439b";
             };
             origin = "39.144.44.95";
             url = "https://httpbin.org/get";
         })
         22>>>>>>>Optional({
             args =     {
             };
             headers =     {
                 Accept = "11";
                 "Accept-Encoding" = "br;q=1.0, gzip;q=0.9, deflate;q=0.8";
                 "Accept-Language" = "en;q=1.0";
                 Host = "httpbin.org";
                 "User-Agent" = "DouYu_Project/1.0 (cuilinhao.com.cn.DouYu-Project; build:1; iOS 15.0.0) Alamofire/5.4.4";
                 "X-Amzn-Trace-Id" = "Root=1-6188824b-0dec2d176a9b53ee76ee439b";
             };
             origin = "39.144.44.95";
             url = "https://httpbin.org/get";
         })
         22>>>>>>Optional(429 bytes)

        
        AF.request(url).responseJSON { response in
            print(response)

            print("22>>>>>>\(response.result)")
            print("22>>>>>>>\(String(describing: response.value))")

            print("22>>>>>>\(String(describing: response.data))")
        }
         */
        
        /**
         
         Alamofire 支持将任何Encodable类型作为请求的参数
         然后，这些参数通过遵循 ParameterEncoder 协议的类型传递，并添加到 URLRequest 中
         然后通过网络发送。Alamofire 包含两种遵循 ParameterEncoder 的类型：JSONParameterEncoder 和 URLEncodedFormParameterEncoder 。这些类型涵盖了现代服务使用的最常见的编码。
         链接：https://www.jianshu.com/p/4381fe8e10b6
         */
        
        //post 请求
        let login = Login(email: "test@test.test", password: "testPassword")

        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
            //debugPrint(response)
        }
        
        //get 请求
        
        let parameters = ["foo" : "bar"]

        // 下面三种方法都是等价的
        //// encoding defaults to `URLEncoding.default`
        AF.request("https://httpbin.org/get", parameters: parameters).responseJSON { response in
            //debugPrint(response)
        }
        
        AF.request("https://httpbin.org/get", parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            //debugPrint(response)
        }
        
        AF.request("https://httpbin.org/get", parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .methodDependent)).responseJSON { response in
            //debugPrint(response)
        }
        
        
        //---
        let parameters2 = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        AF.request(testUrl, parameters: parameters2, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            
            debugPrint(response)
            
            /*
             result>>>>>success({
                 data =     (
                             {
                         "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar_v3/202107/0489d0a1fa9e47e6a7e3024ed86e4847_middle.jpg";
             */
            print("result>>>>>\(response.result)")
            
            /*
             value>>>>>Optional({
                 data =     (
                             {
                         "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar_v3/202107/0489d0a1fa9e47e6a7e3024ed86e4847_middle.jpg";
             */
            //print("value>>>>>\(response.value)")
            
            /*
             data>>>>>Optional(9289 bytes)
             */
            print("data>>>>>\(response.data)")
            
            
            // 1.将result转成字典类型
            guard let resultDict = response.value as? [String : NSObject] else { return }

            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                //____dict:["show_status": 1, "cate_id": 311, "rmf2": 0, "push_ios": 1, "vertical_src": https://rpic.douyucdn.cn/live-cover/roomCover/2021/10/26/5f3cd9ee78136b366ac73c7df6fd7290_small.png, "nrt": 0, "room_src": https://rpic.douyucdn.cn/live-cover/roomCover/2021/10/26/5f3cd9ee78136b366ac73c7df6fd7290_big.png,
                print("____dict:\(dict)")
            }
            
        }  
    }
    
    
    
}

extension TestAlamofire {
    
//    func testImg {
//
//        let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg")
//        imageView.kf.setImage(with: url)
//
//    }
}
