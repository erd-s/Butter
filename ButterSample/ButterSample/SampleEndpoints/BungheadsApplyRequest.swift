//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import Butter

struct JasonDeruloBunghead: Encodable {
	let first = "jason"
	let last = "derulo"
	let occupation = "unknown"
}

struct BungheadsApplyRequest: Endpoint {
	var scheme: String { "http" }
	
	var host: String { "localhost" }
	
	var port: Int? { 8070 }
	
	var path: String? { "bungheads/apply/" }
	
	var httpMethod: HTTPMethod { .post }
	
	var data: RequestData { .body(body: JasonDeruloBunghead()) }
	
	var headers: HTTPHeaders? { ["X-Some-Header": "Some-Header-Argument"] }
	
	var responseDecoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		return decoder
	}
}

struct BungheadResponse: Decodable, CustomStringConvertible {
	let identifier: String
	let created_at: Date
	
	var description: String {
		"""
		id: \(identifier)
		created_at: \(created_at)
		"""
	}
}
