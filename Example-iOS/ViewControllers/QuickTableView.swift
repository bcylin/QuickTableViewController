//
//  QuickTableView.swift
//  QuickTableViewController
//
//  Created by Zac on 14/02/2020.
//  Copyright (c) 2015 bcylin.
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

import Foundation
import UIKit

open class QuickTableView: UITableView {
    internal weak var quickDelegate: QuickTableViewDelegate?

    override open func reloadData() {
        self.quickDelegate?.quickReload()
        super.reloadData()
    }

  // MARK: Rows

  override open func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.reloadRows(at: indexPaths, with: animation)
  }

  override open func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.insertRows(at: indexPaths, with: animation)
  }

  override open func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.deleteRows(at: indexPaths, with: animation)
  }

  override open func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
    self.quickDelegate?.quickReload()
    super.moveRow(at: indexPath, to: newIndexPath)
  }

  // MARK: Sections

  override open func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.reloadSections(sections, with: animation)
  }

  override open func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.deleteSections(sections, with: animation)
  }

  override open func insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.insertSections(sections, with: animation)
  }

  override open func reloadSectionIndexTitles() {
    self.quickDelegate?.quickReload()
    super.reloadSectionIndexTitles()
  }

  override open func moveSection(_ section: Int, toSection newSection: Int) {
    self.quickDelegate?.quickReload()
    super.moveSection(section, toSection: newSection)
  }
}
