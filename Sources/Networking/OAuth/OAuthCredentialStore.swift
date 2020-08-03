import Foundation

/// A (persistent) credential store.
public protocol OAuthCredentialStore {
    /// Stores the given access token.
    ///
    /// Given nil, it resets the currently stored credential, if any.
    ///
    /// - parameter credential: The credential to be stored.
    func storeCredential(_ credential: OAuthCredentialInterface?)

    /// Retrieves the currently stored credential.
    ///
    /// - returns: The currently stored credential.
    func retrieveCredential() -> OAuthCredentialInterface?
}
