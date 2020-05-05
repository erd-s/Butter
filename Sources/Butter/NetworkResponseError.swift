//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public enum NetworkResponseError: Error, Equatable {
    case badRequest
    case notAuthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case unknown(statusCode: Int)
    
    
    init?(statusCode: Int) {
        guard statusCode >= 400 else {
            return nil
        }
        
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .notAuthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 500:
            self = .internalServerError
        case 502:
            self = .badGateway
        default:
            self = .unknown(statusCode: statusCode)
        }
    }
}
