//
//  SettingsView.swift
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

import SwiftUI

@available(iOS 13.0, *)
struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            Section(header: Text("Switch")) {
                Toggle(isOn: $viewModel.flag1) {
                    subtitleCellStyle(title: "Setting 1", subtitle: "Example subtitle")
                        .leadingIcon("globe")
                }
                Toggle(isOn: $viewModel.flag2) {
                    subtitleCellStyle(title: "Setting 2", subtitle: nil)
                        .leadingIcon("clock.arrow.circlepath")
                }
            }

            Section(header: Text("Tap Action")) {
                Button {
                    viewModel.performTapAction()
                } label: {
                    Text("Tap action").frame(maxWidth: .infinity)
                }
            }

            Section(header: Text("Cell Style"), footer: Text("CellStyle.value2 is not implemented")) {
                subtitleCellStyle(title: "CellStyle.default", subtitle: nil)
                    .leadingIcon("gear")
                subtitleCellStyle(title: "CellStyle.default", subtitle: ".subtitle")
                    .leadingIcon("globe")
                NavigationLink(destination: EmptyView()) {
                    value1CellStyle(title: "CellStyle", detailText: ".value1")
                        .leadingIcon("clock.arrow.circlepath")
                }
            }

            Section(header: Text("Picker")) {
                Picker("Allow multiple selections", selection: $viewModel.allowsMultipleSelection) {
                    Text("No").tag(false)
                    Text("Yes").tag(true)
                }
            }

            Section(header: Text("Radio Button")) {
                ForEach(SettingsViewModel.Option.allCases) { option in
                    checkmarkCellStyle(with: option, isSelected: viewModel.isOptionSelected(option))
                }
            }
        }
    }

    private func subtitleCellStyle(title: String, subtitle: String?) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            if let subtitle = subtitle {
                Text(subtitle).font(.caption)
            }
        }
    }

    private func value1CellStyle(title: String, detailText: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(detailText).foregroundColor(.secondary)
        }
    }

    private func checkmarkCellStyle(with option: SettingsViewModel.Option, isSelected: Bool) -> some View {
        Button {
            viewModel.toggleOption(option)
        } label: {
            HStack {
                Text(option.title).foregroundColor(.primary)
                Spacer()
                Image(systemName: "checkmark").opacity(isSelected ? 1 : 0)
            }
        }
    }
}

// MARK: -

@available(iOS 13.0, *)
private extension View {
    func leadingIcon(_ systemName: String) -> some View {
        // Label { self } icon: { icon } if #available(iOS 14.0, *)
        HStack {
            Image(systemName: systemName).imageScale(.large)
            self
        }
    }
}

// MARK: -

@available(iOS 13.0, *)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
