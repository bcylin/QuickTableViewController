//
//  Icon.swift
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

/// A struct that represents the image used in a row.
public struct Icon: Equatable {

  /// The image of the normal state.
  public var image: UIImage? {
    return _image ?? imageName.flatMap(UIImage.init(named:))
  }

  /// The image of the highlighted state.
  public var highlightedImage: UIImage? {
    return
      _highlightedImage ??
      (!highlightedImageName.isEmpty ? UIImage(named: highlightedImageName) : nil)
  }

  fileprivate var _image: UIImage?
  fileprivate var _highlightedImage: UIImage?

  public private(set) var imageName: String?
  public var highlightedImageName: String {
    if let name = imageName {
      return name + "-highlighted"
    } else {
      return ""
    }
  }

  /// Initializes an icon with an image name.
  public init(imageName: String) {
    self.imageName = imageName
  }

  /// Initializes an icon with images for the normal and highlighted states.
  public init(image: UIImage, highlightedImage: UIImage? = nil) {
    _image = image
    _highlightedImage = highlightedImage
  }

  // MARK: Equatable

  /// Returns true iff `lhs` and `rhs` have equal images, highlighted images and image names.
  public static func == (lhs: Icon, rhs: Icon) -> Bool {
    if let lhsName = lhs.imageName, let rhsName = rhs.imageName {
      return lhsName == rhsName
    } else {
      return lhs._image == rhs._image && lhs._highlightedImage == rhs._highlightedImage
    }
  }

}
