///
/// MIT License
///
/// Copyright (c) 2022 Sascha Müllner
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///
/// Created by Sascha Müllner on 07.01.22.

#if os(macOS)

import SwiftUI

public struct SearchField: View {

    @ObservedObject private var viewModel = SearchFieldViewModel()

    @Binding private var text: String
    @State private var isEditing = false

    public init(text: Binding<String>) {
        _text = text
    }

    @ViewBuilder
    public var body: some View {
        HStack {
            TextField(
                viewModel.placeholder,
                text: $text,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                onCommit: {
                    isEditing = text.count > 0
                })
                .padding(7)
                .padding(.horizontal, 25)
                .cornerRadius(8)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(foregroundColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                isEditing = false
                                text.removeAll()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(foregroundColor)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 8)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .transition(.opacity)
                            .animation(.default)
                        }
                    }
                )
        }
        .foregroundColor(foregroundColor)
    }

    var foregroundColor: Color { Color(NSColor.controlTextColor)
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        let searchField = SearchField(text: .constant(""))
                .previewLayout(.sizeThatFits)

        return Group {
            searchField
                .environment(\.locale, Locale(identifier: "de"))

            searchField
                .environment(\.locale, .init(identifier: "fr"))

            searchField
                .environment(\.locale, .init(identifier: "de"))
        }
    }
}

#endif
