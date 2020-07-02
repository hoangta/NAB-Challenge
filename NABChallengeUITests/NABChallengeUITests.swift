//
//  NABChallengeUITests.swift
//  NABChallengeUITests
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import XCTest

class NABChallengeUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUpWithError() throws {
    app = XCUIApplication()
    app.launch()

    continueAfterFailure = false
  }

  func testHome() throws {
    let searchField = XCUIApplication().navigationBars["Weather Forecast"].searchFields["Search city"]
    XCTAssert(searchField.exists)

    let keyword = "Saigon"
    searchField.tap()
    searchField.typeText(keyword)

    // Test if there are 7 forecast cells
    XCTAssert(XCUIApplication().tables.cells.element(boundBy: 6).waitForExistence(timeout: 1))

    for _ in 0..<keyword.count {
      searchField.typeText(XCUIKeyboardKey.delete.rawValue)
    }

    // Test if there is no forecast cells
    XCTAssertFalse(XCUIApplication().tables.cells.element(boundBy: 0).waitForExistence(timeout: 1))

    searchField.typeText("Xaigon")

    // Test if there is no forecast cells
    XCTAssertFalse(XCUIApplication().tables.cells.element(boundBy: 0).waitForExistence(timeout: 1))
  }
}
