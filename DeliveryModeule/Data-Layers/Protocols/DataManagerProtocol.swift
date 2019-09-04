
import Foundation

protocol DataManagerProtocol {
    typealias CompletionBlock = (_ response: Data?, _ error: Error?,  _ statuscode : Int?) -> Void
    func fetchData(offset: Int, limit: Int, completionHandler: @escaping CompletionBlock)
}
