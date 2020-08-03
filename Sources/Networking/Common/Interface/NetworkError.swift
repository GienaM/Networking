import Foundation

public protocol NetworkError: Error {
    var statusCode: Int { get }
    var developerDescription: String? { get }
}
