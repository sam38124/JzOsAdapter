//
//  CoverCell.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/31.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
@available(iOS 9.0, *)
public class CoverCell:UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate{
    @IBOutlet var collectionView: UICollectionView!
    var itemcount=0
    var nib=[String]()
    var height:CGFloat=0
    var width:CGFloat=0
    var position=0
    var scrollback:(()->Void?)?=nil
    var callback:((_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell)? = nil
    
    public func setUP(_ count:Int,_ nib:[String],_ getcell:@escaping (_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell,_ height:CGFloat,_ tb:UITableView){
        itemcount=count
        callback=getcell
        self.nib=nib
        self.height=height
        for i in nib{
            collectionView.register(UINib(nibName:i, bundle:nil),
                                    forCellWithReuseIdentifier:i)
        }
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive=true
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize.height = CGFloat(height)
        if(width==0){layout.itemSize.width = tb.frame.width/CGFloat(count)}else{
            layout.itemSize.width = CGFloat(width)
        }
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.clear
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemcount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return callback!(collectionView,indexPath,position+indexPath.row)
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

