//
//  TapActionRowTests.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 17/01/2016.
//  Copyright © 2016 bcylin.
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

import QuickTableViewController
import XCTest

internal final class TapActionRowTests: XCTestCase {

  // MARK: - Initialization

  func testInitialiation() {
    // Given
    var actionInvoked = false

    // When
    let row = TapActionRow(text: "title") { _ in actionInvoked = true }

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "title")
    XCTAssertEqual(row.cellReuseIdentifier, "TapActionCell")

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(actionInvoked, true)
  }

  // MARK: - Equatable

  func testEquatable_withIdenticalParameters() {
    // Given
    let one = TapActionRow(text: "Same", action: nil)

    // When
    let another = TapActionRow(text: "Same", action: nil)

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentTexts() {
    // Given
    let one = TapActionRow(text: "Same", action: nil)

    // When
    let another = TapActionRow(text: "Different", action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentActions() {
    // Given
    let one = TapActionRow(text: "Same", action: nil)

    // When
    let another = TapActionRow(text: "Same", action: { _ in })

    // Then it should be equal regardless of the actions attached
    XCTAssert(one == another)
  }

}
