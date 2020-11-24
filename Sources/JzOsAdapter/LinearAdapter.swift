//
//  LinearAdapter.swift
//  JzAdapter
//
//  Created by Jianzhi.wang on 2020/2/1.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import UIKit
public class LinearAdapter:NSObject, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count()
    }
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getcell(tableView,indexPath,indexPath.row)
    }
    
    var getcell: (_ tb: UITableView, _ index: IndexPath,_ position:Int)->UITableViewCell
    var count:()->Int
    var spilt=0
    var tb:UITableView! = nil
    var select:(_ position:Int)->Void
    public  init(tb:UITableView,count:@escaping ()->Int,nib:[String],getcell:@escaping (_ tb: UITableView, _ indexPath: IndexPath,_ position:Int)->UITableViewCell,_ select:@escaping (_ position:Int)->Void){
        self.getcell=getcell
        self.count=count
        self.select=select
        super.init()
        self.tb=tb
        for i in nib{
            tb.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        tb.separatorStyle = .none
        tb.dataSource=self
        tb.delegate=self
        tb.reloadData()
    }
    public   func notifyDataSetChange(){tb.reloadData()}
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        select(indexPath.row)
    }
}
