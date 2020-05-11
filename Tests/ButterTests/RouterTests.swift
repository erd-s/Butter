import XCTest
@testable import Butter

final class RouterTests: XCTestCase {
    func testMakeRequest_success() {
        // given
        let session = MockURLSession_Success()
        let router = Router(session: session)
        let endpoint = MockEndpoint_NoData()
        
        // when
        var data: MockResponse?
        let expectation = XCTestExpectation(description: "successful completion")
		router.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
            if case .success(let resultData) = result {
                data = resultData
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertNotNil(data)
    }
    
    func testMakeRequest_failure_status400() {
        // given
        let session = MockURLSession_Failure_400Code()
        let router = Router(session: session)
        let endpoint = MockEndpoint_NoData()
        
        // when
        var requestError: Error?
        let expectation = XCTestExpectation(description: "completion with error")
	
        router.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
            if case .failure(let error) = result {
                requestError = error
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertNotNil(requestError)
    }
    
    func testMakeRequest_failure_networkFailure() {
        let session = MockURLSession_Failure_NetworkError()
        let router = Router(session: session)
        let endpoint = MockEndpoint_NoData()
        
        // when
        var requestError: Error?
        let expectation = XCTestExpectation(description: "completion with error")
        router.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
            if case .failure(let error) = result {
                requestError = error
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertNotNil(requestError)
    }
    
    func testMakeRequest_failure_invalidEndpoint() {
        let session = MockURLSession_Success()
        let router = Router(session: session)
        let endpoint = MockEndpoint_BadHost()
        
        // when
        var requestError: Error?
        let expectation = XCTestExpectation(description: "completion with error")
        router.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
            if case .failure(let error) = result {
                requestError = error
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertNotNil(requestError)
    }
    
    func testTaskCancellation() {
        // given
        let session = URLSession.shared
        let router = Router(session: session)
        let endpoint = MockEndpoint_NoData()
        
        // when
        var errorCode: Int?
        let exp = XCTestExpectation(description: "finish with cancelation")
        router.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
            if case .failure(let error as NSError) = result {
                errorCode = error.code
            }
            exp.fulfill()
        }
        
        // then
        router.cancel()
        wait(for: [exp], timeout: 0.5)
        XCTAssertEqual(errorCode, -999)
    }
}

