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

/// A struct that represents a section in a table view.
public struct Section {

  /// The text of the section title.
  public var title: String?

  /// The array of rows in the section.
  public var rows: [Row]

  /// The text of the section footer.
  public var footer: String?

  ///
  public init(title: String?, rows: [Row], footer: String? = nil) {
    self.title = title
    self.rows = rows
    self.footer = footer
  }

}


// MARK: - Row


/// Any type that conforms to this protocol is capable of representing a row in a table view.
public protocol Row {
  /// The title text of the row.
  var title: String { get }
  /// The subtitle text of the row.
  var subtitle: Subtitle? { get }
  /// A closure related to the action of the row.
  var action: ((Row) -> Void)? { get }
}

/// Returns true iff `lhs` and `rhs` have equal titles and subtitles.
public func ==<T: Row>(lhs: T, rhs: T) -> Bool {
  return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
}


// MARK: - Icon


/// Any type that conforms to this protocol is able to show an icon image in a table view.
public protocol IconEnabled: Row {
  /// The icon of the row.
  var icon: Icon? { get }
}

/// A struct that represents the image used in a row.
public struct Icon: Equatable {

  /// The image of the normal state.
  public var image: UIImage? {
    return _image ?? UIImage(named: imageName ?? "")
  }

  /// The image of the highlighted state.
  public var highlightedImage: UIImage? {
    return _highlightedImage ?? UIImage(named: highlightedImageName)
  }

  private var _image: UIImage?
  private var _highlightedImage: UIImage?

  internal private(set) var imageName: String?
  internal var highlightedImageName: String {
    if let name = imageName {
      return name + "-highlighted"
    } else {
      return ""
    }
  }

  ///
  public init(imageName: String) {
    self.imageName = imageName
  }

  ///
  public init(image: UIImage, highlightedImage: UIImage? = nil) {
    _image = image
    _highlightedImage = highlightedImage
  }

  private init() {}

}

// MARK: Equatable

/// Returns true iff `lhs` and `rhs` have equal images, highlighted images and image names.
public func == (lhs: Icon, rhs: Icon) -> Bool {
  if let lhsName = lhs.imageName, rhsName = rhs.imageName {
    return lhsName == rhsName
  } else {
    return lhs._image == rhs._image && lhs._highlightedImage == rhs._highlightedImage
  }
}


// MARK: - NavigationRow


/// A struct that represents a row that perfoms navigation when seleced.
public struct NavigationRow: Row, Equatable, IconEnabled {

  /// The title text of the row.
  public var title: String = ""

  /// The subtitle text of the row.
  public var subtitle: Subtitle?

  /// The icon of the row.
  public var icon: Icon?

  /// A closure related to the navigation when the row is selected.
  public var action: ((Row) -> Void)?

  ///
  public init(title: String, subtitle: Subtitle, icon: Icon? = nil, action: ((Row) -> Void)? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.icon = icon
    self.action = action
  }

  private init() {}

}

// MARK: Equatable

/// Returns true iff `lhs` and `rhs` have equal titles, subtitles and icons.
public func == (lhs: NavigationRow, rhs: NavigationRow) -> Bool {
  return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.icon == rhs.icon
}


// MARK: - SwitchRow


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

}

// MARK: Equatable

/// Returns true iff `lhs` and `rhs` have equal titles, switch values, and icons.
public func == (lhs: SwitchRow, rhs: SwitchRow) -> Bool {
  return lhs.title == rhs.title && lhs.switchValue == rhs.switchValue && lhs.icon == rhs.icon
}


// MARK: - TapActionRow


/// A struct that represents a row that triggers certain action when seleced.
public struct TapActionRow: Row, Equatable {

  /// The title text of the row.
  public var title: String = ""

  /// Subtitle is disabled in TapActionRow.
  public let subtitle: Subtitle? = nil

  /// A closure as the tap action when the row is selected.
  public var action: ((Row) -> Void)?

  ///
  public init(title: String, action: ((Row) -> Void)?) {
    self.title = title
    self.action = action
  }

  private init() {}

}


// MARK: - Subtitle


/// An enum that represents a subtitle text with `UITableViewCellStyle`.
public enum Subtitle: Equatable {

  /// Does not show a subtitle.
  case none
  /// Shows the associated text in `UITableViewCellStyle.Subtitle`.
  case belowTitle(String)
  /// Shows the associated text in `UITableViewCellStyle.Value1`.
  case rightAligned(String)
  /// Shows the associated text in `UITableViewCellStyle.Value2`.
  case leftAligned(String)

  /// Returns the descriptive name of the style.
  public var style: String {
    get {
      switch self {
      case .none: return "Subtitle.None"
      case .belowTitle(_): return "Subtitle.BelowTitle"
      case .rightAligned(_): return "Subtitle.RightAligned"
      case .leftAligned(_): return "Subtitle.LeftAligned"
      }
    }
  }

  /// Returns the associated text of the case.
  public var text: String? {
    get {
      switch self {
      case .belowTitle(let text): return text
      case .rightAligned(let text): return text
      case .leftAligned(let text): return text
      default: return nil
      }
    }
  }

}

// MARK: Equatable

/// Returns true iff `lhs` and `rhs` have equal texts in the same `Subtitle`.
public func == (lhs: Subtitle, rhs: Subtitle) -> Bool {
  switch (lhs, rhs) {
  case (.none, .none):
    return true
  case (.belowTitle(let a), .belowTitle(let b)):
    return a == b
  case (.rightAligned(let a), .rightAligned(let b)):
    return a == b
  case (.leftAligned(let a), .leftAligned(let b)):
    return a == b
  default:
    return false
  }
}
