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
        let router = Router()
        spinner.startAnimating()
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		router.makeRequest(responseType: responseType, endpoint: endpoint, decoder: decoder) { result in
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
        
        Please check that your local server is running, see ButterLocalServer/README.md for instructions.
        
        \(error.localizedDescription)
        """
    }
    
    @IBAction func makeRequestA(sender: UIButton) {
        let endpoint = SampleEndpointA()
		makeRequest(responseType: SampleResponseA.self, at: endpoint)
    }
    
    @IBAction func makeRequestB(sender: UIButton) {
        let endpoint = SampleEndpointB()
		makeRequest(responseType: SampleResponseB.self, at: endpoint)
    }
    
    @IBAction func makeRequestC(sender: UIButton) {
        let endpoint = SampleEndpointC()
		makeRequest(responseType: SampleResponseC.self, at: endpoint)
    }
	
	@IBAction func makeRequestD(sender: UIButton) {
        let endpoint = SampleEndpointD()
		makeRequest(responseType: SampleResponseD.self, at: endpoint)
    }
}
