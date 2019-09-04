//
//  DeliveryVM.swift
//  DeliveryModeule
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

import UIKit

class DeliveryVM: NSObject {
    
    var deliveryID : Int
    var desc : String
    var imageUrl : String
    var locationDetails : LocationModel?
    
    init(delivery : DeliveryModel) {
        self.deliveryID = delivery.deliveryID
        self.desc = delivery.description!
        self.imageUrl = delivery.imageUrl!
        self.locationDetails = delivery.location
    }
}
