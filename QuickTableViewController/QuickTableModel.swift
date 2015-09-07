//
//  QuickTableModel.swift
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

/**
A struct that represents a section in a table view.
*/
public struct Section {

  public var title: String?
  public var rows: [Row]
  public var footer: String?

  public init(title: String?, rows: [Row], footer: String? = nil) {
    self.title = title
    self.rows = rows
    self.footer = footer
  }

}


// MARK: - Row


/**
Any type that conforms to this protocol is capable of representing a row in a table view.
*/
public protocol Row {
  var title: String { get }
  var subtitle: Subtitle? { get }
  var action: ((Row) -> Void)? { get }
}


/**
A struct that represents a row that perfoms navigation when seleced.
*/
public struct NavigationRow: Row {

  public var title: String = ""
  public var subtitle: Subtitle?

  /// A closure related to the navigation when the row is selected.
  public var action: ((Row) -> Void)?

  // MARK: Initializer

  public init(title: String, subtitle: Subtitle, action: ((Row) -> Void)? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.action = action
  }

  private init() {}

}


/**
A struct that represents a row with a switch.
*/
public struct SwitchRow: Row {

  public var title: String = ""

  /// Subtitle is disabled in SwitchRow.
  public let subtitle: Subtitle? = nil

  /// The state of a switch.
  public var switchValue: Bool = false

  /// A closure that will be invoked when the switch's value is changed.
  public var action: ((Row) -> Void)?

  // MARK: Initializer

  public init(title: String, switchValue: Bool, action: ((Row) -> Void)?) {
    self.title = title
    self.switchValue = switchValue
    self.action = action
  }

  private init() {}

}


/**
A struct that represents a row that triggers certain action when seleced.
*/
public struct TapActionRow: Row {

  public var title: String = ""

  /// Subtitle is disabled in TapActionRow.
  public let subtitle: Subtitle? = nil

  /// A closure as the tap action when the row is selected.
  public var action: ((Row) -> Void)?

  // MARK: Initializer

  public init(title: String, action: ((Row) -> Void)?) {
    self.title = title
    self.action = action
  }

  private init() {}

}


// MARK: - Subtitle


/**
An enum that indicates the subtitle text with UITableViewCellStyle.

- None:         Without a subtitle
- BelowTitle:   Subtitle in UITableViewCellStyle.Subtitle
- RightAligned: Subtitle in UITableViewCellStyle.Value1
- LeftAligned:  Subtitle in UITableViewCellStyle.Value2
*/
public enum Subtitle {

  case None
  case BelowTitle(String)
  case RightAligned(String)
  case LeftAligned(String)

  /// Returns the descriptive name of the style.
  public var style: String {
    get {
      switch self {
      case .None: return "Subtitle.None"
      case .BelowTitle(let _): return "Subtitle.BelowTitle"
      case .RightAligned(let _): return "Subtitle.RightAligned"
      case .LeftAligned(let _): return "Subtitle.LeftAligned"
      }
    }
  }

  /// Returns the associated text of the case.
  public var text: String? {
    get {
      switch self {
      case .BelowTitle(let text): return text
      case .RightAligned(let text): return text
      case .LeftAligned(let text): return text
      default: return nil
      }
    }
  }

}
