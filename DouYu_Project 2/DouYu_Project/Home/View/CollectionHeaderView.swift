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
		
 
	var group: AnchorGroup? {
		
		didSet {
			titleLabel.text = group?.tag_name
			iconImg.image = UIImage(named: group?.icon_name ?? "home_header_normal")
			//titleLabel.text = "美颜"
			//iconImg.image = UIImage(named: "home_header_normal")
			moreBtn.setTitle("更多", for: .normal)
			
			
		}
	}
	
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
  
  let moreBtn = UIButton()
		moreBtn.titleLabel?.font = .systemFont(ofSize: 15)
		moreBtn.setTitleColor(.purple, for: .normal)
		
		moreBtn.addTarget(self, action: #selector(clickSignButton), for: .touchUpInside)
  return moreBtn
  
 }()
 
 
 
 override init(frame: CGRect) {
  
  super.init(frame: frame)
  initUI()
  
  //codeTest
//  titleLabel.text = "直播"
//  moreBtn.titleLabel?.text = "更需哦"
//  iconImg = UIImageView.init(image: UIImage(named: "home_header_phone"))
  
 }
 
 func initUI() {
  
  addSubview(iconImg)
		addSubview(titleLabel)
  addSubview(moreBtn)
  
  iconImg.snp.makeConstraints { make in
   make.left.top.equalTo(10)
   make.size.equalTo(CGSize(width: 15, height: 15))
  }
  
  titleLabel.snp.makeConstraints { make in
   make.left.equalTo(iconImg.snp_rightMargin).offset(10)
   make.top.equalTo(10)
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
