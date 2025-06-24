# Digimon

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

A simple iOS application written in Swift, built for practical refresh control and search controller.


| Demo | Details | Favorites |
| --- | --- | --- |
| ![Demo](https://github.com/user-attachments/assets/4c344a17-0752-464c-a1bd-0b98b462bbef) | ![Details](https://github.com/user-attachments/assets/7776f7df-cdd9-420f-9ad6-2807fb41145f) | ![Favorites](https://github.com/user-attachments/assets/8c41bbd4-1b0c-4e98-adf2-7ba9fcf3a792) |


## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Setup](#setup)

## Features

- View Code (UIKit)
- Refresh Control
- Search Controller
- Modern CollectionView Diffable
- Modern TableView Diffable
- MVVM with Combine
- Await/Async Request
- UserDefaults
- Custom elements
- Dark Mode
- Unit Tests

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities

- [x] **Digimon List**: Displays a list of available Digimons for viewing.
- [x] **Digimon Details**: Tapping on a digimon takes the user to a detailed screen with information about it.
- [x] **Favorite Digimon**: Allows the user to favorite a Digimon. This is done using `UserDefaults` to store the favorite digimons.
- [x] **Favorites Page**: Displays all Digimons that the user has favorited. From this page, users can access image and name of each digimon.
- [x] **Remove from Favorites**: From the favorites page, users can remove digimons from their favorites list.
- [x] **Dark Mode Support**: Full support for Dark Mode, offering a more pleasant user experience in different lighting conditions.
- [x] **UIKit Interface**: Utilizes UIKit components for building the user interface.
- [x] **Modern Collections**: Implements `UICollectionViewDiffableDataSource` to optimize data management and UI updates.
- [x] **Modern Tables**: Implements `UITableViewDiffableDataSource` to optimize data management and UI updates.


## Setup

First of all download and install Xcode, Swift Package Manager and then clone the repository:

```sh
$ git@github.com:diggosilva/Digimon.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/Digimon/
$ open Digimon.xcodeproj/
```
