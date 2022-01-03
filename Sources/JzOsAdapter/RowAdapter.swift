//
//  GridAdapter.swift
//  JzAdapter
//
//  Created by Jianzhi.wang on 2020/2/1.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//
import Foundation
import UIKit
public class RowAdapter:NSObject, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tb.reloadData()
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tb.reloadData()
    }
    var rowCal:Dictionary<Int,Int> = [:]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowCal = [:]
        var tempSize=0
        let counts=count()
        rowCal[0]=0
        var trow=1
        while(tempSize < counts){
            tempSize+=spilt(trow-1)
            rowCal[trow]=tempSize
            trow+=1
        }
        return trow-1
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var maxHeight=0
        for i in 0..<spilt(indexPath.row){
            let place=rowCal[indexPath.row]!+i
            let itemFrame=itemFrame(place)
            if(maxHeight<itemFrame.height){maxHeight=itemFrame.height}
        }
        return CGFloat(maxHeight) 
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CoverCell", for: indexPath) as! CoverCell
        cell.position=rowCal[indexPath.row]!
        var compare=0
        let maxCount=count()
        for a in 0..<spilt(indexPath.row){
            if(cell.position+a < maxCount){
                compare=a+1
            }
        }
       
        cell.setUP(compare, nib, getcell, itemFrame,tb)
        print("scrollTO--\(indexPath.row)")
        return cell
    }
    var row=0
    var nib=[String]()
    var id=""
    //Cell的取得
    var getcell: (_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell
    //數量
    var count:()->Int
    //各行的數量
    var spilt:(_ row:Int)->Int
    //tableview
    var tb:UITableView! = nil
    //Item寬高設定
    var itemFrame:(_ position:Int)->ItemFrame
    
    public  init(tb:UITableView,itemFrame:@escaping(_ position:Int)->ItemFrame,count:@escaping ()->Int,spilt:@escaping (_ row:Int)->Int,nib:[String] ,getcell:@escaping (_ collectionView: UICollectionView, _ indexPath: IndexPath,_ position:Int)->UICollectionViewCell){
        self.getcell=getcell
        self.count=count
        self.itemFrame=itemFrame
        self.nib=nib
        self.spilt=spilt
        self.tb=tb
        super.init()
        tb.separatorStyle = .none
        tb.register(UINib(nibName: "CoverCell", bundle: Bundle.module), forCellReuseIdentifier: "CoverCell")
        tb.dataSource=self
        tb.delegate=self
        tb.reloadData()
    }
    public func notifyDataSetChange(){tb.reloadData()}
}
public struct ItemFrame{
    //Item的寬度
    public var width:Int
    //Item的高度
    public var height:Int
    public init(width:Int,height:Int){
        self.width=width
        self.height=height
    }
}
