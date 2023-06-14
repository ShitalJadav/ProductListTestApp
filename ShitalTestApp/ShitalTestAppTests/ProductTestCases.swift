//
//  ProductTestCases.swift
//  ShitalTestAppTests
//
//  Created by ShitalJadav on 08/06/23.
//

import XCTest
@testable import ShitalTestApp
class ProductTestCases: XCTestCase {
    
    var objViewModel = ProductViewModel()
    
    func testCheckProductAPI() {
        objViewModel.fetchProductAPICall() { isSucess in
        XCTAssert(isSucess)
        }
    }
    
    func testFavouriteProductItems() {
        let favData = selectedData
        XCTAssert(favData != [] &&  !(favData.isEmpty ))
    }
}

