import Alamofire

public protocol JSONResponseResolver {
    var logger: LoggerInterface? { get }
    func resolve(response: DataResponse<Any>, components: JSONTaskComponents)
}
