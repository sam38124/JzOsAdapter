//
//  HorizontalAdapter.swift
//  JzAdapter
//
//  Created by Jianzhi.wang on 2020/2/9.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import Foundation
import UIKit
public class HorizontalAdapter:NSObject, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CoverCell", for: indexPath) as! CoverCell
        cell.scrollback=scrollback
        cell.position=0
        cell.width=width
        cell.setUP(count(), nib, getcell, heght,tb)
        
        return cell
    }
    var row=0
    var heght:CGFloat=100
    var width:CGFloat=0
    var nib=[String]()
    var id=""
    var getcell: (_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell
    var count:()->Int
    var tb:UITableView! = nil
    var scrollback:(()->Void?)?=nil
    public  init(tb:UITableView,width:CGFloat,height:CGFloat,count:@escaping ()->Int,nib:[String] ,getcell:@escaping (_ collectionView: UICollectionView, _ indexPath: IndexPath,_ position:Int)->UICollectionViewCell,scrollback:@escaping ()->Void){
        self.getcell=getcell
        self.count=count
        self.width=width
        self.scrollback=scrollback
        super.init()
        self.heght=height
        self.nib=nib
        self.tb=tb
        tb.register(UINib(nibName: "CoverCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CoverCell")
        tb.dataSource=self
        tb.delegate=self
        tb.bounces=false
        tb.reloadData()
    }
    public func notifyDataSetChange(){tb.reloadData()}
    public func getVisible()->[UICollectionViewCell]{
        return (tb.visibleCells[0] as! CoverCell).collectionView.visibleCells
    }
    public func scrollTo(_ a:IndexPath){
        (tb.visibleCells[0] as! CoverCell).sctoolTo(a)
    }
    public func scrollAble(_ a:Bool){
        (tb.visibleCells[0] as! CoverCell).collectionView.isScrollEnabled=a
        tb.isScrollEnabled=a
    }
}
