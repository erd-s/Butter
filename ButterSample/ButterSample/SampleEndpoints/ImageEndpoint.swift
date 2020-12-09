//
//  File.swift
//  
//
//  Created by Christopher Erdos on 12/8/20.
//

import Foundation
import Butter

class ImageEndpoint: Endpoint {
	var scheme: String = "https"
	
	var host: String = "freight.cargo.site"
	
	var port: Int?
	
	var path: String? = "w/2250/i/2088be3ac46bccad6597d1fbdaa6bdf954b5bc38901237bd19251b958ddcaadb/IMG_2844.jpg"
	
	var httpMethod: HTTPMethod = .get
	
	var data: RequestData = .none
	
	var headers: HTTPHeaders?
}
