//
//  CollectionNormalCell.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    
    
    
	//背景图片
	lazy var bgImg: UIImageView = {
		let iconImg = UIImageView()
		iconImg.contentMode = .scaleAspectFit
		//Img_default
		iconImg.image = UIImage(named: "aaa")
		return iconImg
	}()
	

	//在线人数
	lazy var onlineLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 15)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		titleLabel.text = "6666在线"
		
		return titleLabel
	}()
	
	//小视频图标
	lazy var iconImg: UIImageView = {
		let iconImg = UIImageView()
		iconImg.contentMode = .scaleAspectFit
		iconImg.image = UIImage(named: "home_live_cate_normal")
		return iconImg
	}()
	
    //左侧文字
	lazy var leftLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 15)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		titleLabel.text = "小马哥在线教育"
		return titleLabel
	}()
	
//    var anchor = AnchorModel() {
//
//        didSet {
//
//        }
//    }
    
    var anchor : AnchorModel? {
        
        didSet {
            guard let anchor = anchor else { return }
            if anchor.online >= 1000 {
                onlineLabel.text = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineLabel.text = "\(anchor.online)在线"
            }
            leftLabel.text = anchor.nickname
            
            //设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            
            print("____iconURL:\(iconURL)______src:\(anchor.vertical_src)")
            //https://pic.netbian.com/uploads/allimg/211103/234237-1635954157f0ce.jpg
            //codeTest
            let url = URL(string: "https://pic.netbian.com/uploads/allimg/211103/234237-1635954157f0ce.jpg")
            bgImg.kf.setImage(with: url)
        }
    }
    
	override init(frame: CGRect) {
		
		super.init(frame: frame)
	
        initUI()
        
	}
	
	func initUI() {
		addSubview(bgImg)
		bgImg.addSubview(onlineLabel)
		addSubview(iconImg)
		addSubview(leftLabel)
		
		bgImg.snp.makeConstraints { make in
			make.left.top.right.equalTo(0)
			make.height.equalTo(153)
		}
		onlineLabel.snp.makeConstraints { make in
			make.right.equalTo(0)
			make.bottom.equalTo(-5)
		}
		
		iconImg.snp.makeConstraints { make in
			make.left.equalTo(0)
			make.bottom.equalTo(-5)
			make.size.equalTo(CGSize(width: 5, height: 5))
		}
		leftLabel.snp.makeConstraints { make in
			make.left.equalTo(iconImg.snp_rightMargin).offset(5)
			make.bottom.equalTo(-5)
		}
		
        //codeTest
        bgImg = UIImageView.init(image: UIImage(named: "aaa"))
        onlineLabel.text = "werrt"
        iconImg.image = UIImage(named: "home_header_hot")
        leftLabel.text = "小马哥教育"
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
