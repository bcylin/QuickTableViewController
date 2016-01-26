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
        expect(controller.numberOfSectionsInTableView(controller.tableView)) == 3
      }
    }

    describe("tableView(_:numberOfRowsInsection:)") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: []),
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .None),
          NavigationRow(title: "", subtitle: .None)
        ])
      ]
      it("should return the number of sections") {
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 0)) == 0
        expect(controller.tableView(controller.tableView, numberOfRowsInSection: 1)) == 2
      }
    }


    describe("tableView(_:cellForRowAtIndexPath:)") {
      context("NavigationRow") {
        context("style") {
          let controller = QuickTableViewController()
          controller.tableContents = [
            Section(title: "Cell Styles", rows: [
              NavigationRow(title: "CellStyle.Default", subtitle: .None),
              NavigationRow(title: "CellStyle", subtitle: .BelowTitle(".Subtitle")),
              NavigationRow(title: "CellStyle", subtitle: .RightAligned(".Value1")),
              NavigationRow(title: "CellStyle", subtitle: .LeftAligned(".Value2"))
            ])
          ]
          let a = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
          let b = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
          let c = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 2, inSection: 0))
          let d = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 3, inSection: 0))

          it("should match the reusable identifier") {
            expect(a.reuseIdentifier) == Subtitle.None.style
            expect(b.reuseIdentifier) == Subtitle.BelowTitle("").style
            expect(c.reuseIdentifier) == Subtitle.RightAligned("").style
            expect(d.reuseIdentifier) == Subtitle.LeftAligned("").style
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
          let resourcePath: NSString! = NSBundle(forClass: QuickTableViewControllerSpec.self).resourcePath
          let imagePath = resourcePath.stringByAppendingPathComponent("icon.png")
          let highlightedImagePath = resourcePath.stringByAppendingPathComponent("icon.png")
          controller.tableContents = [
            Section(title: "Cell Styles", rows: [
              NavigationRow(title: "CellStyle.Default", subtitle: .None, icon: Icon(imageName: "icon")),
              NavigationRow(title: "CellStyle", subtitle: .BelowTitle(".Subtitle"), icon: Icon(image: UIImage(contentsOfFile: imagePath)!)),
              NavigationRow(title: "CellStyle", subtitle: .RightAligned(".Value1"), icon: Icon(image: UIImage(contentsOfFile: imagePath)!, highlightedImage: UIImage(contentsOfFile: highlightedImagePath)!)),
              NavigationRow(title: "CellStyle", subtitle: .LeftAligned(".Value2"), icon: Icon(imageName: "icon"))
            ])
          ]

          it("should not work with images in the test bundle") {
            let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
            expect(cell.imageView?.image).to(beNil())
            expect(cell.imageView?.highlightedImage).to(beNil())
          }

          it("should have image with UITableViewCellStyle.Subtitle") {
            let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
            expect(cell.imageView?.image).notTo(beNil())
            expect(cell.imageView?.highlightedImage).to(beNil())
          }

          it("should have image with UITableViewCellStyle.Value1") {
            let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 2, inSection: 0))
            expect(cell.imageView?.image).notTo(beNil())
            expect(cell.imageView?.highlightedImage).notTo(beNil())
          }

          it("should not have image with UITableViewCellStyle.Value2") {
            let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 3, inSection: 0))
            expect(cell.imageView?.image).to(beNil())
            expect(cell.imageView?.highlightedImage).to(beNil())
          }
        }

        context("indicator") {
          let controller = QuickTableViewController()
          controller.tableContents = [
            Section(title: "Navigation", rows: [
              NavigationRow(title: "Navigation", subtitle: .None, action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .BelowTitle("with subtitle"), action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .RightAligned("with detail text"), action: { _ in }),
              NavigationRow(title: "Navigation", subtitle: .LeftAligned("with detail text"), action: { _ in })
            ])
          ]

          it("should have have disclosure indicator") {
            for row in 0...3 {
              let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: row, inSection: 0))
              expect(cell.accessoryType) == UITableViewCellAccessoryType.DisclosureIndicator
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
        let a = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        let b = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))

        it("should return SwitchCell") {
          expect(a).to(beAKindOf(SwitchCell))
          expect(b).to(beAKindOf(SwitchCell))
        }

        it("should have texts in labels") {
          expect(a.textLabel?.text) == "Setting 1"
          expect(b.textLabel?.text) == "Setting 2"
          expect(a.detailTextLabel?.text).to(beNil())
          expect(b.detailTextLabel?.text).to(beNil())
        }

        it("should match the switch value") {
          expect((a as? SwitchCell)?.switchControl.on) == true
          expect((b as? SwitchCell)?.switchControl.on) == false
        }
      }

      context("TapActionRow") {
        let controller = QuickTableViewController()
        controller.tableContents = [
          Section(title: "Tap Action", rows: [
            TapActionRow(title: "Tap action", action: { _ in })
          ])
        ]
        let cell = controller.tableView(controller.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))

        it("should return TapActionCell") {
          expect(cell).to(beAKindOf(TapActionCell))
        }

        it("should have text in the label") {
          expect(cell.textLabel?.text) == "Tap action"
        }
      }
    }

    // MARK: - UITableViewDelegate

    describe("tableView(_:shouldHighlightRowAtIndexPath:") {
      let controller = QuickTableViewController()
      controller.tableContents = [
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .None),
          NavigationRow(title: "", subtitle: .None, action: { _ in }),
          SwitchRow(title: "", switchValue: true, action: nil),
          TapActionRow(title: "", action: { _ in })
        ])
      ]

      it("should not highlight NavigationRow without an action") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        expect(highlight) == false
      }

      it("should highlight NavigationRow with an action") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        expect(highlight) == true
      }

      it("should not highlight SwitchRow") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forRow: 2, inSection: 0))
        expect(highlight) == false
      }

      it("should highlight TapActionRow") {
        let highlight = controller.tableView(controller.tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forRow: 3, inSection: 0))
        expect(highlight) == true
      }
    }

    describe("tableView(_:didSelectRowAtIndexPath:") {
      let controller = QuickTableViewController()
      var navigated = false
      var tapped = false

      controller.tableContents = [
        Section(title: nil, rows: [
          NavigationRow(title: "", subtitle: .None, action: { _ in navigated = true }),
          TapActionRow(title: "", action: { _ in tapped = true })
        ])
      ]

      it("should invoke the action when NavigationRow is selected") {
        controller.tableView(controller.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        expect(navigated) == true
      }

      it("should invoke the action when TapActionRow is selected") {
        controller.tableView(controller.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        expect(tapped) == true
      }
    }
  }

}
