//
//  Created by Chris Erdos on 5/5/20
//

import Foundation
import Butter

struct SampleEndpointC: Endpoint {
    var scheme: String { "http" }
    
    var host: String { "localhost" }
    
    var port: Int? { 8070 }
    
    var path: String? { "/test/c" }
    
    var httpMethod: HTTPMethod { .get }
    
    var data: RequestData { .none }
    
    var headers: HTTPHeaders? { ["X-Some-Header": "Some-Header-Argument"] }
}
