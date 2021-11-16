//
//  RecommendCycleView.swift
//  DouYu_Project
//
//  Created by 崔林豪 imac on 2021/11/10.
//

import UIKit
import SnapKit

private let kCycleCellID = "kCycleCellID"

private let kCycleViewH = kScreenW * 3 / 8 + 100

class RecommendCycleView: UIView {

    
    var cycleTimer : Timer?
    
    var cycleModels: [CycleModel]? {
        
        didSet {
            
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            print("___modelCount:\(cycleModels?.count ?? 0)")
            
            
            //默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 1) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
        
    }
    
    
    lazy var pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = 6
        pageControl.tintColor = UIColor.systemGreen
        pageControl.currentPageIndicatorTintColor = UIColor.systemRed
        
        return pageControl
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kCycleViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemGreen
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCycleCell.self, forCellWithReuseIdentifier: kCycleCellID)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        collectionView.addSubview(pageControl)
        
        self.insertSubview(pageControl, aboveSubview: collectionView)
        
        initUI()
    }
    
    func initUI() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        pageControl.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: 190, height: 39))
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RecommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 1000
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
    
        cell.backgroundColor = UIColor.randomColor()
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        
        return cell
    }
    
}


extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //偏移量 多加 一半,让图片轮播过去
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
}

extension RecommendCycleView {
    
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
        
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    
    @objc func scrollToNext() {
        
        //获取滚动的偏移量
        let currOffsetX = collectionView.contentOffset.x

        let offsetX = currOffsetX + collectionView.bounds.size.width
        
        //滚动到改位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

class CollectionCycleCell: UICollectionViewCell {
    
    
    var cycleModel: CycleModel? {
        didSet {
            titleLab.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")!
            bgImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "aaa"))
            
        }
    }
    
    lazy var bgImageView: UIImageView = {
        
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        
        return bgImageView
    }()
    
    lazy var titleLab: UILabel = {
        
        let titleLab = UILabel()
        titleLab.font = .systemFont(ofSize: 13)
        titleLab.textColor = UIColor.purple
        
        return titleLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI() {
        
        self.contentView.addSubview(bgImageView)
        bgImageView.addSubview(titleLab)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        titleLab.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(30)
        }
        
    }
    
//    override func layoutSubviews() {
//        
//        bgImageView.image = UIImage(named: "aaa")
//        titleLab.text = "这是一些测试"
//    }
//    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
