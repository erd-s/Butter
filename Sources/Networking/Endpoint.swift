//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameter = [String: Any]

protocol Endpoint {
    var scheme: String { get }
    var path: String? { get }
    var host: String { get }
    var httpMethod: HTTPMethod { get }
    var data: RequestData { get }
    var headers: HTTPHeaders? { get }
}
