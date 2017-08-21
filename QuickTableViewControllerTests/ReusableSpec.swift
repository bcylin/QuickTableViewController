//
//  ReusableSpec.swift
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

import Nimble
import Quick
@testable import QuickTableViewController

internal final class ReusableSpec: QuickSpec {

  private class CustomCell: UITableViewCell {}

  override func spec() {
    describe("matches of pattern") {
      context("invalid pattern") {
        it("should return an empty array") {
          let matches = String(describing: type(of: self)).matches(of: "\\")
          expect(matches).to(beEmpty())
        }
      }
    }

    describe("type string") {
      let pattern = "^\\(([\\w\\d]+)\\sin\\s_[0-9A-F]+\\)$"

      context("custom type") {
        it("should match the pattern") {
          let type = String(describing: CustomCell.self)
          let matches = type.matches(of: pattern)
          expect(matches).to(haveCount(2))
        }
      }

      context("type in the module") {
        it("should not match the pattern") {
          let type = String(describing: SwitchCell.self)
          let matches = type.matches(of: pattern)
          expect(matches).to(beEmpty())
        }
      }
    }

    describe("reuse identifier") {
      context("custom type") {
        it("should be the type name") {
          let identifier = CustomCell.reuseIdentifier
          expect(identifier) == "CustomCell"
        }
      }

      context("type in the module") {
        it("should be the type name") {
          let identifier = SwitchCell.reuseIdentifier
          expect(identifier) == "SwitchCell"
        }
      }
    }
  }

}
