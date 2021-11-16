![](validator.png)

<H1 align="center">Validator</H1>

<p align="center">
<a href="https://cocoapods.org/pods/incetro-validator"><img alt="Version" src="https://img.shields.io/cocoapods/v/incetro-validator.svg?style=flat"></a> 
<a href="https://github.com/Incetro/incetro-validator/blob/master/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/incetro-validator.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a> 
<a href="https://developer.apple.com/swift"><img alt="Swift4.2" src="https://img.shields.io/badge/language-Swift5.0-orange.svg"/></a>
</p>

## Description

This library validate the string value in three rules: **Regex**, **Length** and **Equality**.

- [Example](https://github.com/Incetro/validator/tree/master/Sources/Example) 
- [Usage](#Usage)
	1. [Regex](#Regex)
	2. [Length](#Length)
	3. [Equality](#Equality)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Authors](#license)

## Example project <a name="Example project"></a>

To run the example project, clone the repo, and run `pod_reinstall.command` from the Example directory first.

## Usage <a name="Usage"></a>

To use a *Validator*, all you will need to import 'Validator' module into your swift file:

```swift
import Validator
```
After that, you must select the required validation rule. To do this, the appropriate structures are used, all of them are inherited from the `ValidationRule` protocol.

### 1. Regex <a name="Regex"></a>
For Regex rule you need to have regular expression string values and use `RegexValidationRule` struct.

```swift
// MARK: - Regex

enum Regex {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let username = "^[a-zA-Z_]{1}[a-zA-Z0-9_]{2,18}$"
    static let password = "^[0-9a-zA-Z!@#$%^&*]{8,32}$"
}
```

```swift
/// Password text field
let passwordTextField: UITextField = {
    let passwordTextField = UITextField()
    passwordTextField.validateOnInputChange(enabled: true)
    return passwordTextField
}()

passwordTextField.add(rule: RegexValidationRule(pattern: Regex.password))
```

### 2. Length <a name="Length"></a>
For Length rule you need to use `LengthValidationRule` struct. You might use min, max or range length validation of strings.

```swift
/// Username text field
let usernameTextField: UITextField = {
    let usernameTextField = UITextField()
    usernameTextField.validateOnInputChange(enabled: true)
    return usernameTextField
}()

usernameTextField.add(rule: LengthValidationRule(min: 5))
usernameTextField.add(rule: LengthValidationRule(max: 20))
usernameTextField.add(rule: LengthValidationRule(min: 5, max: 20))
```

### 3. Equality <a name="Equality"></a>
For Equality rule you need to use `ConditionValidationRule` or `EqualityValidationRule` structs.

##### Condition:
```swift
/// Condition text field
let conditionTextField: UITextField = {
    let conditionTextField = UITextField()
    conditionTextField.validateOnInputChange(enabled: true)
    return conditionTextField
}()

conditionTextField.add(rule: ConditionValidationRule { $0 == "target string" } )
```
##### Equality:

```swift
/// Equality text field
let equalityTextField: UITextField = {
    let equalityTextField = UITextField()
    equalityTextField.validateOnInputChange(enabled: true)
    return equalityTextField
}()

equalityTextField.add(rule: EqualityValidationRule { "target string" } )
```
## Requirements
- iOS 12.0+
- Xcode 9.0
- Swift 5.0

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Installation <a name="installation"></a>

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To install it using [CocoaPods](https://cocoapods.org), simply add the following line to your Podfile:

```ruby
use_frameworks!

target "<Your Target Name>" do
pod "incetro-validator", :git => "https://github.com/Incetro/incetro-validator", :tag => "[0.0.3]"
end
```
Then, run the following command:

```bash
$ pod install
```
### Manually

If you prefer not to use any dependency managers, you can integrate *Validator* into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add *Validator* as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/incetro/incetro-validator.git
  ```

- Open the new `Validator` folder, and drag the `Validator.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Validator.xcodeproj ` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Validator.xcodeproj ` folders each with two different versions of the `Validator.framework` nested inside a `Products` folder.

- Select the `Validator.framework`.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Nio` will be listed as either `Validator iOS`.

- And that's it!

  > The `Validator.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  


## Authors <a name="authors"></a>

Gasol: 1ezya007@gmail.com, incetro: incetro@ya.ru


## License <a name="license"></a>

*Validator* is available under the MIT license. See the LICENSE file for more info.