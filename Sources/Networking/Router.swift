//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

typealias NetworkCompletion = (Result<Data?, Error>) -> ()

// MARK - Main Router Interface
class Router {
    private var task: URLSessionTask?
    
    func makeRequest(endpoint: Endpoint, completion: @escaping NetworkCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: endpoint)
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
    
    func cancel() {
        task?.cancel()
    }
}

private extension Encodable {
    func json() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}

// MARK - Private Helper Methods
private extension Router {
    func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        let url = try makeBaseURLWithPath(host: endpoint.host, path: endpoint.path)
        var request = URLRequest(url: url)
        try setData(request: &request, data: endpoint.data)
        if let headers = endpoint.headers {
            setHeaders(&request, headers: headers)
        }
        return request
    }
    
    func makeBaseURLWithPath(host: String, path: String?) throws -> URL {
        guard var url = URL(string: host) else {
            throw NetworkingRequestError.couldNotConstructURLFromHost(host: host)
        }
        
        if let path = path {
            url.appendPathComponent(path)
        }
        
        return url
    }
    
    func setData(request: inout URLRequest, data: RequestData) throws {
        guard
            let url = request.url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {
                throw NetworkingRequestError.couldNotConstructURLComponents(url: request.url)
        }
        
        switch data {
        case .body(let body):
            request.httpBody = try body.json()
        case .params(let params):
            components.queryItems = params.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        request.url = components.url
    }
    
    func setHeaders(_ request: inout URLRequest, headers: HTTPHeaders) {
        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
    func handleDataTaskResponse(data: Data?,
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
}
