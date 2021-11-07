//
//  PageContentView.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/6.
//

import UIKit


private let contentCellID = "contentCellID"

protocol PageContentViewDelegate: AnyObject {
	
	func pageContent(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


class PageContentView: UIView {
	
	var childVcs: [UIViewController]
	var parentViewController: UIViewController?
	
	var startOffsetX : CGFloat = 0
	var isforbidScrollDelegate: Bool = false
	
	weak var delegate: PageContentViewDelegate?
	
	
	lazy var collectionView: UICollectionView = { [weak self] in
		
		let layout = UICollectionViewFlowLayout()
		
		layout.itemSize = (self?.bounds.size)!
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		//bounces 弹性效果，默认是TRUE, 如果设置成false，则当你滑动到边缘时将不具有弹性效果
		collectionView.bounces = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.scrollsToTop = false
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
		
		
		return collectionView
	}()
	
	 init(frame: CGRect, childVcs: [UIViewController], parentViewController : UIViewController?) {
		
		self.childVcs = childVcs
		self.parentViewController = parentViewController
		
		super.init(frame: frame)
		
		initUI()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension PageContentView {
	
	func initUI() {
		
		for childVc in childVcs {
			parentViewController?.addChild(childVc)
		}
		
		addSubview(collectionView)
		collectionView.frame = bounds
		
	}
	
}

extension PageContentView:UICollectionViewDataSource {
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return childVcs.count
	}
	
	/** 注释
	 
	 判断视图是什么类型
	 if NSStringFromClass(view.classForCoder) == "UIView" {
		 print("是gameView")
	 }
	 
	 */
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		//设置cell
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
		
		//给cell 设置内容
		//#warning("+++>>>要移除>>>>")
		//MARK:-移除的是childVcs的view
		for view in cell.contentView.subviews {
			
			print("___cell上要移除的view：\(view)")
			//print("__\(view.ty)")
			view.removeFromSuperview()
			//view.backgroundColor = .systemPink
		}
		
		let childVc = childVcs[indexPath.item]
		childVc.view.frame = cell.contentView.bounds
		cell.contentView.addSubview(childVc.view)
		
		cell.contentView.backgroundColor = .systemPurple
		if indexPath.item % 2 == 0 {
			cell.contentView.backgroundColor = .systemGreen
		}
		
		return cell
	}
	
}

extension PageContentView:UICollectionViewDelegate {
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		
		isforbidScrollDelegate = false
		
		startOffsetX = scrollView.contentOffset.x
		
	}
	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		if isforbidScrollDelegate {
			return
		}

		var progress: CGFloat = 0
		var sourceIndex : Int = 0
		var targetIndex: Int = 0

		//判断左滑还是右滑

		let currentOffsetX = scrollView.contentOffset.x
		let scrollViewW = scrollView.bounds.width

		if currentOffsetX > startOffsetX {
			//左滑
			
			progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
			
			sourceIndex = Int(currentOffsetX / scrollViewW)
			
			targetIndex = sourceIndex + 1
			
			if targetIndex >= childVcs.count {
				targetIndex = childVcs.count - 1
			}
			
			//如果完全滑过去
			if currentOffsetX - startOffsetX == scrollViewW {
				progress = 1
				targetIndex = sourceIndex
			}
			

		}else {
			//右滑
			progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
			
			targetIndex = Int(currentOffsetX / scrollViewW)
			
			sourceIndex = targetIndex + 1
			
			if sourceIndex >= childVcs.count {
				sourceIndex = childVcs.count - 1
			}
		}
		
		// 3.将progress/sourceIndex/targetIndex传递给titleView
		delegate?.pageContent(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
		
	}
	
	
}

extension PageContentView {
	func setCurrentIndex(_ currentIndex: Int) {
		
		//记录需要禁止执行代理方法
		isforbidScrollDelegate = true
		
		//滚动到正确位置
		let offsetX = CGFloat(currentIndex) * collectionView.frame.width
		collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
		
	}
}
