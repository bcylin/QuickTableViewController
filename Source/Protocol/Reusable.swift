//
//  Reusable.swift
//  QuickTableViewController
//
//  Created by Ben on 21/08/2017.
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

extension UITableViewCell: Reusable {}


internal protocol Reusable {
  static var reuseIdentifier: String { get }
}


internal extension Reusable {

  internal static var reuseIdentifier: String {
    let type = String(describing: self)
    return type.matches(of: "^\\(([\\w\\d]+)\\sin\\s_[0-9A-F]+\\)$").last ?? type
  }

}


internal extension String {

  func matches(of pattern: String) -> [String] {
    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let fullText = NSRange(location: 0, length: characters.count)

    guard let matches = regex?.matches(in: self, options: [], range: fullText) else {
      return []
    }

    return matches.reduce([]) { accumulator, match in
      accumulator + (0..<match.numberOfRanges).map {
        (self as NSString).substring(with: match.range(at: $0))
      }
    }
  }

}
