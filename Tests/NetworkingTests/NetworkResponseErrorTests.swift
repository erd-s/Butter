//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import XCTest
@testable import Networking

class NetworkResponseErrorTests: XCTestCase {
    func testInit_Failure() {
        // given
        let statusCode: Int = 200
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertNil(error)
    }
    
    func testInit_badRequest() {
        // given
        let statusCode: Int = 400
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.badRequest)
    }
    
    func testInit_notAuthorized() {
        // given
        let statusCode: Int = 401
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.notAuthorized)
    }
    
    func testInit_forbidden() {
        // given
        let statusCode: Int = 403
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.forbidden)
    }
    
    func testInit_notFound() {
        // given
        let statusCode: Int = 404
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.notFound)
    }
    
    func testInit_internalServerError() {
        // given
        let statusCode: Int = 500
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.internalServerError)
    }
    
    func testInit_badGateway() {
        // given
        let statusCode: Int = 502
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.badGateway)
    }
    
    func testInit_unknown() {
        // given
        let statusCode: Int = 666
        
        // when
        let error = NetworkResponseError(statusCode: statusCode)
        
        // then
        XCTAssertEqual(error, NetworkResponseError.unknown(statusCode: statusCode))
    }
    
    
}
