//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public typealias NetworkCompletion = (Result<Data?, Error>) -> ()

// MARK - Injection Point for URLSession
public protocol URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionDataTaskInterface { }

// MARK - Main Router Interface
public class Router {
    private var task: URLSessionDataTask?
    
    public init() { }
    
    public func makeRequest(sessionInterface: URLSessionDataTaskInterface? = nil,
                            endpoint: Endpoint,
                            completion: @escaping NetworkCompletion) {
        let session = sessionInterface ?? URLSession.shared
        do {
            let requestBuilder = URLRequestBuilder()
            let request = try requestBuilder.request(from: endpoint)
            task = session.dataTask(with: request) { data, response, error in
                self.handleDataTaskResponse(data: data,
                                            response: response,
                                            error: error,
                                            completion: completion)
            }
            task?.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    private func handleDataTaskResponse(data: Data?,
                                        response: URLResponse?,
                                        error: Error?,
                                        completion: NetworkCompletion) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let response = response as? HTTPURLResponse,
            let error = NetworkResponseError(statusCode: response.statusCode) {
            completion(.failure(error))
        } else {
            completion(.success(data))
        }
    }
    
    public func cancel() {
        task?.cancel()
    }
}
