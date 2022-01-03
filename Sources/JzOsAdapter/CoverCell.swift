//
//  CoverCell.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/31.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
@available(iOS 9.0, *)
public class CoverCell:UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout{
    @IBOutlet var collectionView: UICollectionView!
    //此行數量
    var itemcount=0
    //註冊的nib
    var nib=[String]()
    //位置
    var position=0
    //滑動回條
    var scrollback:(()->Void?)?=nil
    //Item寬高設定
    var itemFrame:((_ position:Int)->ItemFrame)!=nil
    //取得View
    var callback:((_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell)? = nil
    //初始設定
    public func setUP(_ count:Int,_ nib:[String],_ getcell:@escaping (_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell,_ itemFrame:@escaping(_ position:Int)->ItemFrame,_ tb:UITableView){
        itemcount=count
        callback=getcell
        self.nib=nib
        self.itemFrame=itemFrame
        for i in nib{
            collectionView.register(UINib(nibName:i, bundle:nil),forCellWithReuseIdentifier:i)
        }
        var maxHeight=10
        for i in 0..<itemcount{
            let place=position+i
            let itemFrame=itemFrame(place)
            if(maxHeight<itemFrame.height){maxHeight=itemFrame.height}
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.heightAnchor.constraint(equalToConstant: CGFloat(maxHeight)).isActive=true
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView-itemcount:\(itemcount)")
        return itemcount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
//        collectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive=true
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .horizontal
//        layout.itemSize.height = CGFloat(height)
//        layout.itemSize.width = CGFloat(width)
//        collectionView.collectionViewLayout = layout
        let place=position+indexPath.row
        return callback!(collectionView,indexPath,place)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("position-\(position)-indexPath.row-\(indexPath.row)")
        let place=position+indexPath.row
        let itemFrame=itemFrame(place)
        let height=itemFrame.height
        let width=itemFrame.width
        return CGSize(width: width, height: height)
     }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      if scrollView == collectionView {
                       if(scrollback != nil){scrollback!()}
                       print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
                   }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
                  if(scrollback != nil){scrollback!()}
                  print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
              }
    }
    public func sctoolTo(_ indexpath:IndexPath){
      collectionView.layoutIfNeeded()
      collectionView.scrollToItem(at: indexpath, at: [], animated: true)
    }
   
}

