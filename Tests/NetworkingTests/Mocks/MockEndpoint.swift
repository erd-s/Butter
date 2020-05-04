//
//  File.swift
//  
//
//  Created by Christopher Erdos on 5/4/20.
//

import Foundation
@testable import Networking

struct MockEndpointSuccess: Endpoint {
    var scheme: String { "http" }
    var host: String { "localhost" }
    var port: Int? { 8070 }
    var path: String? { "/test/success" }
    var httpMethod: HTTPMethod { .get }
    var data: RequestData { .none }
    var headers: HTTPHeaders? { nil }
}

struct MockEndpointBadHost: Endpoint {
    var scheme: String { "" }
    var host: String { "/%&!" }
    var port: Int? { nil }
    var path: String? { "" }
    var httpMethod: HTTPMethod { .get }
    var data: RequestData { .none }
    var headers: HTTPHeaders? { nil }
}
