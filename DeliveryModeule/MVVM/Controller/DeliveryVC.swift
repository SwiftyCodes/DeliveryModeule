//
//  DeliveryVC.swift
//  SampleProject
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class DeliveryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var dataManager: DataManagerProtocol? = DataManager.shared
    typealias CompletionBlock = (_ response: Any?, _ error: Error?) -> Void

    var deliveryVMArray : [DeliveryVM] = []
    var provider : ArrayDataAdapter<DeliveryVM> {
        return ArrayDataAdapter<DeliveryVM>(genericData: deliveryVMArray)
    }
    
    fileprivate var dataSource  : TableViewDataSource<ArrayDataAdapter<DeliveryVM>, DeliveryTableViewCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        dataManager?.fetchData(offset: offset, limit: limit, completionHandler: { (jsonData, error, statusCode) in
            guard statusCode == 200, let json = jsonData else {return}
            
            let decodedJSON = try? JSONDecoder().decode([DeliveryModel].self, from: json)
            print("Decoded JSON Value is \(decodedJSON!)")
            DataManager.shared.dbManager.saveDeliveries(deliveries: decodedJSON!)
            self.deliveryVMArray = decodedJSON?.map({return DeliveryVM(delivery: $0) }) ?? []
            DispatchQueue.main.async {
                self.dataSource = TableViewDataSource<ArrayDataAdapter<DeliveryVM>, DeliveryTableViewCell>(tableView: self.tableView, provider: self.provider)
            }
        })
    }
    
    var locationObject : DeliveryVM? = nil
    @objc func methodOfReceivedNotification(notification: Notification) {
        performSegue(withIdentifier: "MapVC", sender: nil)
        if let item = notification.userInfo?["item"] as? DeliveryVM {
            locationObject = item
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapVC" {
            let vc = segue.destination as! MapVC
            vc.mapValue = locationObject
        }
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
}
