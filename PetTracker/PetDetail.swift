import SwiftUI

struct Entry: Identifiable, Codable {
    let id: UUID
    var petId: UUID
    var date: Date
    var weight: Double
    var activity: Bool
    var Apperire: Bool
    var Hygiene: Bool
    var Poop: Bool
    var Teeth: Bool
    var temperature: Double
    var vetVisit: Bool
    var notes: String
}

struct PetDetail: View {
    @Binding var pet: Pet
    @State var newEntry: Bool = false
    @StateObject var entriesDet = EntriesDetails()
    @State var popup: Bool = false
    @State var alert: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text(pet.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
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
                Spacer()
                Button("New entry") {
                    newEntry.toggle()
                }
                .padding(.horizontal)
                .popover(isPresented: $newEntry) {
                    NewEntry(entryData: entriesDet, petId: pet.id, popover: $newEntry)
                        .onDisappear {
                            if let lastVisitIndex = entriesDet.entries.lastIndex(where: { $0.vetVisit && $0.petId == pet.id }) {
                                pet.lastVetVisit = entriesDet.entries[lastVisitIndex].date
                            }
                        }
                }
                Button(action: {
                    popup.toggle()
                }) {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.blue)
                        .confirmationDialog("Remove pet", isPresented: $popup) {
                            Button("Pet passed away", role: .destructive) {
                                PetsData().removePet(with: pet.id)
                                alert = true
                            }
                        } message: {
                            Text("Is it time to say goodbye?")
                        }
                        .alert("This pet is now in better place. App will close now", isPresented: $alert) {
                            Button("OK") {
                                exit(0)
                            }
                        }

                }
                .padding(.horizontal)
            }

            HStack {
                Text("Born:\n \(pet.birthDate, style: .date)")
                    .font(.headline)
                    .fontWeight(.light)
                Spacer()
                Text("Last vet visit:\n \(pet.lastVetVisit, style: .date)")
                    .font(.headline)
                    .fontWeight(.light)
            }
            .padding()

            NavigationStack {
                ScrollView {
                    ForEach(entriesDet.entries.sorted(by: { $0.date > $1.date })) { entry in
                        if(entry.petId == pet.id){
                            NavigationLink(destination: EntryDetail(entry: entry, petName: pet.name)) {
                                ZStack{
                                    VStack{
                                        HStack{
                                            Text("Date: \(entry.date.formatted(.dateTime.day().month().year()))")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.primary)
                                                .font(.title)
                                        }
                                        HStack{
                                            Text("Weight: \(String(format: "%.1f", entry.weight))g")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Text("Activity: \(entry.activity ? "OK" : "Not OK")")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Text("Appetite: \(entry.Apperire ? "OK" : "Not OK")")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                        }
                                        HStack{
                                            Text("Hygiene: \(entry.Hygiene ? "OK" : "Not OK")")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Text("Poop: \(entry.Poop ? "OK" : "Not OK")")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                        }
                                        HStack{
                                            Text("Teeth: \(entry.Teeth ? "OK" : "Not OK")")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Text("Temperature: \(String(format: "%.1f", entry.temperature))°C")
                                                .font(.headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.primary)
                                        }
                                        if entry.vetVisit{
                                            HStack{
                                                Text("Vet visit was today")
                                                Spacer()
                                            }
                                        }
                                    }.padding()
                                }
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var previewPet = Pet(
            id: UUID(),
            name: "Edzio",
            birthDate: Date(),
            lastVetVisit: Date(),
            animalType: .hedgehog
        )

    return PetDetail(pet: $previewPet)
}
