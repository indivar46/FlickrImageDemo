//
//  SearchValidationUnitTest.swift
//  Indivar_DeserveTests
//
//  Created by Indivar on 17/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import XCTest
@testable import Indivar_Deserve

//MARK: TestCases for Validation and code coverage , currently have mentioned a few only to implement the feature

class SearchValidationUnitTest: XCTestCase {

    func test_searchValidation_withEmptyStrings(){
        
        //ARRANGE
        let validation = SearchValidations()
        let request = SearchRequest(searchText: "", pageNo: 1)
        //ACT
        let result = validation.validate(request: request)
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
//ASSERT
        XCTAssertEqual(result.message, "Search cannot be empty")
    }
    
       func test_searchValidation_withValidStrings(){
            
            //ARRANGE
            let validation = SearchValidations()
            let request = SearchRequest(searchText: "All", pageNo: 1)
            //ACT
            let result = validation.validate(request: request)
    //ASSERT
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.message)
        }
}
