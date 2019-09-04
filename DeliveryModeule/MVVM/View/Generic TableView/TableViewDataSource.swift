//
//  GenericTableView.swift
//  GenericTableView
//
//  Created by Anurag Kashyap on 03/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Provider: TableDataProviderProtocol, Cell : UITableViewCell> : NSObject, UITableViewDelegate, UITableViewDataSource where Cell : ConfigurableCellProtocol, Provider.T == Cell.T {
    
    var provider : Provider!
    var tableView : UITableView!
    
    var fetchingMore = false
    
    init(tableView: UITableView, provider:Provider) {
        self.tableView = tableView
        self.provider = provider
        self.tableView.tableFooterView = UIView()
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.resuseIdentifier) as! Cell
        let item = provider.item(at: indexPath)
        cell.configureCell(with: item, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.resuseIdentifier) as! Cell
        if cell.reuseIdentifier == "DeliveryTableViewCell" {
            let item = provider.item(at: indexPath)
                let itemValue:[String: Provider.T] = ["item": item]
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: itemValue)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
           // beignBatchFetch()
        }
    }
    
    func beignBatchFetch(){
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //do calling here and appending data
            self.fetchingMore = false
            self.tableView.reloadData()
        }
    }
}
