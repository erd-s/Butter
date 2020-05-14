//
//  Created by Chris Erdos on 5/5/20
//

import UIKit
import Butter

class ViewController: UIViewController {
	
	@IBOutlet weak var outputTextView: UITextView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func makeRequest<T: Decodable>(responseType: T.Type, at endpoint: Endpoint) {
		spinner.startAnimating()
		Butter.shared.makeRequest(responseType: responseType, endpoint: endpoint) { result in
			DispatchQueue.main.async {
				self.spinner.stopAnimating()
				switch result {
				case .success(let data):
					self.setOutputTextViewText(object: data as? CustomStringConvertible)
				case .failure(let error):
					self.setOutputTextViewText(error: error)
				}
			}
		}
	}
	
	func setOutputTextViewText(object: CustomStringConvertible?) {
		outputTextView.textColor = .black
		
		guard let object = object else {
			self.outputTextView.text = "Successfully retrieved your object. Conform to CustomStringConvertible to print object info."
			return
		}
		outputTextView.text = object.description
	}
	
	func setOutputTextViewText(error: Error) {
		outputTextView.textColor = .red
		outputTextView.text =
		"""
		An error occurred.
		
		Please check that your local server is running, see README.md for instructions.
		
		\(error.localizedDescription)
		"""
	}
	
	@IBAction func makeRequestA(sender: UIButton) {
		let endpoint = GetMoviesRequest()
		makeRequest(responseType: GetMoviesResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestB(sender: UIButton) {
		let endpoint = BungheadsApplyRequest()
		makeRequest(responseType: BungheadResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestC(sender: UIButton) {
		let endpoint = GetTimeRequest()
		makeRequest(responseType: GetTimeResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestD(sender: UIButton) {
		let endpoint = EmptyResponseRequest()
		makeRequest(responseType: EmptyResponse.self, at: endpoint)
	}
}
