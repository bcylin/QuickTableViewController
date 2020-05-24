//
//  QuickTableViewDelegateTests.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 31/12/2017.
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

internal final class QuickTableViewDelegateTests: XCTestCase {

  private var controller: QuickTableViewController! // swiftlint:disable:this implicitly_unwrapped_optional

  override func setUp() {
    super.setUp()
    controller = QuickTableViewController()
    _ = controller.view
  }

  // MARK: - tableView(_:shouldHighlightRowAt:)

  func testTableViewShouldHighlightRowAt_navigationRow() {
    // Given
    controller.tableContents = [
      Section(title: "NavigationRow without actions", rows: [
        NavigationRow(text: "", detailText: .none),
        CustomNavigationRow(text: "", detailText: .none),
        NavigationRow<CustomCell>(text: "", detailText: .none),
        CustomNavigationRow<CustomCell>(text: "", detailText: .none)
      ]),

      Section(title: "NavigationRow with actions", rows: [
        NavigationRow(text: "", detailText: .none, action: { _ in }),
        CustomNavigationRow(text: "", detailText: .none, action: { _ in }),
        NavigationRow<CustomCell>(text: "", detailText: .none, action: { _ in }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .none, action: { _ in })
      ])
    ]

    for row in 0...3 {
      let section = 0

      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: section))

