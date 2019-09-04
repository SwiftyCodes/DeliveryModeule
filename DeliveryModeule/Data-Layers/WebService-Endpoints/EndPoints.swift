
import Foundation

enum URLBuilder {
    enum Components: String {
        case schemeHTTPS = "https"
        case host = "mock-api-mobile.dev.lalamove.com"
        case deliveries = "/deliveries"
    }
}

enum URLBuilderItunes {
    enum Components: String {
        case schemeHTTPS = "https"
        case host = "itunes.apple.com/search?media=music&term"
        case deliveries = "=bollywood"
    }
}
