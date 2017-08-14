//
//  SwitchRowSpec.swift
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

internal final class SwitchRowSpec: QuickSpec {

  override func spec() {
    describe("initialization") {
      var invoked = false
      let row = SwitchRow(title: "title", switchValue: true) { _ in invoked = true }

      it("should initialize with given parameters") {
        expect(row.title) == "title"
        expect(row.switchValue) == true
        expect(row.cellReuseIdentifier) == "SwitchCell"
        expect(row.action).notTo(beNil())

        row.action?(row)
        expect(invoked) == true
      }
    }

    describe("equatable") {
      let a = SwitchRow(title: "Same", switchValue: true, action: nil)

      context("identical parameters") {
        let b = SwitchRow(title: "Same", switchValue: true, action: nil)
        it("should be qeaul") {
          expect(a) == b
        }
      }

      context("different titles") {
        let c = SwitchRow(title: "Different", switchValue: true, action: nil)
        it("should not be eqaul") {
          expect(a) != c
        }
      }

      context("different switch values") {
        let d = SwitchRow(title: "Same", switchValue: false, action: nil)
        it("should not be equal") {
          expect(a) != d
        }
      }

      context("different actions") {
        let e = SwitchRow(title: "Same", switchValue: true, action: { _ in })
        it("should be equal regardless the actions attached") {
          expect(a) == e
        }
      }
    }

    describe("action invocation") {
      var toggled = false
      let row = SwitchRow(title: "", switchValue: false) { _ in toggled = !toggled }

      // The action invocation has moved to the view controller.
      it("should not invoke the action closure when the value changes") {
        row.switchValue = true
        expect(toggled) == false
      }
    }
  }

}
