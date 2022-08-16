//
//  SettingsViewModel.swift
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

import Foundation

@available(iOS 13.0, *)
final class SettingsViewModel: ObservableObject {

    // MARK: - Switch

    @Published var flag1 = true
    @Published var flag2 = false

    // MARK: - Tap Action

    var tapAction: (() -> Void)?

    func performTapAction() {
        tapAction?()
    }

    // MARK: - Navigation

    var navigationFlow: (() -> Void)?

    func startNavigationFlow() {
        navigationFlow?()
    }

    // MARK: - Options

    enum Option: String, CaseIterable, Identifiable {
        case option1 = "Option 1"
        case option2 = "Option 2"
        case option3 = "Option 3"

        var id: Self { self }
        var title: String { rawValue }
    }

    @Published var allowsMultipleSelection = false {
        didSet {
            selections = [.option1]
        }
    }
    @Published var selections: Set<Option> = [.option1]

    func isOptionSelected(_ option: Option) -> Bool {
        selections.contains(option)
    }

    func toggleOption(_ option: Option) {
        let keepsAtLeastOneOptionSelected = true
        if keepsAtLeastOneOptionSelected && selections == [option] {
            return
        }

        if selections.contains(option) {
            selections.remove(option)
        } else if allowsMultipleSelection {
            selections.insert(option)
        } else {
            selections = [option]
        }
    }
}
