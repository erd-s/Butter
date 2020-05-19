//
//  Created by Christopher Erdos on 5/4/20.
//

import Foundation
@testable import Butter

class MockURLProtocol: URLProtocol {
	override class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	
	override func stopLoading() { }
	
	override func startLoading() { }
}

class MockURLProtocol_Success: MockURLProtocol {
	override func startLoading() {
		let encoder = JSONEncoder()
		let data = try! encoder.encode(MockResponse())
		client?.urlProtocol(self, didLoad: data)
		client?.urlProtocolDidFinishLoading(self)
	}
}

class MockURLProtocol_Hung: URLProtocol {
	override func startLoading() {
		
	}
}

class MockURLProtocol_Failure_400Code: MockURLProtocol {
	override func startLoading() {
		let urlResponse: HTTPURLResponse = HTTPURLResponse(url: URL(string: "www.hotdog.com")!,
															statusCode: 400,
															httpVersion: nil,
															headerFields: nil)!
		client?.urlProtocol(self,
							didReceive: urlResponse,
							cacheStoragePolicy: .notAllowed)
		client?.urlProtocolDidFinishLoading(self)
	}
}

class MockURLProtocol_Failure_NetworkError: MockURLProtocol {
	override func startLoading() {
		client?.urlProtocol(self, didFailWithError: NetworkResponseError.badRequest)
	}
}
