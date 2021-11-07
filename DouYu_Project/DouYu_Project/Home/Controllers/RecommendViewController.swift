//
//  RecommendViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit


private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50


private let KNormalCellID = "KNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kPrettyCellID = "kPrettyCellID"
private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPerttyItemH = kNormalItemW * 4 / 3


class RecommendViewController: UIViewController {

	
	lazy var collectionView: UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = kItemMargin
		//设置头部
		layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
		layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
		
		
		let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		
		//collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCellID)
		//collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
		
		//注册cell
		collectionView.register(CollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
		collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: KNormalCellID)
		collectionView.register(CollectionPrettyCell.self, forCellWithReuseIdentifier: kPrettyCellID)
		

		return collectionView
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		view.addSubview(collectionView)
		
    }
	
}


extension RecommendViewController:UICollectionViewDataSource, UICollectionViewDelegate {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if section == 0 {
			return 8
		}
		
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
		
		cell.contentView.backgroundColor = UIColor.randomColor()
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
		
		header.backgroundColor = UIColor.systemCyan
		return header
	}
}


extension RecommendViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if indexPath.section == 1 {
			return CGSize(width: kNormalItemW, height: kPerttyItemH)
		}
		return CGSize(width: kNormalItemW, height: kNormalItemH)
	}
	
}
