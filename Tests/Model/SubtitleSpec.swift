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
@testable import QuickTableViewController

@available(*, deprecated, message: "Compatibility tests")
internal final class SubtitleSpec: QuickSpec {

  override func spec() {
    describe("compatibility") {
      it("should return the corresponding detail text") {
        expect(Subtitle.none.detailText) == DetailText.none
        expect(Subtitle.belowTitle("text").detailText) == .subtitle("text")
        expect(Subtitle.rightAligned("text").detailText) == .value1("text")
        expect(Subtitle.leftAligned("text").detailText) == .value2("text")
      }

      context("NavigationRow") {
        let subtitle = Subtitle.belowTitle("detail text")
        let detailText = DetailText.subtitle("detail text")
        let icon = Icon.named("icon")

        var invoked = false
        let row = NavigationRow(title: "text", subtitle: subtitle, icon: icon, action: { _ in invoked = true })

        it("should support deprecated initializers") {
          expect(row.text) == "text"
          expect(row.detailText) == detailText
          expect(row.icon) == icon
          expect(row.cellReuseIdentifier) == "UITableViewCell.subtitle"

          row.action?(row)
          expect(invoked) == true
        }

        it("should support deprecated properties") {
          expect(row.title) == "text"
          expect(row.subtitle?.text) == "detail text"
        }
      }

      context("OptionRow") {
        let icon = Icon.named("icon")

        var invoked = false
        let row = OptionRow(title: "text", isSelected: true, icon: icon) { _ in invoked = true }

        it("should support deprecated initializers") {
          // Row
          expect(row.text) == "text"
          expect(row.detailText).to(beNil())
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

        it("should support deprecated properties") {
          expect(row.title) == "text"
          expect(row.subtitle?.text).to(beNil())
        }
      }

      context("SwitchRow") {
        var invoked = false
        let row = SwitchRow(title: "text", switchValue: true) { _ in invoked = true }

        it("should support deprecated initializers") {
          expect(row.text) == "text"
          expect(row.detailText).to(beNil())
          expect(row.switchValue) == true
          expect(row.cellReuseIdentifier) == "SwitchCell"

          row.action?(row)
          expect(invoked) == true
        }

        it("should support deprecated properties") {
          expect(row.title) == "text"
          expect(row.subtitle?.text).to(beNil())
        }
      }

      context("TapActionRow") {
        var invoked = false
        let row = TapActionRow(title: "text") { _ in invoked = true }

        it("should initialize with given parameters") {
          expect(row.text) == "text"
          expect(row.detailText).to(beNil())
          expect(row.cellReuseIdentifier) == "TapActionCell"

          row.action?(row)
          expect(invoked) == true
        }

        it("should support deprecated properties") {
          expect(row.title) == "text"
          expect(row.subtitle?.text).to(beNil())
        }
      }
    }
  }

}
