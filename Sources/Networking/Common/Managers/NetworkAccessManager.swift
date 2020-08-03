import Foundation
import Alamofire

open class NetworkAccessManager {

    // MARK: - Public attributes

    public let serverConfiguration: ServerConfiguration

    // MARK: - Private attributes

    private let resolver: JSONResponseResolver
    private var session: SessionManager

    // MARK: - Initialization

    public init(
        serverConfiguration: ServerConfiguration,
        sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
        delegate: SessionDelegate = SessionDelegate(),
        resolver: JSONResponseResolver,
        adapter: RequestAdapter? = nil,
        retrier: RequestRetrier? = nil,
        serverTrustManager: ServerTrustPolicyManager? = nil) {

        self.serverConfiguration = serverConfiguration
        self.resolver = resolver

        sessionConfiguration.urlCredentialStorage = nil
        let session = SessionManager(
            configuration: sessionConfiguration,
            delegate: delegate,
            serverTrustPolicyManager: serverTrustManager)

        session.adapter = adapter
        session.retrier = retrier
        self.session = session
    }

    // MARK: - Open methods

    open func sessionOperation(
        URLString: String,
        method: HTTPMethod,
        parameters: Parameters?,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        var url = serverConfiguration.serverURL().appendingPathComponent(URLString)
        if let queryParameters = queryParameters {
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryParameters.compactMap({ parameter -> URLQueryItem? in
                let value: String?
                if let boolValue = parameter.value as? Bool {
                    value = String(boolValue)
                } else {
                    value = parameter.value as? String
                }
                return URLQueryItem(name: parameter.key, value: value)
            })
            url = urlComponents?.url ?? serverConfiguration.serverURL().appendingPathComponent(URLString)
        }

        let components = URLSessionTaskComponents(
            url: url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            success: success,
            failure: failure)


        self.session.request(
            components.url,
            method: components.method,
            parameters: components.parameters,
            encoding: components.encoding,
            headers: components.headers)
            .validateBodyStatusCode()
            .responseJSON(completionHandler: { [weak self] response in
                self?.resolver.resolve(response: response, components: components)
            })
    }
}
