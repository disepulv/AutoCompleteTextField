//
//  AutoCompleteTextField.swift
//  AutoCompleteTextField
//
//  Created by Diego Sepulveda on 13-03-24.
//

import SwiftUI

public struct AutoCompleteTextField: View {

    @Binding private var inputString: String

    private let placeholder: String
    private var textLimit: Int
    private var isDisabled: Bool = false
    private var minCharTyped = 2

    private var suggestions: [String]

    private var style: AutoCompleteTextFieldStyle

    @State private var suggestionsFiltered: [String]
    @State private var width: CGFloat = 0
    @State private var isEditing = false
    @State var verticalOffset: CGFloat = 50
    @State var horizontalOffset: CGFloat = 0

    public var body: some View {
        ZStack(alignment: .leading) {
            TextField(self.placeholder, text: $inputString, onEditingChanged: { _ in
                self.isEditing.toggle()}
            )
            .padding(14)
            .foregroundColor(style.foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(style.backgroundColor, lineWidth: 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isEditing ? Color.gray : Color.green, lineWidth: 1)
            )
            .onChange(of: inputString, {
                if !isEditing {
                    isEditing.toggle()
                    return
                }
                if inputString.count > 2 {
                    suggestionsFiltered = suggestions.filter({
                        $0.localizedCaseInsensitiveContains(inputString)})
                } else {
                    suggestionsFiltered = []
                }
            })
            .autocorrectionDisabled(true)
            .keyboardType(style.keyboardStyle)
            .limitText($inputString, to: textLimit)
            .font(style.font)
            .disabled(isDisabled)
            .background(isDisabled ? style.backgroundDisabledColor : style.backgroundColor)
            .overlay(alignment: .topLeading, content: {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(suggestionsFiltered, id: \.self) { result in
                            Text(result)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 25)
                                .frame(minWidth: 0,
                                       maxWidth: .infinity,
                                       minHeight: 50,
                                       maxHeight: 50,
                                       alignment: .leading)
                                .contentShape(Rectangle())
                                .font(style.font)
                                .foregroundColor(style.foregroundColor)
                                .onTapGesture(perform: {
                                    inputString = result
                                    isEditing = false
                                    suggestionsFiltered = []
                                })
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .zIndex(10000)
                .id("endList")
                    .frame(height: CGFloat(50 * min(5, suggestionsFiltered.count)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .background(style.backgroundColor)
                    .cornerRadius(5)
                    .ignoresSafeArea()
                    .offset(y: 50)
            })
        }
    }

    public init(placeholder: String,
                inputString: Binding<String>,
                suggestions: [String],
                textLimit: Int = 50,
                isDisabled: Bool = false,
                style: AutoCompleteTextFieldStyle = AutoCompleteTextFieldStyle()
    ) {
        self.placeholder = placeholder
        self._inputString = inputString
        self.textLimit = textLimit
        self.isDisabled = isDisabled
        self.suggestions = suggestions
        self.suggestionsFiltered = []
        self.style = style
    }
}

public struct AutoCompleteTextFieldStyle {
    var keyboardStyle: UIKeyboardType
    var font: Font
    var foregroundColor: Color
    var backgroundColor: Color
    var backgroundDisabledColor: Color
    
    public init(
        keyboardStyle: UIKeyboardType = .default,
        font: Font = .system(size: 16, weight: .bold),
        foregroundColor: Color = .gray,
        backgroundColor: Color = .white,
        backgroundDisabledColor: Color = .yellow) {
        self.keyboardStyle = keyboardStyle
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.backgroundDisabledColor = backgroundDisabledColor
    }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self.onChange(of: text.wrappedValue) {
            text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
        }
    }
}
