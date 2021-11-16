//
//  RecommendViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/5.
//

import UIKit


private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50 - 18


private let KNormalCellID = "KNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kPrettyCellID = "kPrettyCellID"
private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPerttyItemH = kNormalItemW * 4 / 3

private let kCycleViewH: CGFloat = kScreenW * 3 / 8 + 100
private let kGameViewH: CGFloat = 90


class RecommendViewController: UIViewController {

	lazy var recommedViewModel = RecommendViewModel()
	
    //顶部轮播
    lazy var cycleView: RecommendCycleView = {
       
        let cycleView = RecommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        
        //codeTest
        cycleView.backgroundColor = UIColor.systemPink
        
        return cycleView
    }()
    
	//推荐view
	lazy var recommendView : RecommendGameView = {
		
		let recommendView = RecommendGameView.recommendGameView()
		recommendView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
		
		//codeTest
		recommendView.backgroundColor = .systemCyan
		
		return recommendView
	}()
	
	
    
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
		
		//注册cell
		collectionView.register(CollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
		collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: KNormalCellID)
		collectionView.register(CollectionPrettyCell.self, forCellWithReuseIdentifier: kPrettyCellID)
		
		return collectionView
	}()
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
		view.addSubview(collectionView)
        
        //cycleview 添加到collectionView
        collectionView.addSubview(cycleView)
        
		collectionView.addSubview(recommendView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        
		collectionView.backgroundColor = UIColor.systemGray2
		recommedViewModel.requestData {
			print("++++++")
            self.collectionView.reloadData()
		}
        
        recommedViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommedViewModel.cycleModes
            
        }
		
		
        
    }
}


extension RecommendViewController:UICollectionViewDataSource, UICollectionViewDelegate {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommedViewModel.anchorGroups.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommedViewModel.anchorGroups[section]
        
        return group.anchors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		//let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
		//cell.contentView.backgroundColor = UIColor.randomColor()
        
        //取出模型数据
        let group = recommedViewModel.anchorGroups[indexPath.section]
        
        let anchor = group.anchors[indexPath.item]
        
        //var cell : UICollectionViewCell!
        if indexPath.section == 1 {
            
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            
            //cell.contentView.backgroundColor = UIColor.randomColor()
            
            return cell
            
        }else {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor
            
            //cell.contentView.backgroundColor = UIColor.randomColor()
			
//			let url = URL(string: "https://pic.netbian.com/uploads/allimg/211103/234237-1635954157f0ce.jpg")
//			cell.bgImg.kf.setImage(with: url)
//
//			cell.bgImg.image = UIImage(named: "aaa")
//			print("__leftLabel:_22_\(cell.bgImg)")
			
            return cell
        }
		//return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
		
        header.group = recommedViewModel.anchorGroups[indexPath.section]
        
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
