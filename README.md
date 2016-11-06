# CoordinatorKit

[![CI Status](http://img.shields.io/travis/Nathan Lanza/CoordinatorKit.svg?style=flat)](https://travis-ci.org/Nathan Lanza/CoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/CoordinatorKit.svg?style=flat)](http://cocoapods.org/pods/CoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/CoordinatorKit.svg?style=flat)](http://cocoapods.org/pods/CoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/CoordinatorKit.svg?style=flat)](http://cocoapods.org/pods/CoordinatorKit)

## About

CoordinatorKit is a simple framework that provides base classes for the coordinator pattern. The design of this framework was chosen to mirror the implementation of `UIKIt`'s `UIViewController`. There is a base `Coordinator` analagous to a `UIViewController` and, similarly, `TabBarCoordinator` and `NavigationCoordinator`.

You use these classes by overriding `loadViewController` and initializing the property `viewController.` You can also create a custom property such as

var myViewController: MyViewController { return viewController as! MyViewController }.

The API is designed to feel very similar to `UIViewControllers`. You call `show`, `present`, `dismiss`, and various other methods on the coordinators in order to provide navigation. If I develop this far enough, I'll create documentation, but for now just see the base classes.

## TODO: 

* Figure out how to implement `didNavigate{to,awayFrom}ViewController` for `TabBarCoordinator`.
* Implement `SplitViewCoordinator`.
* Figure out other things to implement.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CoordinatorKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CoordinatorKit"
```

## Author

Nathan Lanza, nathan@lanza.io

## License

CoordinatorKit is available under the MIT license. See the LICENSE file for more info.
