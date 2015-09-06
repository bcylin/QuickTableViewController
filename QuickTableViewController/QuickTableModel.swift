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

  public init(title: String?, rows: [Row]) {
    self.title = title
    self.rows = rows
  }
}


// MARK: -

/**
A struct that represents a row in a table view.
*/
public struct Row {

  // MARK: Properties

  public var title: String = ""
  public var subtitle: Subtitle?

  /// The action to perfom when the row is selected.
  public var action: ActionType?

  // MARK: Initializer

  /// Creates a Row instance with a title and a subtitle, without any selected action.
  public init(title: String, subtitle: Subtitle?) {
    self.init(title: title, subtitle: subtitle, action: nil)
  }

  /// Creates a Row instance with a title and a selected action, without a subtitle.
  public init(title: String, action: Tap) {
    self.init(title: title, subtitle: nil, action: action as ActionType)
  }

  /// Creates a Row instance with a title, a subtitle, and an action that's related to navigation when the row is selected.
  public init(title: String, subtitle: Subtitle?, action: Navigation) {
    self.init(title: title, subtitle: subtitle, action: action as ActionType)
  }

  // MARK: Private

  private init(title: String, subtitle: Subtitle?, action: ActionType?) {
    self.title = title
    self.subtitle = subtitle
    self.action = action
  }

  private init() {}

}


// MARK: -

/**
Any type that conforms to this protocol is compatible with the actions attached to Row instances.
*/
public protocol ActionType {
  var action: ((Row) -> Void) { get }
}

/**
An action related to Navigation which is performed when the row is selected.
*/
public struct Navigation: ActionType {
  public let action: ((Row) -> Void)

  public init(_ action: ((Row) -> Void)) {
    self.action = action
  }
}

/**
An action which is performed when the row is selected.
*/
public struct Tap: ActionType {
  public let action: ((Row) -> Void)

  public init(_ action: ((Row) -> Void)) {
    self.action = action
  }
}


// MARK: -

/**
An enum that indicates the subtitle text with UITableViewCellStyle.

- BelowTitle:   Represents a subtitle with UITableViewCellStyle.Subtitle.
- RightAligned: Represents a subtitle with UITableViewCellStyle.Value1.
- LeftAligned:  Represents a subtitle with UITableViewCellStyle.Value2.
*/
public enum Subtitle {
  case BelowTitle(String)
  case RightAligned(String)
  case LeftAligned(String)

  public var style: String {
    get {
      switch self {
      case .BelowTitle(let _): return "Subtitle.BelowTitle"
      case .RightAligned(let _): return "Subtitle.RightAligned"
      case .LeftAligned(let _): return "Subtitle.LeftAligned"
      }
    }
  }

  public var text: String {
    get {
      switch self {
      case .BelowTitle(let text): return text
      case .RightAligned(let text): return text
      case .LeftAligned(let text): return text
      }
    }
  }
}
