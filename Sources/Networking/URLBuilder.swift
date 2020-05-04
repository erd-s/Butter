//
//  Created by Chris Erdos on 5/4/20
//

import Foundation

private extension Encodable {
    func json() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}

public struct URLRequestBuilder {
    public func request(from endpoint: Endpoint) throws -> URLRequest {
        let url = try makeURL(scheme: endpoint.scheme,
                              host: endpoint.host,
                              port: endpoint.port,
                              path: endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        try setData(request: &request, data: endpoint.data)
        if let headers = endpoint.headers {
            setHeaders(&request, headers: headers)
        }
        return request
    }
    
    func makeURL(scheme: String, host: String, port: Int?, path: String?) throws -> URL {
        var baseURLString = scheme + "://" + host
        
        if let port = port {
            baseURLString.append(":\(port)")
        }
        
        guard var url = URL(string: baseURLString) else {
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
        case .none:
            break
        }
        
        request.url = components.url
    }
    
    func setHeaders(_ request: inout URLRequest, headers: HTTPHeaders) {
        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
}
