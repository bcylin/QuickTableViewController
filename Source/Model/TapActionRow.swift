//
//  TapActionRow.swift
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

import Foundation

/// A struct that represents a row that triggers certain action when seleced.
public struct TapActionRow<T: TapActionCell>: Row, RowStyle, Equatable {

  // MARK: - Initializer

  ///
  public init(
    title: String,
    configuration: ((UITableViewCell, Row & RowStyle) -> Void)? = nil,
    action: ((Row) -> Void)?
  ) {
    self.title = title
    self.customize = configuration
    self.action = action
  }

  private init() {
    fatalError("init without any argument is not supported")
  }

  // MARK: - Row

  /// The title text of the row.
  public let title: String

  /// Subtitle is disabled in TapActionRow.
  public let subtitle: Subtitle? = nil

  /// A closure as the tap action when the row is selected.
  public let action: ((Row) -> Void)?

  // MARK: - RowStyle

  /// The type of the table view cell to display the row.
  public let cellType: UITableViewCell.Type = T.self

  /// The value is **QuickTableViewController.TapActionCell**, as the reuse identifier of the table view cell to display the row.
  public let cellReuseIdentifier: String = NSStringFromClass(T.self)

  /// The cell style is UITableViewCellStyle.default.
  public let cellStyle: UITableViewCellStyle = .default

  /// The TapActionRow is selectable when action is not nil.
  public var isSelectable: Bool {
    return action != nil
  }

  /// Additional customization during cell configuration.
  public let customize: ((UITableViewCell, Row & RowStyle) -> Void)?

}
