//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public typealias NetworkCompletion<T: Decodable> = (Result<T, Error>) -> ()

// MARK - Injection Point for URLSession
public protocol URLSessionDataTaskInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionDataTaskInterface { }

// MARK - Main Router Interface
public class Router {
    private var task: URLSessionDataTask?
    private var session: URLSessionDataTaskInterface
    
    public init(session: URLSessionDataTaskInterface = URLSession.shared) {
        self.session = session
    }
    
	public func makeRequest<T: Decodable>(responseType: T.Type,
										  endpoint: Endpoint,
										  decoder: JSONDecoder = JSONDecoder(),
                                          completion: @escaping NetworkCompletion<T>) {
        do {
            let requestBuilder = URLRequestBuilder()
            let request = try requestBuilder.request(from: endpoint)
            task = session.dataTask(with: request) { data, response, error in
				self.handleDataTaskResponse(using: decoder,
											data: data,
                                            response: response,
                                            error: error,
                                            completion: completion)
            }
            task?.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
	private func handleDataTaskResponse<T: Decodable>(using decoder: JSONDecoder,
													  data: Data?,
                                                      response: URLResponse?,
                                                      error: Error?,
                                                      completion: NetworkCompletion<T>) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let response = response as? HTTPURLResponse,
            let error = NetworkResponseError(statusCode: response.statusCode) {
            completion(.failure(error))
		} else if let data = data {
			do {
				let ret = try decoder.decode(T.self, from: data)
				completion(.success(ret))
			} catch {
				completion(.failure(error))
			}
		} else {
			let error = ButterError.unknown(debugInfo: "No error, no data.")
			completion(.failure(error))
        }
    }
    
    public func cancel() {
        task?.cancel()
    }
}
