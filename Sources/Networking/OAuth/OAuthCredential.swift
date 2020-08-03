import Foundation
import Alamofire

public struct OAuthCredential {

    // MARK: - Public properties

    public let accessToken: String
    public let tokenType: String
    public let refreshToken: String?
    public let expirationDate: Date?

    public var isExpired: Bool {
        return self.expirationDate?.compare(Date()) == .orderedAscending
    }

    // MARK: - Initialization

    public init(
        accessToken: String,
        tokenType: String,
        refreshToken: String? = nil,
        expirationDate: Date? = nil) {

        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.expirationDate = expirationDate
    }
}

// MARK: - OAuthCredentialInterface

extension OAuthCredential: OAuthCredentialInterface {
    public func authorizationHeader() -> HTTPHeaders {
        var header = HTTPHeaders()
        header["Authorization"] = "\(tokenType) \(accessToken)"

        return header
    }
}
