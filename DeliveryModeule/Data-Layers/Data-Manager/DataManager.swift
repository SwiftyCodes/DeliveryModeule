
import Foundation
import UIKit

class DataManager: DataManagerProtocol {
    var completionHandler: CompletionBlock!
    var responseBlockHandler : ResponseBlock!
    let offsetJsonKey   = "offset"
    let limitJsonKey    = "limit"
    var dbManager: DBManagerProtocol = DBManager.sharedInstance
    var apiManager: APIManagerProtocol = APIManager()
    var components = URLComponents()
    static let shared = DataManager()
    
    private init() {}

    func getDeliveryEndPoint(offset: Int, limit: Int) -> String {
        components.scheme = URLBuilder.Components.schemeHTTPS.rawValue
        components.host = URLBuilder.Components.host.rawValue
        components.path = URLBuilder.Components.deliveries.rawValue
        components.queryItems = [
            URLQueryItem(name: offsetJsonKey, value: "\(offset)"),
            URLQueryItem(name: limitJsonKey, value: "\(limit)")
        ]
        return components.string!
    }
    
    func fetchData(offset: Int, limit: Int, completionHandler: @escaping CompletionBlock) {
        self.completionHandler = completionHandler
        
        guard Connectivity.isConnectedToInternet else {
            fetchListFromDB(offset: offset, limit: limit)
            return
        }
        
        apiManager.GETApi(getDeliveryEndPoint(offset: offset, limit: limit), param: [:], header: [:]) { (data, error, statusCode) in
            if error == nil, let deliveries = data {
               // self.dbManager.saveDeliveries(deliveries: deliveries) // save deliveries in DB
                completionHandler(deliveries, nil, statusCode)
            } else {
                self.fetchListFromDB(offset: offset, limit: limit, serverError: error)
            }
        }
    }
    
    // MARK: DB handling
    private func fetchListFromDB(offset: Int, limit: Int, serverError: Error? = nil) {
        dbManager.getDeliveries(offset: offset, limit: limit) { [weak self] deliveries, dbError in
            guard let weakSelf = self else { return }
            guard dbError == nil, let deliveriesValues = deliveries, !deliveriesValues.isEmpty  else {
                weakSelf.responseBlockHandler(nil, dbError)
                return
            }
            weakSelf.responseBlockHandler(deliveriesValues, nil)
        }
    }
    
}
