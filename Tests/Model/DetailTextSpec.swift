//
//  DetailTextSpec.swift
//  QuickTableViewController
//
//  Created by bcylin on 31/12/2018.
//  Copyright © 2018 bcylin.
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

internal final class DetailTextSpec: QuickSpec {

  override func spec() {
    describe("cell style") {
      it("should return the descriptive name of the style") {
        expect(DetailText.none.style) == .default
        expect(DetailText.subtitle("text").style) == .subtitle
        expect(DetailText.value1("text").style) == .value1
        expect(DetailText.value2("text").style) == .value2
      }
    }

    describe("associtated value") {
      it("should return the associated text") {
        expect(DetailText.none.text).to(beNil())
        expect(DetailText.subtitle("3").text) == "3"
        expect(DetailText.value1("1").text) == "1"
        expect(DetailText.value2("2").text) == "2"
      }
    }

    describe("equatable") {
      context(".none") {
        it("should be equal when both are .none") {
          let a = DetailText.none
          let b = DetailText.none
          expect(a) == b
        }
      }

      context(".subtitle") {
        let a = DetailText.subtitle("Same")
        let b = DetailText.subtitle("Same")
        let c = DetailText.subtitle("Different")
        let d = DetailText.value1("Same")
        let e = DetailText.none

        it("should be equal only when type and associated value match") {
          expect(a) == b
          expect(a) != c
          expect(a) != d
          expect(a) != e
        }
      }

      context(".value1") {
        let a = DetailText.value1("Same")
        let b = DetailText.value1("Same")
        let c = DetailText.value1("Different")
        let d = DetailText.value2("Same")
        let e = DetailText.none

        it("should be equal only when type and associated value match") {
          expect(a) == b
          expect(a) != c
          expect(a) != d
          expect(a) != e
        }
      }

      context(".value2") {
        let a = DetailText.value2("Same")
        let b = DetailText.value2("Same")
        let c = DetailText.value2("Different")
        let d = DetailText.subtitle("Same")
        let e = DetailText.none

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
