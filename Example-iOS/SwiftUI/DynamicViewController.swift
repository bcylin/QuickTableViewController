//
//  DynamicViewController.swift
//  Example-iOS
//
//  Created by Ben on 13/08/2022.
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
final class DynamicViewController: UIHostingController<DynamicTableView> {

    init() {
        super.init(rootView: DynamicTableView())
        title = "Dynamic"
    }

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModel

@available(iOS 13.0, *)
private final class ViewModel: ObservableObject {
    @Published var items: [Item] = []

    struct Item: Hashable, Identifiable {
        let id = UUID()
        let title: String
        let number: Int
    }

    func addItem() {
        let newItem = Item(title: "UITableViewCell", number: items.count + 1)
        items.append(newItem)
    }
}

// MARK: - View

@available(iOS 13.0, *)
struct DynamicTableView: View {
    @ObservedObject private var viewModel = ViewModel()
    @State private var editMode: EditMode = .inactive

    var body: some View {
        List {
            Section(header: Text("SwiftUI Example")) {
                addButton
                list(of: viewModel.items)
            }
        }
        .withEditButton()
        .environment(\.editMode, $editMode)
    }

    private var addButton: some View {
        Button {
            withAnimation { viewModel.addItem() }
        } label: {
            Text("Add")
                .frame(maxWidth: .infinity)
                .foregroundColor(editMode == .active ? .gray : .blue)
        }
    }

    private func list(of items: [ViewModel.Item]) -> some View {
        ForEach(Array(items.enumerated()), id: \.element) { _, item in
            HStack {
                Text(item.title)
                Spacer()
                Text("\(item.number)")
            }
        }
        .onDelete { indexSet in
            viewModel.items.remove(atOffsets: indexSet)
        }
        .onMove { indexSet, newOffset in
            viewModel.items.move(fromOffsets: indexSet, toOffset: newOffset)
        }
    }
}

@available(iOS 13.0, *)
private extension View {
    @ViewBuilder
    func withEditButton() -> some View {
        if #available(iOS 14.0, *) {
            self.toolbar { EditButton() }
        } else {
            self
        }
    }
}

@available(iOS 13.0, *)
struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTableView()
    }
}
