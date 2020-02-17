//
//  ReusableTests.swift
//  QuickTableViewController
//
//  Created by Ben on 21/08/2017.
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

internal final class ReusableTests: XCTestCase {

  private class CustomCell: UITableViewCell {}

  private let pattern = String.typeDescriptionPattern

  func testTypeString_withInvalidPattern() {
    // Given
    let typeString = String(describing: type(of: self))

    // When
    let matches = typeString.matches(of: "\\")

    // Then it should return an empty array
    XCTAssert(matches.isEmpty)
  }

  func testTypeString_withSpecialFormat() {
    // Given
    let typeString = "(CustomCell in _B5334F301B8CC6AA00C64A6D)"

    // When
    let matches = typeString.matches(of: pattern)

    // Then it should match the pattern
    XCTAssertEqual(matches.count, 2)
  }

  func testTypeString_withNameOnly() {
    // Given
    let typeString = "CustomCell"

    // When
    let matches = typeString.matches(of: pattern)

    // Then it should not match the pattern
    XCTAssert(matches.isEmpty)
  }

  func testReuseIdentifier_withCustomType() {
    // When
    let identifier = CustomCell.reuseIdentifier

    // Then
    XCTAssertEqual(identifier, "CustomCell")
  }

  func testReuseIdentifier_withTypeInModule() {
    // When
    let identifier = SwitchCell.reuseIdentifier

    // Then
    XCTAssertEqual(identifier, "SwitchCell")
  }

}
