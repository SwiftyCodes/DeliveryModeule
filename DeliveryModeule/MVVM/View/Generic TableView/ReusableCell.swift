//
//  ReusableCell.swift
//  GenericTableView
//
//  Created by Anurag Kashyap on 03/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

protocol ResuableCellProtocol {
    static var resuseIdentifier : String {get}
}

extension ResuableCellProtocol {
    static var resuseIdentifier : String {
        return String(describing: self) // Return the name of the class who implements it
    }
}
