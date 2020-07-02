//
//  OptionRowTests.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 17/08/2017.
//  Copyright © 2017 bcylin.
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

internal final class OptionRowTests: XCTestCase {

  // MARK: - Initialization

  func testInitialiation() {
    // Given
    let detailText = DetailText.subtitle("subtitle")
    let icon = Icon.named("icon")
    var actionInvoked = false

    // When
    let row = OptionRow(text: "title", detailText: detailText, isSelected: true, icon: icon) { _ in actionInvoked = true }

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "title")
    XCTAssertEqual(row.detailText, detailText)
    XCTAssertEqual(row.isSelected, true)

    // With RowStyle
    XCTAssertEqual(row.cellReuseIdentifier, "UITableViewCell.subtitle")
    XCTAssertEqual(row.cellStyle, .subtitle)
    XCTAssertEqual(row.icon, icon)
    XCTAssertEqual(row.accessoryType, .checkmark)
    XCTAssertEqual(row.isSelectable, true)
    XCTAssertNil(row.customize)

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(actionInvoked, true)
  }

  func testCellStyleWithReuseIdentifier() {
    // When
    let a = OptionRow(text: "", detailText: nil, isSelected: true, action: { _ in })
    let b = OptionRow(text: "", detailText: DetailText.none, isSelected: true, action: { _ in })
    let c = OptionRow(text: "", detailText: .subtitle(""), isSelected: true, action: { _ in })
    let d = OptionRow(text: "", detailText: .value1(""), isSelected: true, action: { _ in })
    let e = OptionRow(text: "", detailText: .value2(""), isSelected: true, action: { _ in })

    // Then
    XCTAssertEqual(a.cellStyle, .default)
    XCTAssertEqual(b.cellStyle, .default)
    XCTAssertEqual(c.cellStyle, .subtitle)
    XCTAssertEqual(d.cellStyle, .value1)
    XCTAssertEqual(e.cellStyle, .value2)

    XCTAssertEqual(a.cellReuseIdentifier, "UITableViewCell")
    XCTAssertEqual(b.cellReuseIdentifier, "UITableViewCell.default")
    XCTAssertEqual(c.cellReuseIdentifier, "UITableViewCell.subtitle")
    XCTAssertEqual(d.cellReuseIdentifier, "UITableViewCell.value1")
    XCTAssertEqual(e.cellReuseIdentifier, "UITableViewCell.value2")
  }

  func testCellStyleWithReuseIdentifier_customCellType() {
    // When
    let a = OptionRow<CustomOptionCell>(text: "", detailText: nil, isSelected: true, action: { _ in })
    let b = OptionRow<CustomOptionCell>(text: "", detailText: DetailText.none, isSelected: true, action: { _ in })
    let c = OptionRow<CustomOptionCell>(text: "", detailText: .subtitle(""), isSelected: true, action: { _ in })
    let d = OptionRow<CustomOptionCell>(text: "", detailText: .value1(""), isSelected: true, action: { _ in })
    let e = OptionRow<CustomOptionCell>(text: "", detailText: .value2(""), isSelected: true, action: { _ in })

    // Then
    XCTAssertEqual(a.cellStyle, .default)
    XCTAssertEqual(b.cellStyle, .default)
    XCTAssertEqual(c.cellStyle, .subtitle)
    XCTAssertEqual(d.cellStyle, .value1)
    XCTAssertEqual(e.cellStyle, .value2)

    XCTAssertEqual(a.cellReuseIdentifier, "CustomOptionCell")
    XCTAssertEqual(b.cellReuseIdentifier, "CustomOptionCell.default")
    XCTAssertEqual(c.cellReuseIdentifier, "CustomOptionCell.subtitle")
    XCTAssertEqual(d.cellReuseIdentifier, "CustomOptionCell.value1")
    XCTAssertEqual(e.cellReuseIdentifier, "CustomOptionCell.value2")
  }

  // MARK: - Equatable

  func testEquatable_withIdenticalParameters() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Same", isSelected: true, action: nil)

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentTexts() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Different", isSelected: true, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentDetailTexts() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Same", detailText: .subtitle("Different"), isSelected: true, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentSelectionStates() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Same", isSelected: false, action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentIcons() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Same", isSelected: true, icon: .image(UIImage()), action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentActions() {
    // Given
    let one = OptionRow(text: "Same", isSelected: true, action: nil)

    // When
    let another = OptionRow(text: "Same", isSelected: true, action: { _ in })

    // Then it should be equal regardless of the actions attached
    XCTAssert(one == another)
  }

  // MARK: - Action Invocation

  func testActionInvocationWhenSelectionIsToggled() {
    let expectation = self.expectation(description: "it should invoke the action closure")

    // Given an option row that's not selected
    let row = OptionRow(text: "", isSelected: false) { _ in expectation.fulfill() }

    // When the selection is toggled
    row.isSelected = true

    // Then
    waitForExpectations(timeout: 1, handler: nil)
    XCTAssertEqual(row.accessoryType, .checkmark)
  }

  func testActionInvocationWhenSelectionIsNotToggled() {
    let expectation = self.expectation(description: "it should not invoke the action closure")
    expectation.isInverted = true

    // Given an option row that's not selected
    let row = OptionRow(text: "", isSelected: false) { _ in expectation.fulfill() }

    // When the selection is not toggled
    row.isSelected = false

    // Then
    waitForExpectations(timeout: 1, handler: nil)
    XCTAssertEqual(row.accessoryType, .none)
  }

}
