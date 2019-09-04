//
//  ConfigurableCell.swift
//  GenericTableView
//
//  Created by Anurag Kashyap on 03/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

protocol ConfigurableCellProtocol : ResuableCellProtocol{
    
    associatedtype T
    
    func configureCell(with item : T, at indexpath : IndexPath)
}
