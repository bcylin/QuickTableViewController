//
//  TapActionRowSpec.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 17/01/2016.
//  Copyright © 2016 bcylin.
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

internal final class TapActionRowSpec: QuickSpec {

  override func spec() {
    describe("initialization") {
      var invoked = false
      let row = TapActionRow(text: "title") { _ in invoked = true }

      it("should initialize with given parameters") {
        expect(row.text) == "title"
        expect(row.cellReuseIdentifier) == "TapActionCell"

        row.action?(row)
        expect(invoked) == true
      }

      it("should conform to the protocol") {
        expect(row).to(beAKindOf(TapActionRowCompatible.self))
      }
    }

    describe("equatable") {
      let row = TapActionRow(text: "Same", action: nil)

      context("identical titles") {
        let this = TapActionRow(text: "Same", action: nil)
        it("should be equal") {
          expect(this) == row
        }
      }

      context("different texts") {
        let this = TapActionRow(text: "Different", action: nil)
        it("should not be equal") {
          expect(this) != row
        }
      }

      context("different actions") {
        let this = TapActionRow(text: "Same", action: { _ in })
        it("should be equal regardless of the actions attached") {
          expect(this) == row
        }
      }
    }
  }

}
