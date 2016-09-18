//
//  QuickTableViewCell.swift
//  QuickTableViewController
//
//  Created by Ben on 03/09/2015.
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

/// A `UITableViewCell` subclass with the title text center aligned.
public class TapActionCell: UITableViewCell {

  private static var systemTintColor: UIColor = {
    let _button = UIButton()
    return _button.tintColor ?? UIColor.blue
  }()

  // MARK: Initializer

  /**
   Overrides `UITableViewCell`'s designated initializer.

   - parameter style:           Unused. It always uses `UITableViewCellStyle.Default`.
   - parameter reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view.

   - returns: An initialized `TapActionCell` object.
   */
  override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    setUpAppearance()
  }

  /**
   Overrides the designated initializer that returns an object initialized from data in a given unarchiver.

   - parameter aDecoder: An unarchiver object.

   - returns: `self`, initialized using the data in decoder.
   */
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpAppearance()
  }

  // MARK: Private Methods

  private func setUpAppearance() {
    textLabel?.textAlignment = .center
    textLabel?.textColor = type(of: self).systemTintColor
  }

}


// MARK: - SwitchCell


/// A `UITableViewCell` subclass that shows a `UISwitch` as the `accessoryView`.
public class SwitchCell: UITableViewCell {

  /// A `UISwitch` as the `accessoryView`.
  public let switchControl = UISwitch()

  // MARK: Initializer

  /**
   Overrides `UITableViewCell`'s designated initializer.

   - parameter style:           Unused. It always uses `UITableViewCellStyle.Default`.
   - parameter reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view.

   - returns: An initialized `SwitchCell` object.
   */
  override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    accessoryView = switchControl
  }

  /**
   Overrides the designated initializer that returns an object initialized from data in a given unarchiver.

   - parameter aDecoder: An unarchiver object.

   - returns: `self`, initialized using the data in decoder.
   */
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    accessoryView = switchControl
  }

}