      // Then it should not highlight NavigationRow without an action
      XCTAssertEqual(highlighted, false)
    }

    for row in 0...3 {
      let section = 1

      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: section))

      // Then it should highlight NavigationRow with an action
      XCTAssertEqual(highlighted, true)
    }
  }

  func testTableViewShouldHighlightRowAt_switchRow() {
    // Given
    controller.tableContents = [
      Section(title: "SwitchRow", rows: [
        SwitchRow(text: "", switchValue: true, action: nil),
        CustomSwitchRow(text: "", switchValue: true, action: nil),
        SwitchRow<CustomSwitchCell>(text: "", switchValue: true, action: nil),
        CustomSwitchRow<CustomSwitchCell>(text: "", switchValue: true, action: nil)
      ])
    ]

    for row in 0...3 {
      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: 0))

      // Then
      #if os(iOS)
        XCTAssertEqual(highlighted, false)
      #elseif os(tvOS)
        XCTAssertEqual(highlighted, true)
      #endif
    }
  }

  func testTableViewShouldHighlightRowAt_tapActionRow() {
    // Given
    controller.tableContents = [
      Section(title: "TapActionRow", rows: [
        TapActionRow(text: "", action: { _ in }),
        CustomTapActionRow(text: "", action: { _ in }),
        TapActionRow<CustomTapActionCell>(text: "", action: { _ in }),
        CustomTapActionRow<CustomTapActionCell>(text: "", action: { _ in })
      ])
    ]

    for row in 0...3 {
      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: 0))

      // Then
      XCTAssertEqual(highlighted, true)
    }
  }

  func testTableViewShouldHighlightRowAt_optionRow() {
    // Given
    controller.tableContents = [
      Section(title: "OptionRow withou actions", rows: [
        OptionRow(text: "", isSelected: false, action: nil),
        CustomOptionRow(text: "", isSelected: false, action: nil),
        OptionRow<CustomCell>(text: "", isSelected: false, action: nil),
        CustomOptionRow<CustomCell>(text: "", isSelected: false, action: nil)
      ]),

      RadioSection(title: "RadioSection with actions", options: [
        OptionRow(text: "", isSelected: false, action: { _ in }),
        CustomOptionRow(text: "", isSelected: false, action: { _ in }),
        OptionRow<CustomCell>(text: "", isSelected: false, action: { _ in }),
        CustomOptionRow<CustomCell>(text: "", isSelected: false, action: { _ in })
      ])
    ]

    for row in 0...3 {
      let section = 0

      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: section))

      // Then it should highlight OptionRow without an action
      XCTAssertEqual(highlighted, true)
    }

    for row in 0...3 {
      let section = 1

      // When
      let highlighted = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: row, section: section))

      // Then it should highlight OptionRow with an action
      XCTAssertEqual(highlighted, true)
    }
  }

  // MARK: - tableView(_:didSelectRowAt:)

  func testTableViewDidSelectRowAt_sectionWithNavigationRow() {
    // Given
    let expectations = (0...3).map { expectation(description: "it should invoke the action closure at index \($0)") }

    controller.tableContents = [
      Section(title: "NavigationRow", rows: [
        NavigationRow(text: "", detailText: .none, action: { _ in expectations[0].fulfill() }),
        CustomNavigationRow(text: "", detailText: .none, action: { _ in expectations[1].fulfill() }),
        NavigationRow<CustomCell>(text: "", detailText: .none, action: { _ in expectations[2].fulfill() }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .none, action: { _ in expectations[3].fulfill() })
      ])
    ]

    // When
    for row in 0...3 {
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: row, section: 0))
    }

    // Then it should invoke the action when row is selected
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testTableViewDidSelectRowAt_sectionWithTapActionRow() {
    // Given
    let expectations = (0...3).map { expectation(description: "it should invoke the action closure at index \($0)") }

    controller.tableContents = [
      Section(title: "TapActionRow", rows: [
        TapActionRow(text: "", action: { _ in expectations[0].fulfill() }),
        CustomTapActionRow(text: "", action: { _ in expectations[1].fulfill() }),
        TapActionRow<CustomTapActionCell>(text: "", action: { _ in expectations[2].fulfill() }),
        CustomTapActionRow<CustomTapActionCell>(text: "", action: { _ in expectations[3].fulfill() })
      ])
    ]

    // When
    for row in 0...3 {
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: row, section: 0))
    }

    // Then it should invoke the action when row is selected
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testTableViewDidSelectRowAt_sectionWithOptionRow() {
    // Given
    let expectations = (0...3).map { expectation(description: "it should invoke the action closure at index \($0)") }

    controller.tableContents = [
      Section(title: "OptionRow", rows: [
        OptionRow(text: "", isSelected: false, action: { _ in expectations[0].fulfill() }),
        CustomOptionRow(text: "", isSelected: false, action: { _ in expectations[1].fulfill() }),
        OptionRow<CustomCell>(text: "", isSelected: false, action: { _ in expectations[2].fulfill() }),
        CustomOptionRow<CustomCell>(text: "", isSelected: false, action: { _ in expectations[3].fulfill() })
      ])
    ]

    // When
    for row in 0...3 {
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: row, section: 0))
    }

    // Then it should invoke the action when row is selected
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testTableViewDidSelectRowAt_radioSectionWithOptionRow() {
    // Given
    let radio = RadioSection(title: "alwaysSelectsOneOption = false", options: [
      OptionRow(text: "", isSelected: false, action: nil),
      CustomOptionRow(text: "", isSelected: false, action: nil),
      OptionRow<CustomCell>(text: "", isSelected: false, action: nil),
      CustomOptionRow<CustomCell>(text: "", isSelected: false, action: nil)
    ])
    controller.tableContents = [radio]

    for index in 0...3 {
      // When
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: index, section: 0))

      // Then the row should be selected
      let option = radio.rows[index] as? OptionRowCompatible
      XCTAssertEqual(option?.isSelected, true)

      // When
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: index, section: 0))

      // The selection should be toggled when selected again
      XCTAssertEqual(option?.isSelected, false)
    }
  }

  func testTableViewDidSelectRowAt_radioSectionThatAlwaysSelectsOneOption() {
    // Given
    let radio = RadioSection(title: "alwaysSelectsOneOption = true", options: [
      OptionRow(text: "", isSelected: false, action: nil),
      CustomOptionRow(text: "", isSelected: false, action: nil),
      OptionRow<CustomCell>(text: "", isSelected: false, action: nil),
      CustomOptionRow<CustomCell>(text: "", isSelected: false, action: nil)
    ])
    radio.alwaysSelectsOneOption = true
    controller.tableContents = [radio]

    for index in 0...3 {
      // When
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: index, section: 0))

      // The row should be selected
      let option = radio.rows[index] as? OptionRowCompatible
      XCTAssertEqual(option?.isSelected, true)

      // When
      controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: index, section: 0))

      // The row should not be deselected
      XCTAssertEqual(option?.isSelected, true)
      XCTAssertEqual(radio.indexOfSelectedOption, index)
    }
  }

  // MARK: -

  #if os(iOS)
  func testTableViewAccessoryButtonTappedForRowWith() {
    // Given
    let expectations = (0...3).map { expectation(description: "it should invoke the action closure at index \($0)") }

    controller.tableContents = [
      Section(title: "NavigationRow", rows: [
        NavigationRow(text: "", detailText: .none, accessoryButtonAction: { _ in expectations[0].fulfill() }),
        CustomNavigationRow(text: "", detailText: .none, accessoryButtonAction: { _ in expectations[1].fulfill() }),
        NavigationRow<CustomCell>(text: "", detailText: .none, accessoryButtonAction: { _ in expectations[2].fulfill() }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .none, accessoryButtonAction: { _ in expectations[3].fulfill() })
      ])
    ]

    // When
    for index in 0...3 {
      controller.tableView(controller.tableView, accessoryButtonTappedForRowWith: IndexPath(row: index, section: 0))
    }

    // Then it should invoke action when accessory button is selected
    waitForExpectations(timeout: 1, handler: nil)
  }
  #endif

}
