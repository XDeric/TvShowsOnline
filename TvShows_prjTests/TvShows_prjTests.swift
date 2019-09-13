//
//  TvShows_prjTests.swift
//  TvShows_prjTests
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import XCTest
@testable import TvShows_prj

class TvShows_prjTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func getDataFromOnline() -> Data {
        guard let url = URL(string: "http://api.tvmaze.com/shows") else {
            fatalError("No URL")
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let onlineError {
            fatalError("couldnt get TVdata from online \(onlineError)")
        }
    }
    
    /// testing for stuff
    func testTVLoaded (){
        let data = getDataFromOnline()
        let testTV = TVShows.getTV(from: data)
        XCTAssertTrue(testTV.self != nil, "TV info failed to load")
    }
    
}
