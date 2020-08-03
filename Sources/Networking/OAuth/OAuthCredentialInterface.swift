import Alamofire

public protocol OAuthCredentialInterface {
    func authorizationHeader() -> HTTPHeaders
}
