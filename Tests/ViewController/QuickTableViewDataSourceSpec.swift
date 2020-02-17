//
//  QuickTableViewDataSourceTests.swift
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

internal final class QuickTableViewDataSourceTests: XCTestCase {

  private var controller: QuickTableViewController!

  override func setUp() {
    super.setUp()
    controller = QuickTableViewController()
    _ = controller.view
  }

  func testNumberOfSectionsInTableView() {
    // Given
    controller.tableContents = [
      Section(title: nil, rows: []),
      Section(title: nil, rows: []),
      Section(title: nil, rows: [])
    ]

    // When
    let numberOfSections = controller.numberOfSections(in: controller.tableView)

    // Then
    XCTAssertEqual(numberOfSections, 3)
  }

  func testTableViewNumberOfRowsInSection() {
    // Given
    controller.tableContents = [
      Section(title: nil, rows: []),
      Section(title: nil, rows: [
        NavigationRow(text: "", detailText: .none),
        NavigationRow(text: "", detailText: .none)
      ]),
      RadioSection(title: nil, options: []),
      RadioSection(title: nil, options: [
        OptionRow(text: "", isSelected: false, action: { _ in }),
        OptionRow(text: "", isSelected: false, action: { _ in })
      ])
    ]

    // When
    let numberOfRowsInSection: [Int] = (0...3).map {
      controller.tableView(controller.tableView, numberOfRowsInSection: $0)
    }

    // Then
    XCTAssertEqual(numberOfRowsInSection[0], 0)
    XCTAssertEqual(numberOfRowsInSection[1], 2)
    XCTAssertEqual(numberOfRowsInSection[2], 0)
    XCTAssertEqual(numberOfRowsInSection[3], 2)
  }

  func testTableViewTitleForHeaderInSection() {
    // Given
    controller.tableContents = [
      Section(title: nil, rows: []),
      Section(title: "title", rows: []),
      RadioSection(title: "radio", options: [])
    ]

    // When
    let titleForHeaderInSection: [String?] = (0...2).map {
      controller.tableView(controller.tableView, titleForHeaderInSection: $0)
    }

    // Then
    XCTAssertNil(titleForHeaderInSection[0])
    XCTAssertEqual(titleForHeaderInSection[1], "title")
    XCTAssertEqual(titleForHeaderInSection[2], "radio")
  }

  func testTableViewTitleForFooterInSection() {
    // Given
    controller.tableContents = [
      Section(title: nil, rows: []),
      Section(title: nil, rows: [], footer: "footer"),
      RadioSection(title: nil, options: [], footer: "radio")
    ]

    // When
    let titleForFooterInSection: [String?] = (0...2).map {
      controller.tableView(controller.tableView, titleForFooterInSection: $0)
    }

    // Then
    XCTAssertNil(titleForFooterInSection[0])
    XCTAssertEqual(titleForFooterInSection[1], "footer")
    XCTAssertEqual(titleForFooterInSection[2], "radio")
  }

  // MARK: - tableView(_:cellForRowAt:)

