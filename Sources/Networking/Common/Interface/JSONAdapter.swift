import Foundation

public protocol JSONAdapter: class {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    func decodeToArray<R: Decodable>(from json: Any) throws -> [R]
    func decodeToObject<R: Decodable>(from json: [String: Any]) throws -> R
    func encodeToJSON<R: Encodable>(from object: R) throws -> [String: Any]
    func encodeToJSONArray<R: Encodable>(from array: [R]) throws -> Any
}

public extension JSONAdapter {
    func decodeToArray<R: Decodable>(from json: Any) throws -> [R] {
        let data = try JSONSerialization.data(withJSONObject: json)
        let remoteList = try data.decoded(using: self.decoder) as [R]

        return remoteList
    }

    func decodeToObject<R: Decodable>(from json: [String: Any]) throws -> R {
        let data = try JSONSerialization.data(withJSONObject: json)
        let object = try data.decoded(using: self.decoder) as R

        return object
    }

    func encodeToJSON<R: Encodable>(from object: R) throws -> [String: Any] {
        if let json = try JSONSerialization.jsonObject(with: try object.encoded(using: self.encoder), options: []) as? [String: Any] {
            return json
        }
        return [:]
    }

    func encodeToJSONArray<R: Encodable>(from array: [R]) throws -> Any {
        return try array.map { try JSONSerialization.jsonObject(with: try $0.encoded(using: self.encoder), options: []) }
    }
}
