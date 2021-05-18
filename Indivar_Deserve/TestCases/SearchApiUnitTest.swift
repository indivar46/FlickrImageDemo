//
//  SearchApiUnitTest.swift
//  Indivar_DeserveTests
//
//  Created by Indivar on 17/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import XCTest
@testable import Indivar_Deserve

//MARK: TestCases for api request and code coverage , currently have mentioned a few only to implement the feature, more can be created for failure case

class SearchApiUnitTest: XCTestCase {

    func test_SearchApiResource_withValidRequest_Returns_Success()
    {
        //ARRANGE
        let request = SearchRequest(searchText: "All", pageNo: 1)
        let resource = ApiRequest()
        let expectation = self.expectation(description: "ValidRequest_Returns_Success")
        resource.fetchImages(request: request) { (imageResponse) in
            //ASSERT

            XCTAssertNotNil(imageResponse)
            XCTAssertNil(imageResponse?.message)
            XCTAssertEqual(request.pageNo, imageResponse?.photos.page)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    

}
