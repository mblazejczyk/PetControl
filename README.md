# Pet Tracker 🐾

**Pet Tracker** is a SwiftUI-based application designed to help pet owners monitor and manage their pets' vital data, activities, and overall well-being. Keep track of your pets' key details like weight, health habits, and vet visits, all in one organized place.

---

## Features 🌟

- **Add Pets**: Easily add new pets with details like name, birth date, last vet visit, and type (dog, cat, hedgehog, etc.).
- **Track Entries**: Record daily details such as weight, activity, hygiene, appetite, temperature, and more.
- **View Pet Details**: Access individual pet profiles to see all their records and a summary of their details.
- **Health Indicators**: Monitor your pet's health habits with detailed entries and toggle indicators for key metrics.
- **Manage Vet Visits**: Automatically update vet visit dates based on health records.
- **Persistent Storage**: Save pets and entries locally using `UserDefaults` for continuity across sessions.
- **Pet Removal Option**: Handle the sensitive process of marking a pet as passed away.

---

## File Overview 📂

| File Name         | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| `ContentView.swift` | Main entry point of the app, displaying the list of pets and navigation to details. |
| `PetDetail.swift`  | Shows detailed information about a specific pet, including health records and entries. |
| `EntryDetail.swift`| Displays details of a single health entry for a pet.                       |
| `NewPet.swift`     | Interface for adding new pets to the tracker.                              |
| `NewEntry.swift`   | Interface for recording a new health entry for a pet.                     |
| `PetsData.swift`   | Handles the management and persistent storage of pets and their health entries. |

---

## License Information 📜

All graphics used in the application are licensed under Creative Commons. If you plan to use or modify these assets, please ensure compliance with the associated licensing terms.

---

## How to Use 🛠️

1. **Clone the Repository**: Download or clone the repository to your local environment.
2. **Run the Application**: Open the project in Xcode and run it on an iOS device or simulator.
3. **Add Your Pets**: Start adding your pets and logging their details.

---

## Requirements 📋

- **Platform**: iOS 14.0+
- **Language**: Swift
- **Framework**: SwiftUI

---

## License info ℹ️

This code it under `no-license`.
