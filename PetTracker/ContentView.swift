import SwiftUI

struct Pet: Identifiable, Codable {
    let id: UUID
    var name: String
    var birthDate: Date
    var lastVetVisit: Date
    var animalType: AnimalType
}

struct ContentView: View {
    @StateObject var petsData = PetsData()
    @State var newPetPopover: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("Pet Tracker")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                    Button("Add new pet") {
                        newPetPopover.toggle()
                    }
                    .padding(.horizontal)
                    .popover(isPresented: $newPetPopover) {
                        NewPet(petsData: petsData, popoverPresentation: $newPetPopover)
                    }
            }
            NavigationStack() {
                ScrollView {
                    ForEach(petsData.pets) { pet in
                        NavigationLink(destination: PetDetail(pet: $petsData.pets[petsData.pets.firstIndex(where: { $0.id == pet.id })!])) {
                            ZStack {
                                VStack {
                                    HStack {
                                        Text(pet.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        switch pet.animalType {
                                        case AnimalType.dog:
                                            Image(systemName: "dog")
                                                .foregroundColor(.primary)
                                                .font(.title)
                                        case AnimalType.cat:
                                            Image(systemName: "cat")
                                                .foregroundColor(.primary)
                                                .font(.title)
                                        case AnimalType.rabbit:
                                            Image(systemName: "hare")
                                                .foregroundColor(.primary)
                                                .font(.title)
                                        case AnimalType.rodent:
                                            Image("mouse")
                                                .resizable()
                                                .frame(width: 32.0, height: 32.0)
                                        case AnimalType.hedgehog:
                                            Image("hedgehog")
                                                .resizable()
                                                .frame(width: 32.0, height: 32.0)
                                        }
                                    }
                                    HStack {
                                        Text("Age: \(Calendar.current.dateComponents([.year], from: pet.birthDate, to: Date()).year ?? 0)")
                                            .font(.headline)
                                            .fontWeight(.light)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text(pet.animalType.rawValue)
                                            .font(.title3)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding()
                            }
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
