//
//  TableDataProvider.swift
//  GenericTableView
//
//  Created by Anurag Kashyap on 03/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

protocol TableDataProviderProtocol {
    
    associatedtype T
    
    func numberOfSection() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath : IndexPath) -> T // To get Item at that particular Cell
    func updateItem(at indepath: IndexPath, withValue value : T)
}
