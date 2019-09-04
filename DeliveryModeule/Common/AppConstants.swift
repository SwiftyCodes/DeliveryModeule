
import Foundation
import UIKit

var offset = 0
let limit = 20
let offsetJsonKey   = "offset"
let limitJsonKey    = "limit"

struct AppConstants {
    static let networkTimeoutInterval: TimeInterval = 10
    static let dataUserDefaults = UserDefaults.standard
    static var sharedAppDelegate: AppDelegate? {
        return  UIApplication.shared.delegate as? AppDelegate ?? nil
    }
    static let serverErrorDomain = "HTTP Error"
    static let serverErrorCode = 500
    static let numberOfLines = 0
}

struct AppThemes {
    static let themeColor: UIColor = .orange
    static let navTintColor: UIColor = .white
    static let textColorLight: UIColor = .white
    static let textColorDark: UIColor = .black
}
