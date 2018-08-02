
import XCTest
@testable import dojopuzzles

class dojopuzzlesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWithdrawal() {
        let viewModel = ATMViewModel()
        
        guard let result = viewModel.withdrawal(160) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.hundred, 1)
        XCTAssertEqual(result.fifty, 1)
        XCTAssertEqual(result.twenty, 0)
        XCTAssertEqual(result.ten, 1)
        XCTAssertNotEqual(result.ten, 0)
        
        viewModel.finishTransaction(result)
        
        XCTAssertEqual(viewModel.balance, 840)
    }
    
}
