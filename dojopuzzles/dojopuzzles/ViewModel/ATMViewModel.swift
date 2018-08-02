
import Foundation

class ATMViewModel {
    
    fileprivate var value: Int = 0
    var balance = 1000
    
    struct bankNotes {
        let hundred = 100
        let fifty = 50
        let twenty = 20
        let ten = 10
    }
    
    var showAlert: ((String)->())?
    var updateResult: ((String)->())?
    let notes = bankNotes()
    
    func withdrawal(_ value: Int) -> Withdrawal? {
        self.value = value
        
        let resultHundred = value % self.notes.hundred
        let hundredBankNotes = (value - resultHundred) / self.notes.hundred
        
        let resultFifty = resultHundred % self.notes.fifty
        let fiftyBankNotes = (resultHundred - resultFifty) / self.notes.fifty
        
        let resultTwenty = resultFifty % self.notes.twenty
        let twentyBankNotes = (resultFifty - resultTwenty) / self.notes.twenty
        
        let resultTen = resultTwenty % self.notes.ten
        let tenBankNotes = (resultTwenty - resultTen) / self.notes.ten
        
        guard resultTen == 0 else {
            self.updateResult?("")
            self.showAlert?("withdrawalNoNotes".localized())
            return nil
        }
        
        return Withdrawal(hundred: hundredBankNotes, fifty: fiftyBankNotes, twenty: twentyBankNotes, ten: tenBankNotes)
    }
    
    func finishTransaction(_ withdrawal: Withdrawal) {
        guard self.balance > 0, self.balance >= self.value, self.value > 0 else {
            self.updateResult?("")
            self.showAlert?("withdrawalNoBalance".localized())
            return
        }
        
        self.balance -= self.value
        let notes = "generalNotes".localized()
        
        var transaction = "\("generalWithdrawal".localized()): $\(self.value) \n\n\n"
        if withdrawal.hundred > 0 {
            transaction += "$\(self.notes.hundred) - \(withdrawal.hundred) \(notes) \n\n"
        }
        if withdrawal.fifty > 0 {
            transaction += "$\(self.notes.fifty) - \(withdrawal.fifty) \(notes) \n\n"
        }
        if withdrawal.twenty > 0 {
            transaction += "$\(self.notes.twenty) - \(withdrawal.twenty) \(notes) \n\n"
        }
        if withdrawal.ten > 0 {
            transaction += "$\(self.notes.ten) - \(withdrawal.ten) \(notes) \n\n\n"
        }
        transaction += "\("generalBalance".localized()): $\(self.balance)"
        
        self.updateResult?(transaction)
    }
    
}
