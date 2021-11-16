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
		let bgImg = UIImageView()
		bgImg.contentMode = .scaleAspectFill
		//Img_default
		bgImg.image = UIImage(named:"aaa")
        bgImg.layer.cornerRadius = 4.0
        bgImg.layer.masksToBounds = true
        
		return bgImg
	}()
	

	//在线人数
	lazy var onlineLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 12)
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
		
		let leftLabel = UILabel()
		leftLabel.font = .systemFont(ofSize: 12)
		leftLabel.textAlignment = .center
		leftLabel.textColor = UIColor.white
		leftLabel.backgroundColor = UIColor.clear
		leftLabel.text = "小马哥在线教育"
		return leftLabel
	}()
	
    var anchor : AnchorModel? {
        
        didSet {
            guard let anchor = anchor else { return }
            if anchor.online >= 1000 {
                onlineLabel.text = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineLabel.text = "\(anchor.online)在线"
            }
            leftLabel.text = anchor.nickname
            iconImg.image = UIImage(named: "home_header_hot")
            
            //设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            bgImg.kf.setImage(with: iconURL)
            
            print("____iconURL:\(iconURL)______src:\(anchor.vertical_src)")
        }
    }
    
	override init(frame: CGRect) {
		
		super.init(frame: frame)
	
        initUI()
		self.contentView.layer.masksToBounds = true
	}
	
	func initUI() {
        
		self.contentView.addSubview(bgImg)
		bgImg.addSubview(onlineLabel)
		self.contentView.addSubview(iconImg)
		self.contentView.addSubview(leftLabel)
	
		bgImg.snp.makeConstraints { make in
			make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
		}
		
		onlineLabel.snp.makeConstraints { make in
			make.right.equalTo(0)
			make.bottom.equalTo(-5)
		}
		
		iconImg.snp.makeConstraints { make in
			make.left.equalTo(0)
			make.bottom.equalTo(-2)
			make.size.equalTo(CGSize(width: 15, height: 15))
		}
		leftLabel.snp.makeConstraints { make in
			make.left.equalTo(iconImg.snp_rightMargin).offset(5)
			make.bottom.equalTo(-1)
			make.size.equalTo(CGSize(width: 100, height: 15))
		}
		
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		//bgImg = UIImageView.init(image: UIImage(named: "aaa"))
//		onlineLabel.text = "werrt"
//		iconImg.image = UIImage(named: "home_header_hot")
//		leftLabel.text = "小马哥教育"
//
//		let url = URL(string: "https://pic.netbian.com/uploads/allimg/211103/234237-1635954157f0ce.jpg")
//		bgImg.kf.setImage(with: url)
//
//
//		//bgImg.image = UIImage(named: "bbb")
//
//		//codeTest
//		leftLabel.text = "小马哥斗鱼直播"
//		//leftLabel.backgroundColor = UIColor.systemCyan
//		//leftLabel.textColor = UIColor.white
//		onlineLabel.text = "66666在线"
		
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
