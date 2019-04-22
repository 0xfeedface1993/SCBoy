//
//  SCBoyTests.swift
//  SCBoyTests
//
//  Created by 岚海网络 on 2018/12/10.
//  Copyright © 2018 ascp. All rights reserved.
//

import XCTest
@testable import SCBoy
import SwiftyJSON

class SCBoyTests: XCTestCase, Api {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testAPI() {
        let expectation = XCTestExpectation(description: "api test")
        
        api(url: APIHostURL.recentMatch.url, params: ["limit":"20", "offset":"0", "order_by":"-date"]) { (data, res, err) in
            if let e = err {
                XCTAssert(false, "\(e.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let d = data else {
                XCTAssert(false, "\(APIError.emptyData)")
                expectation.fulfill()
                return
            }
            
            if let _ = convert(jsonData: d) {
                XCTAssert(true, "")
                expectation.fulfill()
                return
            }
            
            XCTAssert(false, "\(APIError.invalidJSON)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 60)
    }
}
