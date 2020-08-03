import Foundation

public protocol ServerConfiguration {
    var serverProtocol: String { get }
    var host: String { get }
    var port: String? { get }
    var applicationContext: String? { get }
    func serverURL() -> URL
}

public extension ServerConfiguration {
    func serverURL() -> URL {
        let url: URL?
        if let port = port {
            url = URL(string: "\(serverProtocol)://\(host):\(port)")
        } else {
            url = URL(string: "\(serverProtocol)://\(host)")
        }

        guard let serverUrl = url else {
            preconditionFailure("Fatal error: - Failed to create valid sever url")
        }

        if let applicationContext = applicationContext {
            return serverUrl.appendingPathComponent(applicationContext)
        } else {
            return serverUrl
        }
    }
}
