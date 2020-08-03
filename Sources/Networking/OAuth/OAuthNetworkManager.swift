import Alamofire

open class OAuthNetworkManager: NetworkAccessManager {

    open override func sessionOperation(
        URLString: String,
        method: HTTPMethod,
        parameters: Parameters?,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        success: (([String : Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

    }
}
