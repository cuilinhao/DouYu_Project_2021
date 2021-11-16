//
//  RecommendGameView.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/10.
//

import UIKit

private let kGameCellID = "kGameCellID"

private let kEdgeInsetMargin : CGFloat = 10


class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
	
	//定义属性
	var groups : [AnchorModel]? {
		
		didSet {
			
			collectionView.reloadData()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		//CollectionGameCell
		
		autoresizingMask = UIView.AutoresizingMask()
		
		
		collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
		
		collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
		
		//codeTest
		collectionView.backgroundColor = .systemGreen
		
		collectionView.reloadData()
	}
}

//MARK:- 提供快速创建的类方法
extension RecommendGameView {
	
	class func recommendGameView() -> RecommendGameView{
		
		return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
	}
}

extension RecommendGameView: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		//return groups?.count ?? 0
		
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
		
		//cell.baseGame = groups![indexPath.item]
		
		cell.updateUI()
		
		return cell
	}
	
}
