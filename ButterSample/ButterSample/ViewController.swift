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
    
    func makeRequest(at endpoint: Endpoint) {
        let router = Router()
        spinner.startAnimating()
        router.makeRequest(endpoint: endpoint) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result {
                case .success(let data):
                    self.setOutputTextViewText(jsonData: data)
                case .failure(let error):
                    self.setOutputTextViewText(error: error)
                }
            }
        }
    }
    
    func setOutputTextViewText(jsonData: Data?) {
        outputTextView.textColor = .black
        
        guard let data = jsonData else {
            outputTextView.text = "No data"
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            outputTextView.text = "Data is not json parseable"
            return
        }
    
        let mappedJson: [String] = json.compactMap { entry in
            var string = "\(entry.key): "
            if let arrayValue = entry.value as? NSArray {
                string.append(arrayValue.description(withLocale: nil, indent: 1))
            } else {
                string.append("\(entry.value)")
            }
            return string
        }
        
        outputTextView.text = mappedJson.joined(separator: "\n")
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
        makeRequest(at: endpoint)
    }
    
    @IBAction func makeRequestB(sender: UIButton) {
        let endpoint = SampleEndpointB()
        makeRequest(at: endpoint)
    }
    
    @IBAction func makeRequestC(sender: UIButton) {
        let endpoint = SampleEndpointC()
        makeRequest(at: endpoint)
    }
}
