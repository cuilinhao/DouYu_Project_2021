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

private let kScrollLineH : CGFloat =  5
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor:(CGFloat, CGFloat, CGFloat) = (255, 128, 0)


//MARK:- 定义协议
protocol PageTitleViewDelegate: AnyObject {
	func pagetitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

class PageTitleView: UIView {

	fileprivate var currentIndex  = 0
	fileprivate var titles: [String]
	
	weak var delegate: PageTitleViewDelegate?
	
	fileprivate lazy var titleLabes : [UILabel] = [UILabel]()
	
	fileprivate lazy var scrolleView: UIScrollView = {
		
		let scrolleView = UIScrollView()
		scrolleView.showsHorizontalScrollIndicator = false
		//点击状态栏，回到顶部
		scrolleView.scrollsToTop = false
		//设置边界 不超过内容的范围
		//bounces 弹性效果，默认是TRUE, 如果设置成false，则当你滑动到边缘时将不具有弹性效果
		scrolleView.bounces = false
		
//		scrolleView.contentSize = CGSize(width: 1000, height: 88)
//		scrolleView.contentSize = CGSize(width: titles.count * 100, height: frame.height)
		
		
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
		
		//问题 scrolleView 不滚动
		//scrolleView.contentSize = CGSize(width: CGFloat(titles.count * 100), height: frame.height)
		//loginScrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight * 2)
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
		//scrollLine.backgroundColor = UIColor.red
		
	}
}

//MARK:- 监听lebl点击

extension PageTitleView {
	
	@objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
		
		guard let currentLabel = tapGes.view as? UILabel else { return }
		
		if currentLabel.tag == currentIndex { return }
		
		//获取之前的label 改变颜色
		let oldLabel = titleLabes[currentIndex]
		
		//切换文字颜色
		currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
			
		oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
		
		
		//codeTest
		
		//保存最新label的下标值
		currentIndex = currentLabel.tag
		
		//滚动条位置发生改变
		let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.size.width
		
		UIView.animate(withDuration: 0.5) {
			self.scrollLine.frame.origin.x = scrollLineX
		}

		//通知代理
		delegate?.pagetitleView(self, selectedIndex: currentIndex)
		
		print("______currentIndex:\(currentIndex)")
		
	}
}

//MARK:- 对外暴露的方法
extension PageTitleView {
	
	func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targeIndex: Int) {
		
		let sourceLabel = titleLabes[sourceIndex]
		let targetLabel = titleLabes[targeIndex]
		
		//处理滑块逻辑
		
		let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
		let moveX = moveTotalX * progress
		
		scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
		
		//改变颜色
		let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
		
		//改变sourceLabel
		sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
		
		//改变targetLabel
		targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
		
		//记录最新index
		currentIndex = targeIndex
		
	}
	
	
}
