//
//  ExampleUITests.swift
//  Example-tvOSUITests
//
//  Created by Francesco Deliro on 07/10/2018.
//  Copyright © 2018 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest

internal final class ExampleUITests: XCTestCase {

  private lazy var app: XCUIApplication = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
  }

  func testInteractions() {

    let tables = XCUIApplication().tables
    let existance = NSPredicate(format: "exists == true")
    let hasFocus = NSPredicate(format: "hasFocus == true")

    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Setting 1").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Setting 2").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Tap action").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    expectation(for: hasFocus, evaluatedWith: app.alerts["Tap action"].otherElements["OK"], handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Tap action").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "CellStyle.default").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    expectation(for: existance, evaluatedWith: app.otherElements.containing(.staticText, identifier: "CellStyle.default").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.menu)

    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "CellStyle.default").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: ".subtitle").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    expectation(for: existance, evaluatedWith: app.otherElements.containing(.staticText, identifier: "CellStyle.subtitle").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.menu)

    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: ".subtitle").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: ".value1").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: ".value2").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Option 1").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Option 2").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)

    XCUIRemote.shared.press(.down)
    expectation(for: hasFocus, evaluatedWith: tables.cells.containing(.staticText, identifier: "Option 3").element, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCUIRemote.shared.press(.select)
  }

}
