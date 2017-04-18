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

import Foundation

/// A struct that represents a row with a switch.
public struct SwitchRow: Row, Equatable, IconEnabled {

  /// The title text of the row.
  public var title: String = ""

  /// Subtitle is disabled in SwitchRow.
  public let subtitle: Subtitle? = nil

  /// The icon of the row.
  public var icon: Icon?

  /// The state of the switch.
  public var switchValue: Bool = false {
    didSet {
      action?(self)
    }
  }

  /// The value is **SwitchCell**, as the reuse identifier of the table view cell to display the row.
  public let cellReuseIdentifier: String = NSStringFromClass(SwitchCell.self)

  /// A closure that will be invoked when the switchValue is changed.
  public var action: ((Row) -> Void)?

  ///
  public init(title: String, switchValue: Bool, icon: Icon? = nil, action: ((Row) -> Void)?) {
    self.title = title
    self.switchValue = switchValue
    self.icon = icon
    self.action = action
  }

  private init() {}

  // MARK: Equatable

  /// Returns true iff `lhs` and `rhs` have equal titles, switch values, and icons.
  public static func == (lhs: SwitchRow, rhs: SwitchRow) -> Bool {
    return lhs.title == rhs.title && lhs.switchValue == rhs.switchValue && lhs.icon == rhs.icon
  }

}
