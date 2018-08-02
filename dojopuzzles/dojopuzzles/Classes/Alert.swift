
import Foundation
import UIKit

class Alert {
    
    enum alertStyle {
        case success
        case warning
        case error
    }
    
    fileprivate class func getMessageTitle(_ style: alertStyle) -> String {
        switch style {
            case .success:
                return "generalAlertSuccessTitle".localized()
            case .warning:
                return "generalAlertWarningTitle".localized()
            default:
                return "generalAlertErrorTitle".localized()
        }
    }
    
    class func createAlertWithOkAction(_ sender: UIViewController, style: alertStyle, title: String?, message: String?, action: ((UIAlertAction) -> Void)?) {
        let titleStr = title ?? self.getMessageTitle(style)
        let alert = UIAlertController(title: titleStr, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "generalOk".localized(), style: .default, handler: action)
        alert.addAction(okAction)
        
        sender.present(alert, animated: true, completion: nil)
    }
    
}
