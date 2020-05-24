//
//  SwitchRowTests.swift
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

internal final class SwitchRowTests: XCTestCase {

  // MARK: - Initialization

  func testInitialiation() {
    // Given
    let detailText = DetailText.subtitle("subtitle")
    let icon = Icon.named("icon")
    var actionInvoked = false

    // When
    let row = SwitchRow(text: "title", detailText: detailText, switchValue: true, icon: icon) { _ in actionInvoked = true }

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "title")
    XCTAssertEqual(row.detailText, detailText)
    XCTAssertEqual(row.switchValue, true)

    // With RowStyle
    XCTAssertEqual(row.cellReuseIdentifier, "SwitchCell")
    XCTAssertEqual(row.cellStyle, .subtitle)
    XCTAssertEqual(row.icon, icon)
    XCTAssertNil(row.customize)

    #if os(iOS)
      XCTAssertEqual(row.accessoryType, .none)
      XCTAssertEqual(row.isSelectable, false)
    #elseif os(tvOS)
      XCTAssertEqual(row.accessoryType, .checkmark)
      XCTAssertEqual(row.isSelectable, true)
    #endif

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(actionInvoked, true)
  }

  // MARK: - Equatable

  func testEquatable_withIdenticalParameters() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Same", switchValue: true, action: nil)

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentTexts() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Different", switchValue: true, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentDetailTexts() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Same", detailText: .subtitle("Different"), switchValue: true, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentSwitchValues() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Same", switchValue: false, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentIcons() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Same", switchValue: true, icon: .image(UIImage()), action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentActions() {
    // Given
    let one = SwitchRow(text: "Same", switchValue: true, action: nil)

    // When
    let another = SwitchRow(text: "Same", switchValue: true, action: { _ in })

    // Then it should be equal regardless of the actions attached
    XCTAssert(one == another)
  }

  // MARK: - Action Invocation

  func testActionInvocationWhenSwitchValueIsToggled() {
    let expectation = self.expectation(description: "it should invoke the action closure")

    // Given a switch row that's off
    let row = SwitchRow(text: "", switchValue: false) { _ in expectation.fulfill() }

    // When the switch value is toggled
    row.switchValue = true

    // Then
    waitForExpectations(timeout: 1)
  }

  func testActionInvocationWhenSwitchValueIsNotToggled() {
    let expectation = self.expectation(description: "it should not invoke the action closure")
    expectation.isInverted = true

    // Given a switch row that's off
    let row = SwitchRow(text: "", switchValue: false) { _ in expectation.fulfill() }

    // When the switch value is not toggled
    row.switchValue = false

    // Then
    waitForExpectations(timeout: 1)
  }

}
