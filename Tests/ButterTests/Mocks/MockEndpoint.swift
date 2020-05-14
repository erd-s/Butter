//
//  Created by Christopher Erdos on 5/4/20.
//

import Foundation
import Butter

struct MockEndpoint_NoData: Endpoint {
	var scheme: String { "http" }
	var host: String { "localhost" }
	var port: Int? { 8070 }
	var path: String? { "/test/success" }
	var httpMethod: HTTPMethod { .get }
	var data: RequestData { .none }
	var headers: HTTPHeaders? { ["X-Auth-Zero_Force": "yaMaMs"] }
}

struct MockEndpoint_WithParamData: Endpoint {
	var scheme: String { "http" }
	var host: String { "localhost" }
	var port: Int? { 8070 }
	var path: String? { "/test/success" }
	var httpMethod: HTTPMethod { .get }
	var data: RequestData {
		.params(params: ["person": "vin disel"])
	}
	var headers: HTTPHeaders? { ["X-Auth-Zero_Force": "yaMaMs"] }
}

struct MockEndpoint_WithEmptyParamNameData: Endpoint {
	var scheme: String { "http" }
	var host: String { "localhost" }
	var port: Int? { 8070 }
	var path: String? { "/test/success" }
	var httpMethod: HTTPMethod { .get }
	var data: RequestData {
		.params(params: ["": "vin diels"])
	}
	var headers: HTTPHeaders? { ["X-Auth-Zero_Force": "yaMaMs"] }
}

struct MockEndpoint_WithBodyData: Endpoint {
	var scheme: String { "http" }
	var host: String { "localhost" }
	var port: Int? { 8070 }
	var path: String? { "/test/success" }
	var httpMethod: HTTPMethod { .get }
	var data: RequestData { .body(body: Data()) }
	var headers: HTTPHeaders? { nil }
}

struct MockEndpoint_BadHost: Endpoint {
	var scheme: String { "" }
	var host: String { "/%&!" }
	var port: Int? { nil }
	var path: String? { "" }
	var httpMethod: HTTPMethod { .get }
	var data: RequestData { .none }
	var headers: HTTPHeaders? { nil }
}
