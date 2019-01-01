//
//  NavigationRowSpec.swift
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
@testable import QuickTableViewController

internal final class NavigationRowSpec: QuickSpec {

  override func spec() {
    describe("initialization") {
      let detailText = DetailText.subtitle("subtitle")
      let icon = Icon.named("icon")

      var invoked = false
      let row = NavigationRow(text: "title", detailText: detailText, icon: icon, action: { _ in invoked = true })

      it("should initialize with given parameters") {
        expect(row.text) == "title"
        expect(row.detailText) == detailText
        expect(row.icon) == icon
        expect(row.cellReuseIdentifier) == "UITableViewCell.subtitle"

        row.action?(row)
        expect(invoked) == true
      }

      it("should conform to the protocol") {
        expect(row).to(beAKindOf(NavigationRowCompatible.self))
      }
    }

    describe("cellReuseIdentifier") {
      let a = NavigationRow(text: "", detailText: .none)
      let b = NavigationRow(text: "", detailText: .subtitle(""))
      let c = NavigationRow(text: "", detailText: .value1(""))
      let d = NavigationRow(text: "", detailText: .value2(""))

      it("should return the backward compatible strings") {
        expect(a.cellReuseIdentifier) == "UITableViewCell.default"
        expect(b.cellReuseIdentifier) == "UITableViewCell.subtitle"
        expect(c.cellReuseIdentifier) == "UITableViewCell.value1"
        expect(d.cellReuseIdentifier) == "UITableViewCell.value2"
      }
    }

    describe("equatable") {
      let image = UIImage()
      let a = NavigationRow(text: "Same", detailText: .subtitle("Same"), icon: .image(image), action: nil)

      context("identical parameters") {
        let b = NavigationRow(text: "Same", detailText: .subtitle("Same"), icon: .image(image), action: nil)
        it("should be equal") {
          expect(a) == b
        }
      }

      context("different titles") {
        let c = NavigationRow(text: "Different", detailText: .subtitle("Same"), icon: .image(image), action: nil)
        it("should not be equal") {
          expect(a) != c
        }
      }

      context("different subtitles") {
        let d = NavigationRow(text: "Same", detailText: .subtitle("Different"), icon: .image(image), action: nil)
        it("should not be equal") {
          expect(a) != d
        }
      }

      context("different icons") {
        let e = NavigationRow(text: "Same", detailText: .subtitle("Same"), icon: .image(UIImage()), action: nil)
        it("should not be equal") {
          expect(a) != e
        }
      }

      context("different actions") {
        let f = NavigationRow(text: "Same", detailText: .subtitle("Same"), icon: .image(image), action: { _ in })
        it("should be equal regardless of the actions attached") {
          expect(a) == f
        }
      }
    }
  }

}
