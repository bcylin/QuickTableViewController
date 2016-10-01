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
import QuickTableViewController

class NavigationRowSpec: QuickSpec {

  override func spec() {
    describe("initialization") {
      let subtitle = Subtitle.belowTitle("subtitle")
      let icon = Icon(imageName: "icon")

      var invoked = false
      let row = NavigationRow(title: "title", subtitle: subtitle, icon: icon, action: { _ in invoked = true })

      it("should initialize with given parameters") {
        expect(row.title) == "title"
        expect(row.subtitle) == subtitle
        expect(row.icon) == icon
        expect(row.action).notTo(beNil())

        row.action?(row)
        expect(invoked) == true
      }
    }

    describe("equatable") {
      let image = UIImage()
      let a = NavigationRow(title: "Same", subtitle: .belowTitle("Same"), icon: Icon(image: image), action: nil)

      context("identical parameters") {
        let b = NavigationRow(title: "Same", subtitle: .belowTitle("Same"), icon: Icon(image: image), action: nil)
        it("should be equal") {
          expect(a) == b
        }
      }

      context("different titles") {
        let c = NavigationRow(title: "Different", subtitle: .belowTitle("Same"), icon: Icon(image: image), action: nil)
        it("should not be equal") {
          expect(a) != c
        }
      }

      context("different subtitles") {
        let d = NavigationRow(title: "Same", subtitle: .belowTitle("Different"), icon: Icon(image: image), action: nil)
        it("should not be equal") {
          expect(a) != d
        }
      }

      context("different icons") {
        let e = NavigationRow(title: "Same", subtitle: .belowTitle("Same"), icon: Icon(image: UIImage()), action: nil)
        it("should not be equal") {
          expect(a) != e
        }
      }

      context("different actions") {
        let f = NavigationRow(title: "Same", subtitle: .belowTitle("Same"), icon: Icon(image: image), action: { _ in })
        it("should be equal regardless the actions attached") {
          expect(a) == f
        }
      }
    }
  }

}
