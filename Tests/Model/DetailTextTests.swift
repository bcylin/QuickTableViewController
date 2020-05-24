//
//  DetailTextTests.swift
//  QuickTableViewController
//
//  Created by bcylin on 31/12/2018.
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

@testable import QuickTableViewController
import XCTest

internal final class DetailTextTests: XCTestCase {

  func testCellStyle() {
    // It should return the descriptive name of the style
    XCTAssertEqual(DetailText.none.style, .default)
    XCTAssertEqual(DetailText.subtitle("text").style, .subtitle)
    XCTAssertEqual(DetailText.value1("text").style, .value1)
    XCTAssertEqual(DetailText.value2("text").style, .value2)
  }

  func testAssocitatedValue() {
    // It should return the associated text
    XCTAssertNil(DetailText.none.text)
    XCTAssertEqual(DetailText.subtitle("3").text, "3")
    XCTAssertEqual(DetailText.value1("1").text, "1")
    XCTAssertEqual(DetailText.value2("2").text, "2")
  }

  // MARK: - Equatable

  func testEquatableNone() {
    // Given
    let a = DetailText.none
    let b = DetailText.none

    // Then it should be equal when both are .none
    XCTAssert(a == b)
  }

  func testEquatableSubtitle() {
    // Given
    let a = DetailText.subtitle("Same")
    let b = DetailText.subtitle("Same")
    let c = DetailText.subtitle("Different")
    let d = DetailText.value1("Same")
    let e = DetailText.none

    // Then it should be equal only when both type and associated value match
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }

  func testEquatableValue1() {
    // Given
    let a = DetailText.value1("Same")
    let b = DetailText.value1("Same")
    let c = DetailText.value1("Different")
    let d = DetailText.value2("Same")
    let e = DetailText.none

    // Then it should be equal only when both type and associated value match
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }

  func testEquatableValue2() {
    // Given
    let a = DetailText.value2("Same")
    let b = DetailText.value2("Same")
    let c = DetailText.value2("Different")
    let d = DetailText.subtitle("Same")
    let e = DetailText.none

    // Then it should be equal only when both type and associated value match
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }
}
