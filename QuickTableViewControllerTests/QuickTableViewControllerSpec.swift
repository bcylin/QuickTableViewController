//
//  QuickTableViewControllerSpec.swift
//  QuickTableViewController
//
//  Created by Ben on 21/01/2016.
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

class QuickTableViewControllerSpec: QuickSpec {

  override func spec() {

    // MARK: - UITableViewDataSource

    describe("numberOfSectionsInTableView(_:)") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: []),
        Section(title: nil, rows: [])
      ]
      it("should return the number of sections") {
        expect(controller.numberOfSections(in: controller.tableView)) == 3
      }
    }

    describe("tableView(_:numberOfRowsInSection:)") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .none),
          NavigationRow(title: "", subtitle: .none)
        ])
      ]
      it("should return the number of sections") {
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 0)) == 0
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 1)) == 2
      }
    }

    describe("tableView(_:titleForHeaderInSection:") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: "title", rows: [])
      ]
      it("should return the title in sections") {
        expect(controller.tableView(controller.tableView, titleForHeaderInSection: 0)).to(beNil())
        expect(controller.tableView(controller.tableView, titleForHeaderInSection: 1)) == "title"
      }
    }

    describe("tableView(_:titleForFooterInSection:") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: [], footer: "footer")
      ]
      it("should return the title in sections") {
        expect(controller.tableView(controller.tableView, titleForFooterInSection: 0)).to(beNil())
        expect(controller.tableView(controller.tableView, titleForFooterInSection: 1)) == "footer"
      }
    }

    describe("tableView(_:cellForRowAt:)") {
      context("NavigationRow") {
        context("style") {
          let controller = QuickTableViewController()
          controller.tableContents = [
            Section(title: "Cell Styles", rows: [
              NavigationRow(title: "CellStyle.Default", subtitle: .none),
              NavigationRow(title: "CellStyle", subtitle: .belowTitle(".Subtitle")),
              NavigationRow(title: "CellStyle", subtitle: .rightAligned(".Value1")),
              NavigationRow(title: "CellStyle", subtitle: .leftAligned(".Value2"))
            ])
          ]
          let a = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
          let b = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
          let c = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
          let d = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 3, section: 0))

          it("should match the reusable identifier") {
            expect(a.reuseIdentifier) == Subtitle.none.style
            expect(b.reuseIdentifier) == Subtitle.belowTitle("").style
            expect(c.reuseIdentifier) == Subtitle.rightAligned("").style
            expect(d.reuseIdentifier) == Subtitle.leftAligned("").style
          }

          it("should match texts in labels") {
            expect(a.textLabel?.text) == "CellStyle.Default"
            expect(b.textLabel?.text) == "CellStyle"
            expect(c.textLabel?.text) == "CellStyle"
            expect(d.textLabel?.text) == "CellStyle"
          }

          it("should match texts in detail labels") {
            expect(a.detailTextLabel?.text).to(beNil())
            expect(b.detailTextLabel?.text) == ".Subtitle"
            expect(c.detailTextLabel?.text) == ".Value1"
            expect(d.detailTextLabel?.text) == ".Value2"
          }
        }

        context("icon") {
          let controller = QuickTableViewController()
          let resourcePath = Bundle(for: QuickTableViewControllerSpec.self).resourcePath as NSString?
          let imagePath = resourcePath?.appendingPathComponent("icon.png") ?? ""
          let highlightedImagePath = resourcePath?.appendingPathComponent("icon.png") ?? ""

          let image = UIImage(contentsOfFile: imagePath)!
          let highlightedImage = UIImage(contentsOfFile: highlightedImagePath)!

          controller.tableContents = [
            Section(title: "NavigationRow", rows: [
              NavigationRow(title: "CellStyle.Default", subtitle: .none, icon: Icon(imageName: "icon")),
              NavigationRow(title: "CellStyle", subtitle: .belowTitle(".Subtitle"), icon: Icon(image: image)),
              NavigationRow(title: "CellStyle", subtitle: .rightAligned(".Value1"), icon: Icon(image: image, highlightedImage: highlightedImage)),
              NavigationRow(title: "CellStyle", subtitle: .leftAligned(".Value2"), icon: Icon(image: image))
            ]),
            Section(title: "SwitchRow", rows: [
              SwitchRow(title: "imageName", switchValue: true, icon: Icon(imageName: "icon"), action: nil),
              SwitchRow(title: "image", switchValue: true, icon: Icon(image: image), action: nil),
              SwitchRow(title: "image + highlightedImage", switchValue: true, icon: Icon(image: image, highlightedImage: highlightedImage), action: nil)
            ])
          ]

          it("does not work with images in the test bundle") {
            let navigationCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            expect(navigationCell.imageView?.image).to(beNil())
            expect(navigationCell.imageView?.highlightedImage).to(beNil())

            let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
            expect(switchCell.imageView?.image).to(beNil())
            expect(switchCell.imageView?.highlightedImage).to(beNil())
          }

          it("should have image set") {
            let navigationCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
            expect(navigationCell.imageView?.image) == image
            expect(navigationCell.imageView?.highlightedImage).to(beNil())

            let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
            expect(switchCell.imageView?.image).notTo(beNil())
            expect(switchCell.imageView?.highlightedImage).to(beNil())
          }

          it("should have image and highlightedImage set") {
            let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
            expect(cell.imageView?.image).notTo(beNil())
            expect(cell.imageView?.highlightedImage).notTo(beNil())

            let switchCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 2, section: 1))
            expect(switchCell.imageView?.image).notTo(beNil())
            expect(switchCell.imageView?.highlightedImage).notTo(beNil())
          }

          it("should not have image with UITableViewCellStyle.Value2") {
            let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 3, section: 0))
            expect(cell.imageView?.image).to(beNil())
            expect(cell.imageView?.highlightedImage).to(beNil())
          }
        }

        context("indicator") {
          let controller = QuickTableViewController()
          controller.tableContents = [
            Section(title: "Navigation", rows: [
              NavigationRow(title: "Navigation", subtitle: .none, action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .belowTitle("with subtitle"), action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .rightAligned("with detail text"), action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .leftAligned("with detail text"), action: { _ in })
            ])
          ]

          it("should have have disclosure indicator") {
            for row in 0...3 {
              let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0))
              expect(cell.accessoryType) == UITableViewCellAccessoryType.disclosureIndicator
            }
          }
        }
      }

      context("SwitchRow") {
        let controller = QuickTableViewController()
        controller.tableContents = [
          Section(title: "Switch", rows: [
            SwitchRow(title: "Setting 1", switchValue: true, action: nil),
            SwitchRow(title: "Setting 2", switchValue: false, action: nil)
          ])
        ]
        let a = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let b = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 1, section: 0))

        it("should return SwitchCell") {
          expect(a).to(beAKindOf(SwitchCell.self))
          expect(b).to(beAKindOf(SwitchCell.self))
        }

        it("should have texts in labels") {
          expect(a.textLabel?.text) == "Setting 1"
          expect(b.textLabel?.text) == "Setting 2"
          expect(a.detailTextLabel?.text).to(beNil())
          expect(b.detailTextLabel?.text).to(beNil())
        }

        it("should match the switch value") {
          expect((a as? SwitchCell)?.switchControl.isOn) == true
          expect((b as? SwitchCell)?.switchControl.isOn) == false
        }
      }

      context("TapActionRow") {
        let controller = QuickTableViewController()
        controller.tableContents = [
          Section(title: "Tap Action", rows: [
            TapActionRow(title: "Tap action", action: { _ in })
          ])
        ]
        let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        it("should return TapActionCell") {
          expect(cell).to(beAKindOf(TapActionCell.self))
        }

        it("should have text in the label") {
          expect(cell.textLabel?.text) == "Tap action"
        }
      }
    }

    // MARK: - UITableViewDelegate

    describe("tableView(_:shouldHighlightRowAt:") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .none),
          NavigationRow(title: "", subtitle: .none, action: { _ in }),
          SwitchRow(title: "", switchValue: true, action: nil),
          TapActionRow(title: "", action: { _ in })
        ])
      ]

      it("should not highlight NavigationRow without an action") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: 0, section: 0))
        expect(highlight) == false
      }

      it("should highlight NavigationRow with an action") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: 1, section: 0))
        expect(highlight) == true
      }

      it("should not highlight SwitchRow") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: 2, section: 0))
        expect(highlight) == false
      }

      it("should highlight TapActionRow") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAt: IndexPath(row: 3, section: 0))
        expect(highlight) == true
      }
    }

    describe("tableView(_:didSelectRowAt:") {
      let controller = QuickTableViewController()
      var navigated = false
      var tapped = false

      controller.tableContents = [
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .none, action: { _ in navigated = true }),
          TapActionRow(title: "", action: { _ in tapped = true })
        ])
      ]

      it("should invoke the action when NavigationRow is selected") {
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        expect(navigated) == true
      }

      it("should invoke the action when TapActionRow is selected") {
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        expect(tapped) == true
      }
    }
  }

}
