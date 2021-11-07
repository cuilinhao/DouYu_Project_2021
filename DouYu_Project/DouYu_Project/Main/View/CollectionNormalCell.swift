//
//  CollectionNormalCell.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

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
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		
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
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
