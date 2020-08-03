import Alamofire

public protocol JSONTaskComponents {
    var url: URLConvertible { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var success: (([String: Any]) -> Void)? { get }
    var failure: ((NetworkError) -> Void)? { get }
}
