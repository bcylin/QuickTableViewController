//
//  ConfigurableTests.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 27/12/2017.
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

@testable import QuickTableViewController
import XCTest

internal final class ConfigurableTests: XCTestCase {

  func testConfiguration_default() {
    do {
      // Given
      let cell = SwitchCell()
      let row = SwitchRow(text: "", switchValue: true, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, true)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .checkmark)
      #endif
    }

    do {
      // Given
      let cell = SwitchCell()
      let row = SwitchRow(text: "", switchValue: false, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, false)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .none)
      #endif
    }
  }

  func testConfiguration_customRow() {
    do {
      // Given
      let cell = SwitchCell()
      let row = CustomSwitchRow(text: "", switchValue: true, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, true)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .checkmark)
      #endif
    }

    do {
      // Given
      let cell = SwitchCell()
      let row = CustomSwitchRow(text: "", switchValue: false, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, false)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .none)
      #endif
    }
  }

  func testConfiguration_customCell() {
    do {
      // Given
      let cell = CustomSwitchCell()
      let row = CustomSwitchRow<CustomSwitchCell>(text: "", switchValue: true, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, true)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .checkmark)
      #endif
    }

    do {
      // Given
      let cell = CustomSwitchCell()
      let row = CustomSwitchRow<CustomSwitchCell>(text: "", switchValue: false, action: nil)

      // When
      cell.configure(with: row)

      // Then
      #if os(iOS)
        XCTAssertEqual(cell.accessoryView, cell.switchControl)
        XCTAssertEqual(cell.switchControl.isOn, false)
      #elseif os(tvOS)
        XCTAssertNil(cell.accessoryView)
        XCTAssertEqual(cell.accessoryType, .none)
      #endif
    }
  }

}
