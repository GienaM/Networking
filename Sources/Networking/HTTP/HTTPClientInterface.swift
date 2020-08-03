import Foundation
import Alamofire

public protocol HTTPClientInterface: NetworkClientInterface {
    var timeoutInterval: TimeInterval { get }
}


