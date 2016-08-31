//
//  ViewController.swift
//  collectionCellTest
//
//  Created by Mary Qian on 16/8/31.
//  Copyright © 2016年 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView = ShiftCollectionView()
        collectionView.registerClass(ShiftCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
    }
}

class ShiftCollectionView: UICollectionView {
    var margin: CGFloat = 15
    var shiftArray = ["早餐","午餐","下午茶","晚餐","欢乐时光"]
    var colorArray = [UIColor.redColor(), UIColor.orangeColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.greenColor(), UIColor.blueColor()]
    var selectedShiftIndex = 0

    init() {
        super.init(frame: CGRectMake(100, 200, 300, 55), collectionViewLayout: layout)
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
}

extension ShiftCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let string: NSString = shiftArray[indexPath.item]
        let width = string.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(18)]).width
        return CGSizeMake(width + 50, 55)
    }
}

extension ShiftCollectionView: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if selectedShiftIndex != indexPath.item {
            let beforeIndex = NSIndexPath(forItem: selectedShiftIndex, inSection: indexPath.section)
            selectedShiftIndex = indexPath.item
            collectionView.reloadItemsAtIndexPaths([beforeIndex, indexPath])
        }
    }
}

extension ShiftCollectionView: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shiftArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ShiftCollectionViewCell
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! ShiftCollectionViewCell
        cell.setTitle(shiftArray[indexPath.item])
        if selectedShiftIndex == indexPath.item {
            cell.setTitleColor(UIColor.blueColor())
        } else {
            cell.setTitleColor(UIColor.blackColor())
        }
        cell.backgroundColor = colorArray[indexPath.item]
        
    }
}

class ShiftCollectionViewCell: UICollectionViewCell {
    //    func
    var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        print("init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        titleLabel.frame = contentView.bounds
        contentView.addSubview(titleLabel)
    }
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setTitleColor(color: UIColor) {
        titleLabel.textColor = color
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(18)
        return label
    }()
    
//    private lazy var selectedSignal: s
}

