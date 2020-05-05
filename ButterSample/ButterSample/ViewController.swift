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
        guard
            let data = jsonData
        else {
            outputTextView.text = "No data"
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            outputTextView.text = "Data is not json parseable"
            return
        }
        
        outputTextView.text = "\(json)"
    }
    
    func setOutputTextViewText(error: Error) {
        outputTextView.text = error.localizedDescription
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

