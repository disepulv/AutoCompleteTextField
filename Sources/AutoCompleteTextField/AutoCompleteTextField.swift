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
    private let textLimit:Int
    private var customValidation: (Bool) -> Void
    private var isDisabled: Bool? = false
    private var keyboardStyle: UIKeyboardType = UIKeyboardType.default
    private var font: Font = .system(size: 16, weight: .bold)
    private var minCharTyped = 2
    private var foregroundColor: Color = .gray
    private var backgroundColor: Color = .white
    private var backgroundDisabledColor: Color = .yellow

    @State private var height: CGFloat = 0
    @State private var isEditing = false
    @State var verticalOffset: CGFloat = 50
    @State var horizontalOffset: CGFloat = 0
    
    private var suggestions: [String]
    @State private var suggestionsFiltered: [String]
    
    public var body: some View {
        ZStack(alignment: .leading) {
            TextField(self.placeholder, text: $inputString, onEditingChanged: { _ in
                self.isEditing.toggle()}
            )
            .padding(14)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(backgroundColor, lineWidth: 1)
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
            .keyboardType(keyboardStyle)
            .limitText($inputString, to: textLimit)
            .font(font.bold())
            .disabled(isDisabled!)
            .background(isDisabled! ? backgroundDisabledColor : backgroundColor )
            /*.overlay(alignment: .topLeading, content: {
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
                                .font(font)
                                .foregroundColor(Color.gray)
                                .onTapGesture(perform: {
                                    inputString = result
                                    isEditing = false
                                    suggestionsFiltered = []
                                })
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }
                }.id("endList")
                    .frame(height: CGFloat(50 * min(5, suggestionsFiltered.count)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .background(backgroundColor)
                    .cornerRadius(5)
                    .ignoresSafeArea()
                    .offset(y: 50)
            })*/
        }
    }
    
    public init(placeholder: String,
                inputString: Binding<String>,
                textLimit: Int,
                validation:  @escaping (Bool) -> Void = {_ in},
                isDisabled: Bool = false,
                keyboardStyle : UIKeyboardType = UIKeyboardType.default,
                suggestions: [String] = []) {
        self.placeholder = placeholder
        self._inputString = inputString
        self.textLimit = textLimit
        self.customValidation = validation
        self.isDisabled = isDisabled
        self.keyboardStyle = keyboardStyle
        self.suggestions = suggestions
        self.suggestionsFiltered = []
    }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self.onChange(of: text.wrappedValue) {
            text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
        }
    }
}
