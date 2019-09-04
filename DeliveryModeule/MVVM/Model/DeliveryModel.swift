//
//  DeliveryModel.swift
//  SampleProject
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

struct DeliveryModel: Codable {
    let deliveryID: Int
    let description: String?
    let imageUrl: String?
    let location: LocationModel?
    
    enum CodingKeys: String, CodingKey {
        case deliveryID = "id"
        case description
        case imageUrl
        case location
    }
}

struct LocationModel: Codable {
    let latitude: Double?
    let longitude: Double?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case address
    }
}

