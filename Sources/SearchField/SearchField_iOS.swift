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

#if os(iOS)

import SwiftUI

public struct SearchField: View {
    @ObservedObject private var viewModel = SearchFieldViewModel()
    @Binding private var text: String
    @State private var isEditing = false
    private let background: Color
    private let foregroundColor: Color

    public init(text: Binding<String>) {
        _text = text
        self.background = Color.searchFieldBackground
        self.foregroundColor = Color.searchFieldForegroundColor
    }

    public init(text: Binding<String>, background: Color?, foreground: Color?) {
        _text = text
        self.background = background ?? Color.searchFieldBackground
        self.foregroundColor = foreground ?? Color.searchFieldForegroundColor
    }

    @ViewBuilder
    public var body: some View {
        HStack {
            TextField(viewModel.placeholder,
                      text: $text,
                      onEditingChanged: { (editingChanged) in
                if editingChanged {
                    isEditing = true
                } else {
                    isEditing = false
                    hideKeyboard()
                }
            })
            .font(.body.weight(.regular))
            .foregroundColor(foregroundColor)
            .accentColor(foregroundColor)
            .padding(7)
            .padding(.horizontal, 32)
            .background(background)
            .cornerRadius(8)
            .textFieldStyle(PlainTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24))
                        .foregroundColor(foregroundColor)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    if isEditing {
                        Button(action: {
                            isEditing = false
                            text = ""
                            hideKeyboard()
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(foregroundColor)
                                .padding(.trailing, 8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .transition(.opacity)
                        .animation(.default)
                    }
                }
            )
            .onTapGesture {
                isEditing = true
            }
        }
        .foregroundColor(foregroundColor)
        .padding(.vertical, 8)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        let searchBar = SearchField(text: .constant(""))
                .previewLayout(.sizeThatFits)

        return Group {
            searchBar
            searchBar
                .background(Color(UIColor.systemBackground))
               .colorScheme(.dark)
            searchBar
                .environment(\.locale, .init(identifier: "fr"))
            searchBar
                .environment(\.locale, .init(identifier: "de"))
        }
    }
}

public extension Color {
    static var searchFieldBackground: Color {
        if #available(iOS 13, *) {
            return Color(UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.163, green: 0.168, blue: 0.177, alpha: 1)
                } else {
                    return UIColor(red: 0.891, green: 0.891, blue: 0.915, alpha: 1)
                }
            })
        } else {
            return Color(UIColor(red: 0.891, green: 0.891, blue: 0.915, alpha: 1))
        }
    }
    
    static var searchFieldForegroundColor: Color {
        if #available(iOS 13, *) {
            return Color(UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.618, green: 0.618, blue: 0.647, alpha: 1)
                } else {
                    return UIColor(red: 0.383, green: 0.408, blue: 0.44, alpha: 1)
                }
            })
        } else {
            return Color(UIColor(red: 0.383, green: 0.408, blue: 0.44, alpha: 1))
        }
    }
}

#endif
