//
//  ArrayDataAdapter.swift
//  GenericTableView
//
//  Created by Anurag Kashyap on 03/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

class ArrayDataAdapter<T> {
   
    var genericData = [T]()
    
    init(genericData : [T]) {
        self.genericData = genericData
    }
}

extension ArrayDataAdapter : TableDataProviderProtocol {
 
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return genericData.count
    }
    
    func item(at indexPath: IndexPath) -> T {
        return genericData[indexPath.row]
    }
    
    func updateItem(at indepath: IndexPath, withValue value: T) {
        genericData[indepath.row] = value
    }
    
}
