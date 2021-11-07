//
//  CollectionPrettyCell.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    
	//在线
	lazy var onlineLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 15)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		titleLabel.text = "6666在线"
		
		return titleLabel
	}()
	lazy var bgImg: UIImageView = {
		let iconImg = UIImageView()
		iconImg.contentMode = .scaleAspectFit
		iconImg.image = UIImage.init(named: "Img_default")
		return iconImg
	}()
	
	//下面标题
	lazy var leftLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 15)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		titleLabel.text = "小马哥教育"
		
		return titleLabel
	}()
	
	lazy var locationImg: UIImageView = {
		let iconImg = UIImageView()
		iconImg.contentMode = .scaleAspectFit
		iconImg.image = UIImage.init(named: "ico_location")
		return iconImg
	}()
	lazy var cityLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 10)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		
		return titleLabel
	}()
	
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		
	}
	
	func initUI() {
		
		addSubview(bgImg)
		bgImg.addSubview(onlineLabel)
		addSubview(leftLabel)
		addSubview(locationImg)
		addSubview(cityLabel)
		
		bgImg.snp.makeConstraints { make in
			make.left.top.right.equalTo(0)
			make.height.equalTo(165)
		}
		onlineLabel.snp.makeConstraints { make in
			make.right.equalTo(-5)
			make.top.equalTo(5)
			
		}
		
		leftLabel.snp.makeConstraints { make in
			make.left.equalTo(0)
			make.bottom.equalTo(-15)
			
		}
		cityLabel.snp.makeConstraints { make in
			make.top.equalTo(leftLabel.snp_bottomMargin).offset(3)
			make.left.equalTo(0)
			make.size.equalTo(CGSize(width: 3, height: 3))
		}

		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
