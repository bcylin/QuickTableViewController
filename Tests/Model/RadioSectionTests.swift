//
//  RadioSectionTests.swift
//  QuickTableViewController
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

internal final class RadioSectionTests: XCTestCase {

  // MARK: - Initialization

  func testInitialiation() {
    // Given
    let row = OptionRow(text: "", isSelected: false, action: nil)

    // When
    let section = RadioSection(title: "title", options: [row], footer: "footer")

    // Then it should have the given parameters
    XCTAssertEqual(section.title, "title")
    XCTAssertEqual(section.rows.count, 1)
    XCTAssertEqual(section.rows.first as? OptionRow, row)
    XCTAssertEqual(section.options.count, 1)
    XCTAssertEqual(section.options.first as? OptionRow, row)
    XCTAssertEqual(section.footer, "footer")
  }

  // MARK: - Rows

  func testRowsGetter() {
    // Given
    let options = [
      OptionRow(text: "0", isSelected: false, action: nil),
      OptionRow(text: "1", isSelected: true, action: nil)
    ]

    // When
    let section = RadioSection(title: "", options: options)

    // Then it should return options as rows
    XCTAssert(section.rows is [OptionRowCompatible])
    XCTAssertEqual(section.rows as? [OptionRow], options)
  }

  func testRowsSetter_empty() {
    // Given
    let section = RadioSection(title: "", options: [
      OptionRow(text: "", isSelected: true, action: nil)
    ])

    // When
    section.rows = []

    // Then
    XCTAssert(section.rows.isEmpty)
  }

  func testRowsSetter_incompatibleType() {
    // Given
    let unchanged = [OptionRow(text: "0", isSelected: false, action: nil)]
    let section = RadioSection(title: "", options: unchanged)

    // When
    section.rows = [
      NavigationRow(text: "", detailText: .none),
      NavigationRow(text: "", detailText: .none)
    ]

    // Then the rows should not change
    XCTAssertEqual(section.rows as? [OptionRow], unchanged)
  }

  func testRowsSetter_compatibleType() {
    // Given
    let section = RadioSection(title: "", options: [])

    // When
    let changed = [
      OptionRow(text: "0", isSelected: false, action: nil),
      OptionRow(text: "1", isSelected: true, action: nil)
    ]
    section.rows = changed

    // Then the rows should change
    XCTAssertEqual(section.rows as? [OptionRow], changed)
  }

  // MARK: - Always Selects One Option

  func testAlwaysSelectsOneOption_whenSetToFalse() {
    // Given
    let section = RadioSection(title: "title", options: [
      OptionRow(text: "Option 1", isSelected: false, action: nil)
    ])

    // When
    section.alwaysSelectsOneOption = false

    // Then it should do nothing
    XCTAssertEqual(section.options.count, 1)
    XCTAssertNil(section.selectedOption)
  }

  func testAlwaysSelectsOneOption_whenSetToTrueWithEmptyOptions() {
    // Given
    let section = RadioSection(title: "title", options: [])

    // When
    section.alwaysSelectsOneOption = true

    // Then it should do nothing
    XCTAssert(section.options.isEmpty)
    XCTAssertNil(section.selectedOption)
  }

  func testAlwaysSelectsOneOption_whenSetToTrueWithNothingSelected() {
    // Given
    let section = RadioSection(title: "title", options: [
      OptionRow(text: "Option 1", isSelected: false, action: nil),
      OptionRow(text: "Option 2", isSelected: false, action: nil)
    ])

    // When
    section.alwaysSelectsOneOption = true

    // Then it should select the first option
    XCTAssert(section.selectedOption === section.options[0])
    XCTAssertEqual(section.options[0].isSelected, true)
    XCTAssertEqual(section.options[1].isSelected, false)
  }

  func testAlwaysSelectsOneOption_whenSetToTrueWithSomethingSelected() {
    // Given
    let section = RadioSection(title: "title", options: [
      OptionRow(text: "Option 1", isSelected: false, action: nil),
      OptionRow(text: "Option 2", isSelected: true, action: nil)
    ])

    // When
    section.alwaysSelectsOneOption = true

    // Then it should do nothing
    XCTAssert(section.selectedOption === section.options[1])
    XCTAssertEqual(section.options[0].isSelected, false)
    XCTAssertEqual(section.options[1].isSelected, true)
  }

  // MARK: - Toggle Options

  private func sectionWithThreeRows() -> RadioSection {
    return RadioSection(title: "Radio", options: [
      OptionRow(text: "Option 1", isSelected: true, action: nil),
      OptionRow(text: "Option 2", isSelected: false, action: nil),
      OptionRow(text: "Option 3", isSelected: false, action: nil)
    ])
  }

  func testToggleOptions_whenOptionToToggleNotInSection() {
    // Given
    let section = sectionWithThreeRows()

    // When
    let option = OptionRow(text: "", isSelected: true, action: nil)
    let result = section.toggle(option)

    // Then it should return an empty index set
    XCTAssert(result.isEmpty)
  }

  func testToggleOptions_whenOptionIsSelected() {
    // Given
    let section = sectionWithThreeRows()

    // When
    _ = section.toggle(section.options[0])

    // Then it should deselect the option
    XCTAssertNil(section.selectedOption)
    XCTAssertEqual(section.options[0].isSelected, false)
    XCTAssertEqual(section.options[1].isSelected, false)
    XCTAssertEqual(section.options[2].isSelected, false)
  }

  func testToggleOptions_withAlwaysSelectsOneOption() {
    // Given
    let section = sectionWithThreeRows()
    section.alwaysSelectsOneOption = true

    // When
    _ = section.toggle(section.options[0])

    // Then it should do nothing
    XCTAssert(section.selectedOption === section.options[0])
    XCTAssertEqual(section.options[0].isSelected, true)
    XCTAssertEqual(section.options[1].isSelected, false)
    XCTAssertEqual(section.options[2].isSelected, false)
  }

  func testToggleOptions_whenNothingIsSelected() {
    // Given
    let section = RadioSection(title: "Radio", options: [
      OptionRow(text: "Option 1", isSelected: false, action: nil),
      OptionRow(text: "Option 2", isSelected: false, action: nil),
      OptionRow(text: "Option 3", isSelected: false, action: nil)
    ])

    // When
    _ = section.toggle(section.options[1])

    // Then it should select the option
    XCTAssert(section.selectedOption === section.options[1])
    XCTAssertEqual(section.options[0].isSelected, false)
    XCTAssertEqual(section.options[1].isSelected, true)
    XCTAssertEqual(section.options[2].isSelected, false)
  }

  func testToggleOptions_whenAnotherOptionIsSelected() {
    // Given
    let section = sectionWithThreeRows()

    // When
    _ = section.toggle(section.options[2])

    // Then it should deselect the other option
    XCTAssert(section.selectedOption === section.options[2])
    XCTAssertEqual(section.options[0].isSelected, false)
    XCTAssertEqual(section.options[1].isSelected, false)
    XCTAssertEqual(section.options[2].isSelected, true)
  }

}
