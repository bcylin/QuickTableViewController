//
//  RowSpec.swift
//  QuickTableViewController
//
//  Created by Ben on 28/10/2015.
//  Copyright © 2015 bcylin. All rights reserved.
//

import XCTest
import QuickTableViewController

class RowSpec: XCTestCase {

  func testIconEquality() {
    let image = UIImage()
    let a = Icon(image: image)
    let b = Icon(image: image)
    XCTAssert(a == b)

    let c = Icon(image: UIImage())
    XCTAssert(a != c)

    let d = Icon(image: image, highlightedImage: nil)
    XCTAssert(a == d)

    let e = Icon(image: image, highlightedImage: UIImage())
    XCTAssert(a != e)

    let f = Icon(imageName: "Same")
    XCTAssert(a != f)

    let g = Icon(imageName: "Same")
    XCTAssert(f == g)

    let h = Icon(imageName: "Different")
    XCTAssert(f != h)
  }

  func testNavitationRowEquality() {
    let image = UIImage()
    let a = NavigationRow(title: "Same", subtitle: .BelowTitle("Same"), icon: Icon(image: image), action: nil)
    let b = NavigationRow(title: "Same", subtitle: .BelowTitle("Same"), icon: Icon(image: image), action: nil)
    XCTAssert(a == b)

    let c = NavigationRow(title: "Different", subtitle: .BelowTitle("Same"), icon: Icon(image: image), action: nil)
    XCTAssert(a != c)

    let d = NavigationRow(title: "Same", subtitle: .BelowTitle("Different"), icon: Icon(image: image), action: nil)
    XCTAssert(a != d)

    let e = NavigationRow(title: "Same", subtitle: .BelowTitle("Same"), icon: Icon(image: UIImage()), action: nil)
    XCTAssert(a != e)

    let f = NavigationRow(title: "Same", subtitle: .BelowTitle("Same"), icon: Icon(image: image), action: { _ in })
    XCTAssert(a == f)
  }

  func testSwitchRowEquality() {
    let a = SwitchRow(title: "Same", switchValue: true, action: nil)
    let b = SwitchRow(title: "Same", switchValue: true, action: nil)
    XCTAssert(a == b)

    let c = SwitchRow(title: "Same", switchValue: false, action: nil)
    XCTAssert(a != c)

    let d = SwitchRow(title: "Different", switchValue: true, action: nil)
    XCTAssert(a != d)

    let e = SwitchRow(title: "Same", switchValue: true, action: { _ in })
    XCTAssert(a == e)
  }

  func testTapActionRowEquality() {
    let a = TapActionRow(title: "Same", action: nil)
    let b = TapActionRow(title: "Same", action: nil)
    XCTAssert(a == b)

    let c = TapActionRow(title: "Different", action: nil)
    XCTAssert(a != c)

    let d = TapActionRow(title: "Same", action: { _ in })
    XCTAssert(a == d)
  }

}
