//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import Butter

struct SampleRequestBodyB: Encodable {
	let first = "jason"
	let last = "derulo"
	let occupation = "unknown"
}

struct SampleEndpointB: Endpoint {
    var scheme: String { "http" }
    
    var host: String { "localhost" }
    
    var port: Int? { 8070 }
    
    var path: String? { "bungheads/apply/" }
    
    var httpMethod: HTTPMethod { .post }
    
    var data: RequestData { .body(body: SampleRequestBodyB()) }
    
    var headers: HTTPHeaders? { ["X-Some-Header": "Some-Header-Argument"] }
	
	var responseDecoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		return decoder
	}
}

struct SampleResponseB: Decodable, CustomStringConvertible {
	let identifier: String
	let created_at: Date
	
	var description: String {
		"""
		id: \(identifier)
		created_at: \(created_at)
		"""
	}
}
