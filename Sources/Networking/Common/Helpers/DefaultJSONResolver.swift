//
//  File.swift
//  
//
//  Created by Gienadij Mackiewicz on 03/08/2020.
//

import Alamofire
import Foundation

public class DefaultJSONResolver: JSONResponseResolver {



    // MARK: - Public attributes

    public let logger: LoggerInterface?

    // MARK: - Initialization

    public init(logger: LoggerInterface?) {
        self.logger = logger
    }

    // MARK: - Public methods

    public func resolve(response: DataResponse<Any>, components: JSONTaskComponents) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            let statusCode: HTTPStatus

            if let rawValue = response.response?.statusCode,
                let code = HTTPStatus(rawValue: rawValue) {
                statusCode = code
            } else {
                statusCode = HTTPStatus.unknown
            }

            self?.logger?.log("URL: \(components.url)")

            switch response.result {

            case .success(let data):

                if let json = data as? [String: Any] {
                    if !statusCode.isSuccessCode {
                        let userDescription = json["message"] as? String
                        let developerDescription = json["error_description"] as? String

                        let error = HTTPError(
                            statusCode: statusCode.rawValue,
                            userDescription: userDescription,
                            developerDescription: developerDescription)

                        self?.logger?.log("Response Error:\n\t description = \(error.localizedDescription)\n\t code = \(statusCode)")

                        DispatchQueue.main.sync {
                            components.failure?(error)
                        }
                    } else {
                        self?.logger?.log("Response JSON: \(data)")

                        DispatchQueue.main.sync {
                            components.success?(json)
                        }
                    }
                } else if let array = data as? [[String: Any]] {
                    // Workaround when server returns flat array of objects
                    DispatchQueue.main.sync {
                        components.success?(["content": array])
                    }
                } else {
                    self?.logger?.log("Casting Error:\n\t data = \(data)")

                    DispatchQueue.main.sync {
                        components.failure?(
                            HTTPError(
                                statusCode: statusCode.rawValue,
                                userDescription: NSLocalizedString("errorInvalidData", comment: "")))
                    }
                }

            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.logger?.log("Request error with error: \(error)")
                    components.failure?(
                        HTTPError(
                            statusCode: (error as NSError).code,
                            userDescription: error.localizedDescription))
                }
            }
        }
    }
}
