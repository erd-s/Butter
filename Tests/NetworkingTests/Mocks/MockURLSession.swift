//
//  Created by Christopher Erdos on 5/4/20.
//

import Foundation
@testable import Networking

class MockURLSession_Success: URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data: Data? = Data()
        let urlResponse: URLResponse? = nil
        let error: Error? = nil
        
        completionHandler(data, urlResponse, error)
        return URLSessionDataTask()
    }
}

class MockURLSession_Hung: URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}

class MockURLSession_Failure_400Code: URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data: Data? = nil
        let urlResponse: HTTPURLResponse? = HTTPURLResponse(url: URL(string: "www.hotdog.com")!,
                                                            statusCode: 400,
                                                            httpVersion: nil,
                                                            headerFields: nil)
        let error: Error? = nil
        
        completionHandler(data, urlResponse, error)
        return URLSessionDataTask()
    }
}

class MockURLSession_Failure_NetworkError: URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data: Data? = nil
        let urlResponse: URLResponse? = nil
        let error: Error? = NetworkResponseError.methodNotAllowed
        
        completionHandler(data, urlResponse, error)
        return URLSessionDataTask()
    }
}
