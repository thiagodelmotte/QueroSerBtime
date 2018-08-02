
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var transactionLabel: UILabel!
    
    var viewModel = ATMViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewModel()
    }
    
    fileprivate func initViewModel() {
        self.viewModel.updateResult = { [weak self] transaction in
            DispatchQueue.main.async {
                self?.transactionLabel.text = transaction
                self?.valueTextField.text = nil
            }
        }
        
        self.viewModel.showAlert = { [weak self] message in
            DispatchQueue.main.async {
                if let controller = self {
                    Alert.createAlertWithOkAction(controller, style: .error, title: nil, message: message, action: nil)
                }
            }
        }
    }
    
    @IBAction func withdrawalTapped(_ sender: UIButton) {
        guard let value = self.valueTextField.text, let valueInt = Int(value), valueInt > 0 else {
            self.viewModel.showAlert?("withdrawalTypeValue".localized())
            return
        }
        
        if let withdrawal = self.viewModel.withdrawal(valueInt) {
            self.viewModel.finishTransaction(withdrawal)
        }
    }
    
}

