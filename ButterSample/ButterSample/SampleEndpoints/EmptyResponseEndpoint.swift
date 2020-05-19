//
//  Created by Chris Erdos on 5/11/20
//

import Foundation
import Butter

struct EmptyResponseEndpoint: Endpoint {
	var scheme: String { "http" }
	
	var host: String { "localhost" }
	
	var port: Int? { 8070 }
	
	var path: String? { "empty" }
	
	var httpMethod: HTTPMethod { .get }
	
	var data: RequestData { .none }
	
	var headers: HTTPHeaders? { nil }
}

struct EmptyResponse: Decodable, CustomStringConvertible {
	var description: String {
		return "success"
	}
}
