//
//  SubtitleSpec.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 28/10/2015.
//  Copyright © 2015 bcylin.
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

import Nimble
import Quick
import QuickTableViewController

class SubtitleSpec: QuickSpec {

  override func spec() {
    describe("subtitle style") {
      it("should return the descriptive name of the style") {
        expect(Subtitle.None.style) == "Subtitle.None"
        expect(Subtitle.BelowTitle("text").style) == "Subtitle.BelowTitle"
        expect(Subtitle.RightAligned("text").style) == "Subtitle.RightAligned"
        expect(Subtitle.LeftAligned("text").style) == "Subtitle.LeftAligned"
      }
    }

    describe("associtated value") {
      let none = Subtitle.None
      let belowTitle = Subtitle.BelowTitle("text")
      let rightAligned = Subtitle.RightAligned("text")
      let leftAligned = Subtitle.LeftAligned("text")

      it("should return the associated text") {
        expect(none.text).to(beNil())
        expect(belowTitle.text) == "text"
        expect(rightAligned.text) == "text"
        expect(leftAligned.text) == "text"
      }
    }

    describe("equatable") {
      context(".None") {
        it("should be equal when both are .None") {
          let a = Subtitle.None
          let b = Subtitle.None
          expect(a) == b
        }
      }

      context(".BelowTitle") {
        let a = Subtitle.BelowTitle("Same")
        let b = Subtitle.BelowTitle("Same")
        let c = Subtitle.BelowTitle("Different")
        let d = Subtitle.RightAligned("Same")
        let e = Subtitle.None

        it("should be equal only when type and associated value match") {
          expect(a) == b
          expect(a) != c
          expect(a) != d
          expect(a) != e
        }
      }

      context(".RightAligned") {
        let a = Subtitle.RightAligned("Same")
        let b = Subtitle.RightAligned("Same")
        let c = Subtitle.RightAligned("Different")
        let d = Subtitle.LeftAligned("Same")
        let e = Subtitle.None

        it("should be equal only when type and associated value match") {
          expect(a) == b
          expect(a) != c
          expect(a) != d
          expect(a) != e
        }
      }

      context(".LeftAligned") {
        let a = Subtitle.LeftAligned("Same")
        let b = Subtitle.LeftAligned("Same")
        let c = Subtitle.LeftAligned("Different")
        let d = Subtitle.BelowTitle("Same")
        let e = Subtitle.None

        it("should be equal only when type and associated value match") {
          expect(a) == b
          expect(a) != c
          expect(a) != d
          expect(a) != e
        }
      }
    }
  }

}
