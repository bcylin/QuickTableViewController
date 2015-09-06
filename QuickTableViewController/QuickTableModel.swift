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


/**
A struct that represents a row in a table view.
*/
public struct Row {

  public var title: String
  public var subtitle: Subtitle?

  /// The action to perfom when the row is selected.
  public var tapAction: (Void -> Void)? {
    didSet {
      if tapAction != nil { self.navigation = nil }
    }
  }

  /// The navigation to perform when the row is selected.
  public var navigation: (Void -> Void)? {
    didSet {
      if navigation != nil { self.tapAction = nil }
    }
  }

  // MARK: - Initializer

  public init(title: String, subtitle: Subtitle?, tapAction: (Void -> Void)?, navigation: (Void -> Void)?) {
    self.title = title
    self.subtitle = subtitle
    self.tapAction = tapAction
    self.navigation = navigation
  }

  public init() {
    self.init(title: "", subtitle: nil, tapAction: nil, navigation: nil)
  }

  public init(title: String, subtitle: Subtitle?) {
    self.init(title: title, subtitle: subtitle, tapAction: nil, navigation: nil)
  }

  public init(title: String, tapAction: (Void -> Void)) {
    self.init(title: title, subtitle: nil, tapAction: tapAction, navigation: nil)
  }

  public init(title: String, subtitle: Subtitle?, navigation: (Void -> Void)) {
    self.init(title: title, subtitle: subtitle, tapAction: nil, navigation: navigation)
  }

}


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
