//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameter = [String: Any]

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var data: RequestData { get }
    var headers: HTTPHeaders? { get }
	var responseDecoder: JSONDecoder { get }
}

public extension Endpoint {
	// Default decoder if none is supplied
	var responseDecoder: JSONDecoder {
		return JSONDecoder()
	}
}
