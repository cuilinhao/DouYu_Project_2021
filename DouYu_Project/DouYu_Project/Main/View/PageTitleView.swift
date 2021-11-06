//
//  PageTitleView.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/6.
//

import UIKit
import SwiftUI

/** 只能被类遵守的协议

protocol testProtocol1: class {
	
}

protocol test2: AnyObject {
	
}

@objc protocol test3 {
	
}
 */

private let kScrollLineH : CGFloat =  2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor:(CGFloat, CGFloat, CGFloat) = (255, 128, 0)


//MARK:- 定义协议
protocol PageTitleViewDelegate: AnyObject {
	func pagetitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

class PageTitleView: UIView {

	fileprivate var currentIndex  = 0
	fileprivate var titles: [String]
	
	fileprivate lazy var titleLabes : [UILabel] = [UILabel]()
	
	fileprivate lazy var scrolleView: UIScrollView = {
		
		let scrolleView = UIScrollView()
		scrolleView.showsHorizontalScrollIndicator = false
		scrolleView.scrollsToTop = false
		//设置边界
		scrolleView.bounces = false
		
		return scrolleView
	}()
	
	fileprivate	lazy var scrollLine: UIView = {
		let line = UIView()
		line.backgroundColor = .orange
		return line
	}()
	
	  init(frame: CGRect, titles: [String]) {
		
		self.titles = titles
		super.init(frame: frame)
		
		initUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension PageTitleView {
	
	func initUI() {
		
		addSubview(scrolleView)
		scrolleView.frame = bounds
		
		setUpTitleLabels()
		
		setUpBottomLine()
		
	}
	
	func setUpTitleLabels() {
		
		let labelW: CGFloat = frame.width / CGFloat(titles.count)
		let labelH: CGFloat = frame.height - kScrollLineH
		let labelY: CGFloat = 0
		
		for (index, title) in titles.enumerated() {
			
			let label = UILabel()
			
			label.text = title
			label.tag = index
			label.font = UIFont.systemFont(ofSize: 16)
			label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
			label.textAlignment = .center
			
			let labelX  = labelW * CGFloat(index)
			label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
			
			scrolleView.addSubview(label)
			titleLabes.append(label)
			
			//添加手势
			label.isUserInteractionEnabled = true
			
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
			
			label.addGestureRecognizer(tapGesture)
		}
	}
	
	func setUpBottomLine() {
		
		//添加底线
		let bottomLine = UIView()
		bottomLine.backgroundColor = UIColor.lightGray
		
		let lineH : CGFloat = 0.5
		bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
		addSubview(bottomLine)
		
		//添加滑动线
		guard let firstLabel = titleLabes.first else { return }
		firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
		
		scrolleView.addSubview(scrollLine)
		scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
		
	}
}

//MARK:- 监听lebl点击

//extension PageTitleView {
//	
//	@objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
//		
//		guard let currentLabel = tapGes.view as? UILabel else { return }
//		
//		if currentLabel.tag == currentIndex { return }
//			
//		let oldLabel = titleLabes[currentIndex]
//			
//			currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
//			
//			currentIndex = currentLabel.tag
//			
//		
//	}
//	
//	
//}
