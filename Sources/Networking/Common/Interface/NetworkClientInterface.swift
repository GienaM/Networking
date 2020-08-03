import Foundation
import Alamofire

public protocol NetworkClientInterface {
    var manager: NetworkAccessManager { get }
}

// MARK: - HTTP support

public extension NetworkClientInterface {
    private func sessionOperation(
        URLString: String,
        method: HTTPMethod,
        parameters: Parameters?,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        return self.manager.sessionOperation(
            URLString: URLString,
            method: method,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            headers: headers,
            success: success,
            failure: failure)
    }

    func GET(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .get,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }

    func HEAD(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .head,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }

    func POST(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .post,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }

    func PUT(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .put,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }

    func PATCH(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .patch,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }

    func DELETE(
        URLString: String,
        parameters: Parameters? = nil,
        queryParameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        success: (([String: Any]) -> Void)?,
        failure: ((NetworkError) -> Void)?) {

        self.sessionOperation(
            URLString: URLString,
            method: .delete,
            parameters: parameters,
            queryParameters: queryParameters,
            encoding: encoding,
            success: success,
            failure: failure)
    }
}
