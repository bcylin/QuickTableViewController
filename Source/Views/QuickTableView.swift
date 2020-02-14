//
//  File.swift
//  
//
//  Created by Zachary Gorak on 2/14/20.
//

import Foundation
import UIKit

open class QuickTableView: UITableView {
    internal var quickDelegate: QuickTableViewDelegate? = nil
    
    override open func reloadData() {
        self.quickDelegate?.quickReload()
        super.reloadData()
    }
  
  override open func reloadSectionIndexTitles() {
    self.quickDelegate?.quickReload()
    super.reloadSectionIndexTitles()
  }
  
  override open func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.reloadSections(sections, with: animation)
  }
  
  override open func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    self.quickDelegate?.quickReload()
    super.reloadRows(at: indexPaths, with: animation)
  }
}
