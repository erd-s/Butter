//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import Butter

struct SampleEndpointC: Endpoint {
	var scheme: String { "http" }
	
	var host: String { "localhost" }
	
	var port: Int? { 8070 }
	
	var path: String? { "time" }
	
	var httpMethod: HTTPMethod { .get }
	
	var data: RequestData { .none }
	
	var headers: HTTPHeaders? { ["X-Some-Header": "Some-Header-Argument"] }
	
	var responseDecoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		return decoder
	}
}

struct SampleResponseC: Decodable, CustomStringConvertible {
	let time: Date
	
	var description: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .full
		dateFormatter.timeStyle = .full
		return dateFormatter.string(from: self.time)
	}
}
