//
//  OptionRow.swift
//  QuickTableViewController
//
//  Created by Ben on 30/07/2017.
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

import Foundation

public final class OptionRow<T: UITableViewCell>: Row, RowStyle {

  // MARK: - Initializer

  public init(
    title: String,
    isSelected: Bool = false,
    customization: ((UITableViewCell, Row & RowStyle) -> Void)? = nil,
    action: ((Row) -> Void)?
  ) {
    self.title = title
    self.isSelected = isSelected
    self.customize = customization
    self.action = action
  }

  // MARK: - Row

  /// The title text of the row.
  public let title: String

  ///
  public let subtitle: Subtitle? = nil

  ///
  public let action: ((Row) -> Void)?

  // MARK: - OptionRow

  public var isSelected: Bool = false

  // MARK: - RowStyle

  /// The type of the table view cell to display the row.
  public let cellType: UITableViewCell.Type = T.self

  /// The reuse identifier of the table view cell to display the row. The default value is **TapActionCell**.
  public let cellReuseIdentifier: String = String(describing: T.self)

  ///
  public let cellStyle: UITableViewCellStyle = .default

  ///
  public let icon: Icon? = nil

  /// Returns `.checkmark` when the row is selected, otherwise returns `.none`.
  public var accessoryType: UITableViewCellAccessoryType {
    return isSelected ? .checkmark : .none
  }

  /// `OptionRow` is always selectable.
  public let isSelectable: Bool = true

  /// Additional customization during cell configuration.
  public let customize: ((UITableViewCell, Row & RowStyle) -> Void)?

}