  func testTableViewCellForRowAt_navigationRow() {
    // Given
    controller.tableContents = [
      Section(title: "Cell Styles", rows: [
        CustomNavigationRow<CustomCell>(text: "CellStyle.default", detailText: .none),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .subtitle(".subtitle")),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .value1(".value1")),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .value2(".value2"))
      ])
    ]

    // When
    let cells: [UITableViewCell] = (0...3).map {
      controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: $0, section: 0))
    }

    // Then
    XCTAssertEqual(cells[0].reuseIdentifier, "CustomCell.default")
    XCTAssertEqual(cells[1].reuseIdentifier, "CustomCell.subtitle")
    XCTAssertEqual(cells[2].reuseIdentifier, "CustomCell.value1")
    XCTAssertEqual(cells[3].reuseIdentifier, "CustomCell.value2")

    XCTAssertEqual(cells[0].textLabel?.text, "CellStyle.default")
    XCTAssertEqual(cells[1].textLabel?.text, "CellStyle")
    XCTAssertEqual(cells[2].textLabel?.text, "CellStyle")
    XCTAssertEqual(cells[3].textLabel?.text, "CellStyle")

    XCTAssertNil(cells[0].detailTextLabel?.text)
    XCTAssertEqual(cells[1].detailTextLabel?.text, ".subtitle")
    XCTAssertEqual(cells[2].detailTextLabel?.text, ".value1")
    XCTAssertEqual(cells[3].detailTextLabel?.text, ".value2")

    cells.forEach {
      XCTAssertEqual($0.accessoryType, .none)
    }
  }

  func testTableViewCellForRowAt_navigationRowWithAction() {
    // Given
    controller.tableContents = [
      Section(title: "Navigation", rows: [
        CustomNavigationRow<CustomCell>(text: "", detailText: .none, action: { _ in }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .subtitle(""), action: { _ in }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .value1(""), action: { _ in }),
        CustomNavigationRow<CustomCell>(text: "", detailText: .value2(""), action: { _ in })
      ])
    ]

    // When
    let cells: [UITableViewCell] = (0...3).map {
      controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: $0, section: 0))
    }

    // Then
    cells.forEach {
      XCTAssertEqual($0.accessoryType, .disclosureIndicator)
    }
  }

  func testTableViewCellForRowAt_switchRow() {
    // Given
    controller.tableContents = [
      Section(title: "SwitchRow", rows: [
        SwitchRow(text: "Setting 0", switchValue: true, action: nil),
        CustomSwitchRow(text: "Setting 1", switchValue: true, action: nil),
        SwitchRow<CustomSwitchCell>(text: "Setting 2", switchValue: true, action: nil),
        CustomSwitchRow<CustomSwitchCell>(text: "Setting 3", switchValue: true, action: nil)
      ])
    ]

    for index in 0...3 {
      // When
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: index, section: 0))

      // Then it should match the cell type
      if index < 2 {
        XCTAssert(cell is SwitchCell)
      } else {
        XCTAssert(cell is CustomSwitchCell)
      }

      // Then it should match the text
      XCTAssertEqual(cell.textLabel?.text, "Setting \(index)")
      XCTAssertNil(cell.detailTextLabel?.text)

      // Then it should match the switch value
      #if os(iOS)
        XCTAssertEqual((cell as? SwitchCell)?.switchControl.isOn, true)
      #elseif os(tvOS)
        XCTAssertEqual(cell.accessoryType, .checkmark)
      #endif
    }
  }

  func testTableViewCellForRowAt_tapActionRow() {
    // Given
    controller.tableContents = [
      Section(title: "TapActionRow", rows: [
        TapActionRow(text: "0", action: { _ in }),
        CustomTapActionRow(text: "1", action: { _ in }),
        TapActionRow<CustomTapActionCell>(text: "2", action: { _ in }),
        CustomTapActionRow<CustomTapActionCell>(text: "3", action: { _ in })
      ])
    ]

    for index in 0...3 {
      // When
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: index, section: 0))

      // Then it should match the cell type
      if index < 2 {
        XCTAssert(cell is TapActionCell)
      } else {
        XCTAssert(cell is CustomTapActionCell)
      }

      // Then it should match the configuration
      XCTAssertEqual(cell.textLabel?.text, "\(index)")
      XCTAssertNil(cell.detailTextLabel?.text)
    }
  }

  func testTableViewCellForRowAt_optionRow() {
    // Given
    controller.tableContents = [
      Section(title: "OptionRow", rows: [
        OptionRow(text: "0", isSelected: true, action: { _ in }),
        CustomOptionRow(text: "1", isSelected: true, action: { _ in }),
        OptionRow<CustomCell>(text: "2", isSelected: true, action: { _ in }),
        CustomOptionRow<CustomCell>(text: "3", isSelected: true, action: { _ in })
      ])
    ]

    for index in [2, 3]  {
      // When
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: index, section: 0))

      // Then it should match the cell type
      XCTAssert(cell is CustomCell)
    }

    for index in 0...3 {
      // When
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: index, section: 0))

      // Then it should match the configuration
      XCTAssertEqual(cell.textLabel?.text, "\(index)")
      XCTAssertEqual(cell.accessoryType, .checkmark)
    }
  }

  func testTableViewCellForRowAt_rowWithIcon() {
    // Given
    let resourcePath = Bundle(for: QuickTableViewDataSourceTests.self).resourcePath as NSString?
    let imagePath = resourcePath!.appendingPathComponent("icon.png")
    let highlightedImagePath = resourcePath!.appendingPathComponent("icon-highlighted.png")

    let image = UIImage(contentsOfFile: imagePath)!
    let highlightedImage = UIImage(contentsOfFile: highlightedImagePath)!

    controller.tableContents = [
      Section(title: "NavigationRow", rows: [
        CustomNavigationRow<CustomCell>(text: "CellStyle.default", detailText: .none, icon: .named("icon")),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .subtitle(".subtitle"), icon: .image(image)),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .value1(".value1"), icon: .images(normal: image, highlighted: highlightedImage)),
        CustomNavigationRow<CustomCell>(text: "CellStyle", detailText: .value2(".value2"), icon: .image(image))
      ]),
      Section(title: "SwitchRow", rows: [
        CustomSwitchRow<CustomSwitchCell>(text: "imageName", switchValue: true, icon: .named("icon"), action: nil),
        CustomSwitchRow<CustomSwitchCell>(text: "image", switchValue: true, icon: .image(image), action: nil),
        CustomSwitchRow<CustomSwitchCell>(text: "image + highlightedImage", switchValue: true, icon: .images(normal: image, highlighted: highlightedImage), action: nil)
      ])
    ]

    do {
      // When
      let row = 0
      let navigationCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0))
      let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 1))

      // Then it does not work with images in the test bundle
      XCTAssertNil(navigationCell.imageView?.image)
      XCTAssertNil(navigationCell.imageView?.highlightedImage)

      XCTAssertNil(switchCell.imageView?.image)
      XCTAssertNil(switchCell.imageView?.highlightedImage)
    }

    do {
      // When
      let row = 1
      let navigationCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0))
      let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 1))

      // Then it should have the image set
      XCTAssertEqual(navigationCell.imageView?.image, image)
      XCTAssertNil(navigationCell.imageView?.highlightedImage)

      XCTAssertEqual(switchCell.imageView?.image, image)
      XCTAssertNil(switchCell.imageView?.highlightedImage)
    }

    do {
      // When
      let row = 2
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0))
      let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 1))

      // Then it should have the image and highlightedImage set
      XCTAssertEqual(cell.imageView?.image, image)
      XCTAssertEqual(cell.imageView?.highlightedImage, highlightedImage)

      XCTAssertEqual(switchCell.imageView?.image, image)
      XCTAssertEqual(switchCell.imageView?.highlightedImage, highlightedImage)
    }

    do {
      // When
      let row = 3
      let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0))

      // Then it should not have an image with UITableViewCellStyle.value2"
      XCTAssertNil(cell.imageView?.image)
      XCTAssertNil(cell.imageView?.highlightedImage)
    }
  }

}
