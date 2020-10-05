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

  private func testImageNamed(_ name: String) -> UIImage {
    return UIImage(named: name, in: Bundle(for: IconTests.self), compatibleWith: nil)!
  }

  // MARK: - Initialization

  func testInitialiation_withName() {
    // When
    let icon: Icon = .named("icon", in: Bundle(for: IconTests.self))

    // Then
    XCTAssertEqual(icon.image, testImageNamed("icon"))
    XCTAssertEqual(icon.highlightedImage, testImageNamed("icon-highlighted"))
  }

  func testInitialiation_withNameNotFound() {
    // When
    let icon: Icon = .named("not-found", in: Bundle(for: IconTests.self))

    // Then
    XCTAssertNil(icon.image)
    XCTAssertNil(icon.highlightedImage)
  }

  func testInitialiation_withImage() {
    // Given
    let image = testImageNamed("icon")

    // When
    let icon: Icon = .image(image)

    // Then
    XCTAssertEqual(icon.image, image)
    XCTAssertNil(icon.highlightedImage)
  }

  func testInitialiation_withImages() {
    // Given
    let imageA = testImageNamed("icon")
    let imageB = testImageNamed("icon-highlighted")

    // When
    let icon: Icon = .images(normal: imageA, highlighted: imageB)

    // Then
    XCTAssertEqual(icon.image, imageA)
    XCTAssertEqual(icon.highlightedImage, imageB)
  }

  // MARK: - SFSymbols

  @available(iOS 13.0, tvOS 13.0, *)
  func testSFSymbol() {
    // Given
    let name = "gear"

    // When
    let icon: Icon = .sfSymbol(name)

    // Then
    let expectedImage = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(textStyle: .body))
    XCTAssertEqual(icon.image, expectedImage)
    XCTAssertNil(icon.highlightedImage)
  }

  @available(iOS 13.0, tvOS 13.0, *)
  func testSFSymbol_withConfiguration() {
    // Given
    let name = "camera"
    let configuration = UIImage.SymbolConfiguration(scale: .large)

    // When
    let icon: Icon = .sfSymbol(name, withConfiguration: configuration)

    // Then
    let expectedImage = UIImage(systemName: name, withConfiguration: configuration)
    XCTAssertEqual(icon.image, expectedImage)
    XCTAssertNil(icon.highlightedImage)
  }

  @available(iOS 13.0, tvOS 13.0, *)
  func testSFSymbol_notFound() {
    // When
    let icon: Icon = .sfSymbol("not-found")

    // Then
    XCTAssertNil(icon.image)
    XCTAssertNil(icon.highlightedImage)
  }

  // MARK: - Equatable

  private lazy var image = testImageNamed("icon")
  private lazy var highlighted = testImageNamed("icon-highlighted")

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
