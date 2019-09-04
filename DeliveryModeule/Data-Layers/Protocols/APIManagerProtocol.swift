
import Foundation
import SwiftyJSON

protocol APIManagerProtocol {
    typealias CompletionBlock = (_ response: Data?, _ error: Error?,  _ statuscode : Int?) -> Void
    func GETApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock)
    func POSTApi(_ url: String, param: [String: Any]?, header : [String : String]?, completion: @escaping CompletionBlock)
    func PUTApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock)
    func DELETEApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion: @escaping CompletionBlock)
    func UploadFile(_ url :String , _ data:Data, _ fileName:String , _ docID:String ,_ group:String , completion: @escaping CompletionBlock)
    func UploadRecord(_ url :String , _ data:Data, _ fileName:String? , paremes:[String:Any]? , header:[String:String]?, completion:@escaping CompletionBlock)
    func UploadProfilePicFile(_ url :String , data:Data, fileName:String ,header : [String:String]?, completion:@escaping CompletionBlock)
    func UploadFamilyMemberPic(_ url :String , data:Data, fileName:String ,id : Int,header : [String:String]?, completion:@escaping CompletionBlock)
    func loadImage(_ url:String)  ->UIImage?
}
