//
//  IconTests.swift
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

@testable import QuickTableViewController
import XCTest

internal final class IconTests: XCTestCase {

  private let image = UIImage(named: "icon", in: Bundle(for: IconTests.self), compatibleWith: nil)!
  private let highlighted = UIImage(named: "icon-highlighted", in: Bundle(for: IconTests.self), compatibleWith: nil)!

  // MARK: - Initialization

  func testInitialiation() {
    // Given
    let image = self.image

    // When
    let icon = Icon.image(image)

    // Then
    XCTAssertEqual(icon.image, image)
    XCTAssertNil(icon.highlightedImage)
  }

  // MARK: - Equatable

  func testEquatable_withIdenticalParameters() {
    // Given
    let one = Icon.image(image)

    // When
    let another = Icon.image(image)

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentImages() {
    // Given
    let one = Icon.image(image)

    // When
    let another = Icon.image(highlighted)

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentHighlightedImages() {
    // Given
    let one = Icon.images(normal: image, highlighted: highlighted)

    // When
    let another = Icon.images(normal: image, highlighted: UIImage())

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withDifferentImageSpecifications() {
    // Given
    let one = Icon.image(image)

    // When
    let another = Icon.named("image")

    // Then
    XCTAssert(one != another)
  }

  func testEquatable_withIdenticalImageNames() {
    // Given
    let one = Icon.named("Same")

    // When
    let another = Icon.named("Same")

    // Then
    XCTAssert(one == another)
  }

  func testEquatable_withDifferentImageNames() {
    // Given
    let one = Icon.named("Same")

    // When
    let another = Icon.named("Different")

    // Then
    XCTAssert(one != another)
  }
}
