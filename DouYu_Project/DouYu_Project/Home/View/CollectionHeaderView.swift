//
//  CollectionHeaderView.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/7.
//

import UIKit
import SnapKit
import Kingfisher


class CollectionHeaderView: UICollectionReusableView {
        
	
	lazy var titleLabel: UILabel = {
		
		let titleLabel = UILabel()
		titleLabel.font = .systemFont(ofSize: 15)
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.purple
		
		return titleLabel
	}()
	
	
	lazy var iconImg: UIImageView = {
		let iconImg = UIImageView()
		iconImg.contentMode = .scaleAspectFit
		return iconImg
	}()
	
	
	lazy var moreBtn: UIButton = {
		
		let button = UIButton()
		button.titleLabel?.font = .boldSystemFont(ofSize: 15)
		button.titleLabel?.textColor = .white
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(clickSignButton), for: .touchUpInside)
		
		return moreBtn
		
	}()
	
	
	
	override init(frame: CGRect) {
		
		
		super.init(frame: frame)
		initUI()
		
		//codeTest
		titleLabel.text = "直播"
		moreBtn.titleLabel?.text = "更需哦"
		iconImg = UIImageView.init(image: UIImage(named: "home_header_phone"))
		
	}
	
	func initUI() {
		addSubview(titleLabel)
		addSubview(iconImg)
		addSubview(moreBtn)
		
		iconImg.snp.makeConstraints { make in
			make.left.top.equalTo(5)
			make.size.equalTo(CGSize(width: 9, height: 9))
		}
		
		titleLabel.snp.makeConstraints { make in
			make.left.equalTo(iconImg.snp_rightMargin).offset(5)
			make.top.equalTo(5)
		}
		
		moreBtn.snp.makeConstraints { make in
			make.right.equalTo(-10)
			make.top.equalTo(5)
		}
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CollectionHeaderView {
	
	@objc func clickSignButton() {
		
	}
}
