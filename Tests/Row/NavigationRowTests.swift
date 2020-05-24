//
//  NavigationRowTests.swift
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

internal final class NavigationRowTests: XCTestCase {

  // MARK: - Initialization

  #if os(iOS)
  func testInitialiation_iOS() {
    // Given
    let detailText = DetailText.subtitle("subtitle")
    let icon = Icon.named("icon")
    var actionInvoked = false
    var accessoryButtonActionInvoked = false

    // When
    let row = NavigationRow(
      text: "title",
      detailText: detailText,
      icon: icon,
      action: { _ in actionInvoked = true },
      accessoryButtonAction: { _ in accessoryButtonActionInvoked = true }
    )

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "title")
    XCTAssertEqual(row.detailText, detailText)

    // With RowStyle
    XCTAssertEqual(row.cellReuseIdentifier, "UITableViewCell.subtitle")
    XCTAssertEqual(row.cellStyle, .subtitle)
    XCTAssertEqual(row.icon, icon)
    XCTAssertEqual(row.accessoryType, .detailDisclosureButton)
    XCTAssertEqual(row.isSelectable, true)
    XCTAssertNil(row.customize)

    // When
    row.action?(row)
    row.accessoryButtonAction?(row)

    // Then
    XCTAssertEqual(actionInvoked, true)
    XCTAssertEqual(accessoryButtonActionInvoked, true)
  }
  #endif

  #if os(tvOS)
  func testInitialiation_tvOS() {
    // Given
    let detailText = DetailText.subtitle("subtitle")
    let icon = Icon.named("icon")
    var actionInvoked = false

    // When
    let row = NavigationRow(text: "title", detailText: detailText, icon: icon, action: { _ in actionInvoked = true })

    // Then it should have the given parameters
    XCTAssertEqual(row.text, "title")
    XCTAssertEqual(row.detailText, detailText)

    // With RowStyle
    XCTAssertEqual(row.cellReuseIdentifier, "UITableViewCell.subtitle")
    XCTAssertEqual(row.cellStyle, .subtitle)
    XCTAssertEqual(row.icon, icon)
    XCTAssertEqual(row.accessoryType, .disclosureIndicator)
    XCTAssertEqual(row.isSelectable, true)
    XCTAssertNil(row.customize)

    // When
    row.action?(row)

    // Then
    XCTAssertEqual(actionInvoked, true)
  }
  #endif

  func testCellReuseIdentifier() {
    // When
    let a = NavigationRow(text: "", detailText: .none)
    let b = NavigationRow(text: "", detailText: .subtitle(""))
    let c = NavigationRow(text: "", detailText: .value1(""))
    let d = NavigationRow(text: "", detailText: .value2(""))

    // Then
    XCTAssertEqual(a.cellReuseIdentifier, "UITableViewCell.default")
    XCTAssertEqual(b.cellReuseIdentifier, "UITableViewCell.subtitle")
    XCTAssertEqual(c.cellReuseIdentifier, "UITableViewCell.value1")
    XCTAssertEqual(d.cellReuseIdentifier, "UITableViewCell.value2")
  }

  #if os(iOS)
  func testAccessoryType_iOS() {
    // When
    let a = NavigationRow(text: "", detailText: .none)
    let b = NavigationRow(text: "", detailText: .none, action: { _ in })
    let c = NavigationRow(text: "", detailText: .none, accessoryButtonAction: { _ in })
    let d = NavigationRow(text: "", detailText: .none, action: { _ in }, accessoryButtonAction: { _ in })

    // Then
    XCTAssertEqual(a.accessoryType, .none)
    XCTAssertEqual(b.accessoryType, .disclosureIndicator)
    XCTAssertEqual(c.accessoryType, .detailButton)
    XCTAssertEqual(d.accessoryType, .detailDisclosureButton)
  }
  #endif

  #if os(tvOS)
  func testAccessoryType_tvOS() {
    // When
    let a = NavigationRow(text: "", detailText: .none)
    let b = NavigationRow(text: "", detailText: .none, action: { _ in })

    // Then
    XCTAssertEqual(a.accessoryType, .none)
    XCTAssertEqual(b.accessoryType, .disclosureIndicator)
  }
  #endif

  // MARK: - Equatable

  func testEquatable_withIdenticalParameters() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // When
    let another = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentTexts() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // When
    let another = NavigationRow(text: "Different", detailText: .subtitle("Same"), action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentDetailTexts() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // When
    let another = NavigationRow(text: "Same", detailText: .subtitle("Different"), action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentIcons() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // When
    let another = NavigationRow(text: "Same", detailText: .subtitle("Same"), icon: .image(UIImage()), action: nil)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentActions() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: nil)

    // When
    let another = NavigationRow(text: "Same", detailText: .subtitle("Same"), action: { _ in })

    // Then it should be equal regardless of the actions attached
    XCTAssert(one == another)
  }

  #if os(iOS)
  func testEquatable_withDifferentAccessoryButtonActions() {
    // Given
    let one = NavigationRow(text: "Same", detailText: .subtitle("Same"), accessoryButtonAction: nil)

    // When
    let another = NavigationRow(text: "Same", detailText: .subtitle("Same"), accessoryButtonAction: { _ in })

    // Then it should be equal regardless of the actions attached
    XCTAssert(one == another)
  }
  #endif

}
