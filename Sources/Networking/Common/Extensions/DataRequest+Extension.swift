import Alamofire

public extension DataRequest {
    func validateBodyStatusCode() -> Self {
        return validate { request,response,data in
            let statusCode = response.statusCode
            if statusCode == 401  {
                let reason: AFError.ResponseValidationFailureReason = .unacceptableStatusCode(
                    code: statusCode)

                return .failure(AFError.responseValidationFailed(reason: reason))
            } else {
                return .success
            }
        }
    }
}
