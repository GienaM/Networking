import Foundation

public struct HTTPError : NetworkError {
    public let statusCode: Int
    public let userDescription: String?
    public let developerDescription: String?

    init(statusCode: Int, userDescription: String? = nil, developerDescription: String? = nil) {
        self.statusCode = statusCode
        self.userDescription = userDescription
        self.developerDescription = developerDescription
    }
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        if let description = self.userDescription {
            return description
        }
        if let description = self.developerDescription {
            return description
        }
        return NSLocalizedString("errorUnknown", comment: "")
    }
}
