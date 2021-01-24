//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public typealias NetworkCompletion<T: Decodable> = (Result<T, Error>) -> ()

// MARK - Main Interface
public class Butter {
	private var task: URLSessionDataTask?
	
	public init() { }
	
    public func makeImageRequest(endpoint: Endpoint,
                                 cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                                 completion: @escaping (Result<Data, Error>) -> ()) {
		do {
			let requestBuilder = URLRequestBuilder()
			let request = try requestBuilder.request(from: endpoint, cachePolicy: cachePolicy)
			task = URLSession.shared.dataTask(with: request) { data, response, error in
				if let data = data {
					completion(.success(data))
				} else if let error = error {
					completion(.failure(error))
				} else {
					let error = ButterError.unknown(debugInfo: "No error, no data.")
					completion(.failure(error))
				}
			}
			task?.resume()
		} catch {
			completion(.failure(error))
		}
	}
	
	public func makeRequest<T: Decodable>(responseType: T.Type,
										  endpoint: Endpoint,
                                          cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
										  completion: @escaping NetworkCompletion<T>) {
        
		do {
			let requestBuilder = URLRequestBuilder()
            let request = try requestBuilder.request(from: endpoint, cachePolicy: cachePolicy)
			task = URLSession.shared.dataTask(with: request) { data, response, error in
				self.handleDataTaskResponse(using: endpoint.responseDecoder,
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
