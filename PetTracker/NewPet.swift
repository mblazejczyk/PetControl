import SwiftUI

enum AnimalType: String, CaseIterable, Identifiable, Codable {
    case dog = "Dog"
    case cat = "Cat"
    case rabbit = "Rabbit"
    case rodent = "Rodent"
    case hedgehog = "Hedgehog"
    
    var id: String { self.rawValue }
}


struct NewPet: View {
    @ObservedObject var petsData: PetsData
    @State var name: String = ""
    @State var birthDate: Date = Date()
    @State var lastVetVisit: Date = Date()
    @State var animalTypePick: AnimalType = .dog

    @Binding var popoverPresentation: Bool
    
    var body: some View {
        HStack {
            Text("Add new pet")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button("Save") {
                let newPet = Pet(
                    id: UUID(),
                    name: name,
                    birthDate: birthDate,
                    lastVetVisit: lastVetVisit,
                    animalType: animalTypePick
                )
                petsData.addPet(newPet)
                popoverPresentation.toggle()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Pet Name:")
                    Spacer()
                    TextField("Enter name", text: $name)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Text("Birth Date:")
                    Spacer()
                    DatePicker("", selection: $birthDate, displayedComponents: .date)
                        .labelsHidden()
                }
                HStack {
                    Text("Last Vet Visit:")
                    Spacer()
                    DatePicker("", selection: $lastVetVisit, displayedComponents: .date)
                        .labelsHidden()
                }
                HStack {
                    Text("Animal Type:")
                    Spacer()
                    Picker("Select type", selection: $animalTypePick) {
                        ForEach(AnimalType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NewPet(petsData: PetsData(), popoverPresentation: .constant(true))
}
