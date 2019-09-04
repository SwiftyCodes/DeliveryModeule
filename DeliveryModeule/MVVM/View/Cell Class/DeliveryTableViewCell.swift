//
//  DeliveryTableViewCell.swift
//  DeliveryModeule
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//


import UIKit

class DeliveryTableViewCell: UITableViewCell, ConfigurableCellProtocol {
    
    typealias T = DeliveryVM
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(with item: DeliveryTableViewCell.T, at indexpath: IndexPath) {
        self.idLabel.text = "\(item.deliveryID)"
        self.descriptionLabel.text = item.desc
        self.imageview.imageFromURL(urlString: (item.imageUrl))
    }
}
