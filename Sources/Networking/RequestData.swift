//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

enum RequestData {
    case params(params: [String: String])
    case body(body: Encodable)
}


