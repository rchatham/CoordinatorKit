# CoordinatorKit

[![CI Status](http://img.shields.io/travis/nathanlanza/CoordinatorKit.svg?style=flat)](https://travis-ci.org/nathanlanza/CoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/CoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/CoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/CoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/CoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/CoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/CoordinatorKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

<a href="https://placehold.it/400?text=Screen+shot"><img width=200 height=200 src="https://placehold.it/400?text=Screen+shot" alt="Screenshot" /></a>

## About

CoordinatorKit is a simple framework that provides base classes for the coordinator pattern. The design of this framework was chosen to mirror the implementation of `UIKIt`'s `UIViewController`. There is a base `Coordinator` analagous to a `UIViewController` and, similarly, `TabBarCoordinator` and `NavigationCoordinator`.

You use these classes by overriding `loadViewController` and initializing the property `viewController.` You can also create a custom property such as

var myViewController: MyViewController { return viewController as! MyViewController }.

The API is designed to feel very similar to `UIViewControllers`. You call `show`, `present`, `dismiss`, and various other methods on the coordinators in order to provide navigation. If I develop this far enough, I'll create documentation, but for now just see the base classes.

## TODO: 

* Implement `SplitViewCoordinator`.
* HamburgerController/Coordinator might not stay around.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate CoordinatorKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'CoordinatorKit'
```

Then, run the following command:

```bash
$ pod install
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate CoordinatorKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "nathanlanza/CoordinatorKit" ~> 0.1
```

Run `carthage update` to build the framework and drag the built `CoordinatorKit`.framework into your Xcode project.


## Author

Nathan Lanza -> nathan@lanza.io


## License

CoordinatorKit is available under the MIT license. See the LICENSE file for more info.
