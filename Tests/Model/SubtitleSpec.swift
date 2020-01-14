//
//  SubtitleTests.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 28/10/2015.
//  Copyright © 2015 bcylin.
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

@testable import QuickTableViewController
import XCTest

@available(*, deprecated, message: "Compatibility tests")
internal final class SubtitleTests: XCTestCase {

  func testCompatibility() {
    XCTAssertEqual(Subtitle.none.detailText, .none)
    XCTAssertEqual(Subtitle.belowTitle("text").detailText, .subtitle("text"))
    XCTAssertEqual(Subtitle.rightAligned("text").detailText, .value1("text"))
    XCTAssertEqual(Subtitle.leftAligned("text").detailText, .value2("text"))
  }

  func testNavigationRow() {
    // Given
    let subtitle = Subtitle.belowTitle("detail text")
    let detailText = DetailText.subtitle("detail text")
    let icon = Icon.named("icon")
    var invoked = false

    // When
    let row = NavigationRow(title: "text", subtitle: subtitle, icon: icon, action: { _ in invoked = true })

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "text")
    XCTAssertEqual(row.detailText, detailText)
    XCTAssertEqual(row.icon, icon)
    XCTAssertEqual(row.cellReuseIdentifier, "UITableViewCell.subtitle")

    // It should support deprecated properties
    XCTAssertEqual(row.title, "text")
    XCTAssertEqual(row.subtitle?.text, "detail text")

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(invoked, true)
  }

  func testOptionRow() {
    // Given
    let icon = Icon.named("icon")
    var invoked = false

    // When
    let row = OptionRow(title: "text", isSelected: true, icon: icon) { _ in invoked = true }

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "text")
    XCTAssertNil(row.detailText)
    XCTAssertEqual(row.isSelected, true)

    // With RowStyle
    XCTAssertEqual(row.cellReuseIdentifier, "UITableViewCell")
    XCTAssertEqual(row.cellStyle, .default)
    XCTAssertEqual(row.icon, icon)
    XCTAssertEqual(row.accessoryType, .checkmark)
    XCTAssertEqual(row.isSelectable, true)
    XCTAssertNil(row.customize)

    // It should support deprecated properties
    XCTAssertEqual(row.title, "text")
    XCTAssertNil(row.subtitle?.text)

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(invoked, true)
  }

  func testSwitchRow() {
    // Given
    var invoked = false

    // When
    let row = SwitchRow(title: "text", switchValue: true) { _ in invoked = true }

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "text")
    XCTAssertNil(row.detailText)
    XCTAssertEqual(row.switchValue, true)
    XCTAssertEqual(row.cellReuseIdentifier, "SwitchCell")

    // It should support deprecated properties
    XCTAssertEqual(row.title, "text")
    XCTAssertNil(row.subtitle?.text)

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(invoked, true)
  }

  func testTapActionRow() {
    // Given
    var invoked = false

    // When
    let row = TapActionRow(title: "text") { _ in invoked = true }

    // Then it should initialize with given parameters
    XCTAssertEqual(row.text, "text")
    XCTAssertNil(row.detailText)
    XCTAssertEqual(row.cellReuseIdentifier, "TapActionCell")

    // It should support deprecated properties
    XCTAssertEqual(row.title, "text")
    XCTAssertNil(row.subtitle?.text)

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(invoked, true)
  }

}
