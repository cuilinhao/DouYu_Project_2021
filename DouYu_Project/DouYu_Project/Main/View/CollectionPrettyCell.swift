//
//  CollectionPrettyCell.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    
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
            bgImg.kf.setImage(with: iconURL)
            
            cityLabel.text = anchor.anchor_city
        }
    }
    
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
		let bgImg = UIImageView()
		bgImg.contentMode = .scaleAspectFill
		bgImg.image = UIImage.init(named: "Img_default")
		return bgImg
	}()
	
	//下面标题
	lazy var leftLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 12)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		titleLabel.text = "小马哥教育"
		
		return titleLabel
	}()
	
	lazy var locationImg: UIImageView = {
		let locationImg = UIImageView()
		locationImg.contentMode = .scaleAspectFit
		locationImg.image = UIImage.init(named: "ico_location")
		return locationImg
	}()
	lazy var cityLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 10)
		titleLabel.textAlignment = .left
		titleLabel.textColor = UIColor.purple
		
		return titleLabel
	}()
	
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		initUI()
		
		self.contentView.layer.masksToBounds = true
		self.contentView.backgroundColor = UIColor.white
		
	}
	
	func initUI() {
		
		self.contentView.addSubview(bgImg)
		bgImg.addSubview(onlineLabel)
		self.contentView.addSubview(leftLabel)
		self.contentView.addSubview(locationImg)
		self.contentView.addSubview(cityLabel)
		
		bgImg.snp.makeConstraints { make in
			make.left.top.right.equalTo(0)
			make.height.equalTo(165+30-10)
		}
		onlineLabel.snp.makeConstraints { make in
			make.right.equalTo(-5)
			make.top.equalTo(5)
			
		}
		
		leftLabel.snp.makeConstraints { make in
			make.left.equalTo(0)
			make.bottom.equalTo(-15-19)
			
		}

		cityLabel.snp.makeConstraints { make in
			make.top.equalTo(leftLabel.snp_bottomMargin).offset(9)
			make.left.equalTo(0)
			make.size.equalTo(CGSize(width: 30+20, height: 20))
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		onlineLabel.text = "666在线"
		leftLabel.text = "小马哥直播斗鱼"
		cityLabel.text = "上海市"
		locationImg.image = UIImage.init(named: "ico_location")
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
