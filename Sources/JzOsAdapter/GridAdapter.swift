//
//  GridAdapter.swift
//  JzAdapter
//
//  Created by Jianzhi.wang on 2020/2/1.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//
import Foundation
import UIKit
public class GridAdapter:NSObject, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((count()%spilt)==0){
            row=count()/spilt
            if(heght==0){
                self.heght=heght/CGFloat(row)
            }
            return count()/spilt
        }else{
            row=(count()/spilt)+1
            if(heght==0){
                self.heght=heght/CGFloat(row)
            }
            return (count()/spilt)+1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "basecell", for: indexPath) as! CoverCell
        cell.position=indexPath.row*spilt
        cell.width=width
        if(indexPath.row==row-1 && count()%spilt != 0){
            cell.setUP(count()%spilt, nib, getcell, heght,tb)
        }else{
            cell.setUP(spilt, nib, getcell, heght,tb)
        }
        
        return cell
    }
    var row=0
    var heght:CGFloat=100
    var width:CGFloat=0
    var nib=""
    var id=""
    var getcell: (_ collectionView: UICollectionView, _ index: IndexPath,_ position:Int)->UICollectionViewCell
     var count:()->Int
    var spilt=0
    var tb:UITableView! = nil
    
    public  init(tb:UITableView,width:CGFloat,height:CGFloat,count:@escaping ()->Int,spilt:Int,nib:String ,getcell:@escaping (_ collectionView: UICollectionView, _ indexPath: IndexPath,_ position:Int)->UICollectionViewCell){
        self.getcell=getcell
        self.count=count
        self.width=width
        super.init()
        self.heght=height
        self.nib=nib
        self.spilt=spilt
        self.tb=tb
        tb.register(UINib(nibName: "basecell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "basecell")
        tb.dataSource=self
        tb.delegate=self
        tb.reloadData()
    }
    public func notifyDataSetChange(){tb.reloadData()}
}
