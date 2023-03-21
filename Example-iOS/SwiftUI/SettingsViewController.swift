//
//  SettingsViewController.swift
//  Example-iOS
//
//  Created by Ben on 14/08/2022.
//  Copyright © 2022 bcylin.
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

import Combine
import SwiftUI

@available(iOS 13.0, *)
final class SettingsViewController: UIHostingController<SettingsView> {

    private var observations: Set<AnyCancellable> = []

    init(settings: SettingsViewModel) {
        super.init(rootView: SettingsView(viewModel: settings))
        title = "Settings"
        observeChanges(in: settings)

        settings.navigationFlow = { [weak self] in
            self?.showDetail()
        }
    }

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func observeChanges(in settings: SettingsViewModel) {
        settings.tapAction = {
            print("settings.tapAction")
        }

        settings.$flag1.sink { value in
            print("settings.flag1 = \(value)")
        }.store(in: &observations)

        settings.$flag2.sink { value in
            print("settings.flag2 = \(value)")
        }.store(in: &observations)

        settings.$allowsMultipleSelection.sink { value in
            print("settings.allowsMultipleSelection = \(value)")
        }.store(in: &observations)

        settings.$selections.sink { selections in
            print("settings.selections = \(selections.map(\.title).sorted())")
        }.store(in: &observations)
    }

    private func showDetail() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        controller.title = "CellStyle.value1"
        navigationController?.pushViewController(controller, animated: true)
    }

}
