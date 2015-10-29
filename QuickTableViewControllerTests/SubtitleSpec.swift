//
//  SubtitleSpec.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 28/10/2015.
//  Copyright © 2015 bcylin. All rights reserved.
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

import XCTest
import QuickTableViewController

class SubtitleSpec: XCTestCase {

  func testEqualityInContextOfNone() {
    let a = Subtitle.None
    let b = Subtitle.None
    XCTAssert(a == b)
  }

  func testEqualityInContextOfBelowTitle() {
    let a = Subtitle.BelowTitle("Same")
    let b = Subtitle.BelowTitle("Same")
    let c = Subtitle.BelowTitle("Different")
    let d = Subtitle.RightAligned("Same")
    let e = Subtitle.None
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }

  func testEqualityInContextOfRightAligned() {
    let a = Subtitle.RightAligned("Same")
    let b = Subtitle.RightAligned("Same")
    let c = Subtitle.RightAligned("Different")
    let d = Subtitle.LeftAligned("Same")
    let e = Subtitle.None
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }

  func testEqualityInContextOfLeftAligned() {
    let a = Subtitle.LeftAligned("Same")
    let b = Subtitle.LeftAligned("Same")
    let c = Subtitle.LeftAligned("Different")
    let d = Subtitle.BelowTitle("Same")
    let e = Subtitle.None
    XCTAssert(a == b)
    XCTAssert(a != c)
    XCTAssert(a != d)
    XCTAssert(a != e)
  }

}
