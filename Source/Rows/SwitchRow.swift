//
//  SwitchRow.swift
//  QuickTableViewController
//
//  Created by Ben on 01/09/2015.
//  Copyright (c) 2015 bcylin.
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

import UIKit

/// A class that represents a row with a switch.
open class SwitchRow<T: SwitchCell>: SwitchRowCompatible, Equatable {

  // MARK: - Initializer

  /// Initializes a `SwitchRow` with a title, a switch state and an action closure.
  /// The detail text, icon and the customization closure are optional.
  public init(
    text: String,
    detailText: DetailText? = nil,
    switchValue: Bool,
    icon: Icon? = nil,
    customization: ((UITableViewCell, Row & RowStyle) -> Void)? = nil,
    action: ((Row) -> Void)?
  ) {
    self.text = text
    self.detailText = detailText
    self.switchValue = switchValue
    self.icon = icon
    self.customize = customization
    self.action = action
  }

  // MARK: - SwitchRowCompatible

  /// The state of the switch.
  public var switchValue: Bool = false {
    didSet {
      guard switchValue != oldValue else {
        return
      }
      DispatchQueue.main.async {
        self.action?(self)
      }
    }
  }

  // MARK: - Row

  /// The text of the row.
  public let text: String

  /// The detail text of the row.
  public let detailText: DetailText?

  /// A closure that will be invoked when the `switchValue` is changed.
  public let action: ((Row) -> Void)?

  // MARK: - RowStyle

  /// The type of the table view cell to display the row.
  public let cellType: UITableViewCell.Type = T.self

  /// The reuse identifier of the table view cell to display the row. The default value is **SwitchCell**.
  public let cellReuseIdentifier: String = T.reuseIdentifier

  /// Returns the table view cell style for the specified detail text.
  public var cellStyle: UITableViewCell.CellStyle {
    return detailText?.style ?? .default
  }

  /// The icon of the row.
  public let icon: Icon?

  #if os(iOS)

  /// The default accessory type is `.none`.
  public let accessoryType: UITableViewCell.AccessoryType = .none

  /// The `SwitchRow` should not be selectable.
  public let isSelectable: Bool = false

  #elseif os(tvOS)

  /// Returns `.checkmark` when the `switchValue` is on, otherwise returns `.none`.
  public var accessoryType: UITableViewCell.AccessoryType {
    return switchValue ? .checkmark : .none
  }

  /// The `SwitchRow` is selectable on tvOS.
  public let isSelectable: Bool = true

  #endif

  /// The additional customization during cell configuration.
  public let customize: ((UITableViewCell, Row & RowStyle) -> Void)?

  // MARK: - Equatable

  /// Returns true iff `lhs` and `rhs` have equal titles, detail texts, switch values, and icons.
  public static func == (lhs: SwitchRow, rhs: SwitchRow) -> Bool {
    return
      lhs.text == rhs.text &&
      lhs.detailText == rhs.detailText &&
      lhs.switchValue == rhs.switchValue &&
      lhs.icon == rhs.icon
  }

}
