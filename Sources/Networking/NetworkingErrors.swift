//
//  Created by Christopher Erdos on 5/1/20.
//

import Foundation

enum NetworkingRequestError: Error {
    case couldNotConstructURLFromHost(host: String)
    case couldNotConstructURLComponents(url: URL?)
}
