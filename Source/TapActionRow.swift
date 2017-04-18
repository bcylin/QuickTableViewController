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
public struct TapActionRow: Row, Equatable {

  /// The title text of the row.
  public var title: String = ""

  /// Subtitle is disabled in TapActionRow.
  public let subtitle: Subtitle? = nil

  /// The value is **TapActionCell**, as the reuse identifier of the table view cell to display the row.
  public let cellReuseIdentifier: String = NSStringFromClass(TapActionCell.self)

  /// A closure as the tap action when the row is selected.
  public var action: ((Row) -> Void)?

  ///
  public init(title: String, action: ((Row) -> Void)?) {
    self.title = title
    self.action = action
  }

  private init() {}

}
