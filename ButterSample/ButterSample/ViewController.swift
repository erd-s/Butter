//
//  Created by Chris Erdos on 5/5/20
//

import UIKit
import Butter

class ViewController: UIViewController {
	
	@IBOutlet weak var outputTextView: UITextView!
	@IBOutlet weak var outputImageView: UIImageView!
	@IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.outputImageView.isHidden = true
	}
	
	func makeRequest<T: Decodable>(responseType: T.Type, at endpoint: Endpoint) {
		spinner.startAnimating()
		Butter().makeRequest(responseType: responseType, endpoint: endpoint) { result in
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
		outputImageView.isHidden = true
		outputTextView.isHidden = false
		
		guard let object = object else {
			self.outputTextView.text = "Successfully retrieved your object. Conform to CustomStringConvertible to print object info."
			return
		}
		outputTextView.text = object.description
	}
	
	func setOutputTextViewText(error: Error) {
		outputImageView.isHidden = true
		outputTextView.isHidden = false
		
		outputTextView.textColor = .red
		outputTextView.text =
		"""
		An error occurred.
		
		Please check that your local server is running, see README.md for instructions.
		
		\(error)
		"""
	}
	
	func handleImageResponse(result: Result<Data, Error>) {
		DispatchQueue.main.async {
			switch result {
			case .success(let imageData):
				self.outputImageView.isHidden = false
				self.outputTextView.isHidden = true
				self.spinner.stopAnimating()
				if let image = UIImage(data: imageData) {
					let imageRatio = image.size.width / image.size.height
					self.imageViewHeightConstraint.constant = self.outputImageView.frame.width / imageRatio
					self.outputImageView.image = image
				}
			case .failure(let error):
				self.outputImageView.isHidden = true
				self.outputTextView.isHidden = false
				self.outputTextView.text = "An error occurred. \(error)"
			}
		}
	}
	
	@IBAction func makeRequestA(sender: UIButton) {
		let endpoint = GetMoviesEndpoint()
		makeRequest(responseType: GetMoviesResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestB(sender: UIButton) {
		let endpoint = BungheadsApplyEndpoint()
		makeRequest(responseType: BungheadResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestC(sender: UIButton) {
		let endpoint = GetTimeEndpoint()
		makeRequest(responseType: GetTimeResponse.self, at: endpoint)
	}
	
	@IBAction func makeRequestD(sender: UIButton) {
		let endpoint = EmptyResponseEndpoint()
		makeRequest(responseType: EmptyResponse.self, at: endpoint)
	}
	
	@IBAction func makeImageRequest(sender: UIButton) {
		/// Note: This is a real endpoint
		let endpoint = ImageEndpoint()
		self.spinner.startAnimating()
		Butter().makeImageRequest(endpoint: endpoint, completion: handleImageResponse)
	}
}
