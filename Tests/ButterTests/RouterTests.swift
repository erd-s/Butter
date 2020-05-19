import XCTest
@testable import Butter

final class RouterTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		unregisterURLProtocols()
	}
	
	override func tearDown() {
		unregisterURLProtocols()
		super.tearDown()
	}
	
	func unregisterURLProtocols() {
		URLProtocol.unregisterClass(MockURLProtocol_Success.self)
		URLProtocol.unregisterClass(MockURLProtocol_Hung.self)
		URLProtocol.unregisterClass(MockURLProtocol_Failure_400Code.self)
		URLProtocol.unregisterClass(MockURLProtocol_Failure_NetworkError.self)
	}
	
	func testMakeRequest_success() {
		// given
		URLProtocol.registerClass(MockURLProtocol_Success.self)
		let endpoint = MockEndpoint_NoData()
		let butter = Butter()
		
		// when
		var data: MockResponse?
		let expectation = XCTestExpectation(description: "successful completion")
		butter.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
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
		URLProtocol.registerClass(MockURLProtocol_Failure_400Code.self)
		let endpoint = MockEndpoint_NoData()
		let butter = Butter()
		
		// when
		var requestError: Error?
		let expectation = XCTestExpectation(description: "completion with error")
		
		butter.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
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
		URLProtocol.registerClass( MockURLProtocol_Failure_NetworkError.self)
		let endpoint = MockEndpoint_NoData()
		let butter = Butter()
		
		// when
		var requestError: Error?
		let expectation = XCTestExpectation(description: "completion with error")
		butter.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
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
		// given
		URLProtocol.registerClass(MockURLProtocol_Success.self)
		let endpoint = MockEndpoint_BadHost()
		let butter = Butter()
		
		// when
		var requestError: Error?
		let expectation = XCTestExpectation(description: "completion with error")
		butter.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
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
		URLProtocol.registerClass(MockURLProtocol_Success.self)
		let endpoint = MockEndpoint_NoData()
		let butter = Butter()
		
		// when
		var errorCode: Int?
		let exp = XCTestExpectation(description: "finish with cancelation")
		butter.makeRequest(responseType: MockResponse.self, endpoint: endpoint) { result in
			if case .failure(let error as NSError) = result {
				errorCode = error.code
			}
			exp.fulfill()
		}
		
		// then
		butter.cancel()
		wait(for: [exp], timeout: 0.5)
		XCTAssertEqual(errorCode, -999)
	}
}

