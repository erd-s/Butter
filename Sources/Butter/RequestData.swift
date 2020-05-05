//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

public enum RequestData {
    case none
    case params(params: [String: String])
    case body(body: Encodable)
}
