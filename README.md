# AutoCompleteTextField


View with `TextField` that shows a list of suggestions while typing.

- Plug and play replacement for `TextField`.

---

![AutocompleteField](/.github/example.gif?raw=true)

# Requirements

- iOS 17.0+
- Swift 5+

# Installation

## Swift Package Manager

- Select **File > Swift Packages > Add Package Dependency**.
- Enter `https://github.com/disepulv/AutoCompleteTextField.git` in the **Choose Package Repository** dialog.

See [Apple docs](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) for more information.

## Manually

- Copy `/Sources/AutoCompleteTextField/AutoCompleteTextField.swift` to your project. There are no other dependencies.

# Usage

You use this textfield in the same way as the regular `TextField`.

## Basic

```swift
import AutoCompleteTextField

...
struct ContentView: View {
    @State var inputString: String = ""
    
    let suggestions = ["Argentina", "Bahamas", "Barbados", "Belize", "Bolivia", "Brazil", "Canada", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", Guatemala", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "United States of America", "Uruguay", "Venezuela"]

    var body: some View {
        VStack {
            Text("What's your country")
            AutoCompleteTextField(placeholder: "Type your country",
                                  inputString: $inputString,
                                  suggestions: suggestions)
            .zIndex(1000000)
        }
    }
}


```

# API

| Property            | Type             | Description                                                                                                                                                                     |
| ------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `titleKey`   | `LocalizedStringKey`        | Default placeholder. |
| `text`        | `Binding<String>`         | Input text. |
| `suggeestions`   | `[String]`        | Array with suggestions. |                
| `textLimit`        | `Int`         | Max text size allowed. |
| `isDisabled`       | `Boolean`       | Array of suggestions. |
| `style.minCharTyped` | `Int`        | Minimun char typed to display suggestions. |
| `style.keyboardStyle`    | `UIKeyboardType` | Keyboard type. |
| `style.font`  | `Font`        | Font. |
| `style.foregroundColor`         | `Color`         | Foreground color. |
| `style.backgroundColor`         | `Color`         | Background color. |
| `style.backgroundDisabledColor`         | `Color`         | Background disabled color. |


# Demo

Check out the [example project](/Example).

# License

`AutoCompleteTextField` is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for details.
