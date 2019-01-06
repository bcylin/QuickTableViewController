//
//  OptionRowSpec.swift
//  QuickTableViewControllerTests
//
//  Created by Ben on 17/08/2017.
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

import Nimble
import Quick
import QuickTableViewController

internal final class OptionRowSpec: QuickSpec {

  override func spec() {
    describe("initialiation") {
      let detailText = DetailText.subtitle("subtitle")
      let icon = Icon.named("icon")

      var invoked = false
      let row = OptionRow(text: "title", detailText: detailText, isSelected: true, icon: icon) { _ in invoked = true }

      it("should initialize with given parameters") {
        // Row
        expect(row.text) == "title"
        expect(row.detailText) == detailText
        expect(row.isSelected) == true

        row.action?(row)
        expect(invoked) == true

        // RowStyle
        expect(row.cellReuseIdentifier) == "UITableViewCell"
        expect(row.cellStyle) == UITableViewCell.CellStyle.default
        expect(row.icon) == icon
        expect(row.accessoryType) == UITableViewCell.AccessoryType.checkmark
        expect(row.isSelectable) == true
        expect(row.customize).to(beNil())
      }

      it("should conform to the protocol") {
        expect(row).to(beAKindOf(OptionRowCompatible.self))
      }
    }

    describe("equatable") {
      let row = OptionRow(text: "Same", isSelected: true, action: nil)

      context("identical parameters") {
        let this = OptionRow(text: "Same", isSelected: true, action: nil)
        it("should be qeaul") {
          expect(this) == row
        }
      }

      context("different texts") {
        let this = OptionRow(text: "Different", isSelected: true, action: nil)
        it("should not be eqaul") {
          expect(this) != row
        }
      }

      context("different detail texts") {
        let this = OptionRow(text: "Same", detailText: .subtitle("Different"), isSelected: true, action: nil)
        it("should not be equal") {
          expect(this) != row
        }
      }

      context("different selection state") {
        let this = OptionRow(text: "Same", isSelected: false, action: nil)
        it("should not be equal") {
          expect(this) != row
        }
      }

      context("different icons") {
        let this = OptionRow(text: "Same", isSelected: true, icon: .image(UIImage()), action: nil)
        it("should not be equal") {
          expect(this) != row
        }
      }

      context("different actions") {
        let this = OptionRow(text: "Same", isSelected: true, action: { _ in })
        it("should be equal regardless of the actions attached") {
          expect(this) == row
        }
      }
    }

    describe("action invocation") {
      context("when the selection is toggled") {
        var invoked = false
        let row = OptionRow(text: "", isSelected: false) { _ in invoked = true }

        it("should invoke the action closure") {
          row.isSelected = true
          expect(row.accessoryType) == UITableViewCell.AccessoryType.checkmark
          expect(invoked).toEventually(beTrue())
        }
      }

      context("when the selection stays the same") {
        var invoked = false
        let row = OptionRow(text: "", isSelected: false) { _ in invoked = true }

        it("should not invoke the action closure") {
          row.isSelected = false
          expect(row.accessoryType) == UITableViewCell.AccessoryType.none
          expect(invoked).toEventually(beFalse())
        }
      }
    }
  }

}
