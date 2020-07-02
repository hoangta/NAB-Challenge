# NABChallenge-iOS
## Requirements
* iOS 13.0+ 
* Xcode 11.5+
* Swift 5

## Architecture
* Every screen is modularized in to 1 subfolder from **Scenes** folder
* Every module contains 1 **storyboard**, 1 **view model**, 1 **view controller**
* May contain **subviews/models** folder if any, prefer **folder-by-feature** to **folder-by-type**, i.e *reusable* < *readability*
```
Scenes
 ├──Home
 │    ├── Views
 │    │     └── ForecastViewCell.swift
 │    ├── Models
 │    │     └── SomeModelThatIsForThisModuleOnly.swift
 │    ├── Home.storyboard
 │    ├── HomeViewController.swift
 │    └── HomeViewModel.swift
 └─-Settings
        └─ ...
```
* Storyboard contains 1 **view controller** which may be embedded into a **navigation controller**
* MVVM, for convenience, use template from the **MVVM Template**
```bash
$ cd ~\NAB-Challenge\MVVM Template
$ make install_templates
```
* When create a new scene, please use the template:

![template](MVVM%20Template/mvvm-template.png)

## Dependencies
* ### [RxSwift](https://github.com/ReactiveX/RxSwift) 
    > Reactive Programming for Swift
    >> Other RxSwift components:
    >> * [RxCocoa](https://github.com/ReactiveX/RxSwift) 
    
* ### [Moya](https://github.com/Moya/Moya)
    > Network abstraction layer
    
## Convention
* Name modules after main fuction:
    * **Home** should include *HomeViewController.swift*, *HomeViewModel.swift*, *Home.storyboard*..
    * **Settings** should include *SettingsViewController.swift*, *SettingsViewModel.swift*, *Settings.storyboard*..
* Name subviews in module after main action:
* Name managers (singletons) as pluralized, i.e *Analytics*, *Users* if necessary, instead of UserManager
* Name extensions with format **Class+Ex.swift**, ex: *Date+Ex.swift*
* ### [SwiftLint](https://github.com/realm/SwiftLint) 
    > Enforce Swift style and conventions

## Commit Messages

* **[add]** : new things, logic, placeholder, UIs
* **[mod]** : update things, logic, UIs
* **[fix]** : fix bugs
* **[ref]** : refactor
* **Format:** [action] [flow] / [scene if any] / [detail if any].
    * [add] onboarding / login screen.
    * [fix] scan receipt / crash when capturing photo.
    * [ref] shopping / cart / payment method.
    * [add] date extensions.

## Installation

Download the repo as zip / Clone the repo

Then run `pod install`.

## Features

- [x]  Swift language
- [x]  MVVM  
- [x]  UI as in attachment 
- [x]  Unit tests
- [x]  Acceptance tests
- [x]  Exception handling
- [x]  Caching handling
- [x]  Voiceover
- [x]  Dynamic font size
- [x]  Readme
