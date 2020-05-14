//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import Butter

struct GetMoviesRequest: Endpoint {
	var scheme: String { "http" }
	
	var host: String { "localhost" }
	
	var port: Int? { 8070 }
	
	var path: String? { "movies" }
	
	var httpMethod: HTTPMethod { .get }
	
	var data: RequestData { .params(params: ["name": "vin disel"]) }
	
	var headers: HTTPHeaders? { ["ContentType": "application/json"] }
}

struct GetMoviesResponse: Decodable, CustomStringConvertible {
	let movieList: [String]
	
	var description: String {
		return movieList.joined(separator: "\n")
	}
	
	enum CodingKeys: String, CodingKey {
		case movieList = "movie_list"
	}
}
