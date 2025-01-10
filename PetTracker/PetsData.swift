import Foundation


class PetsData: ObservableObject {
    @Published var pets: [Pet] = [] {
        didSet {
            saveToStorage()
        }
    }

    init() {
        loadFromStorage()
    }

    func addPet(_ pet: Pet) {
        pets.append(pet)
    }

    private func saveToStorage() {
        if let data = try? JSONEncoder().encode(pets) {
            UserDefaults.standard.set(data, forKey: "pets")
        }
    }

    private func loadFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "pets"),
           let savedPets = try? JSONDecoder().decode([Pet].self, from: data) {
            pets = savedPets
        }
    }
    
    func updateLastVetVisit(for petId: UUID) {
        if let index = pets.firstIndex(where: { $0.id == petId }) {
            pets[index].lastVetVisit = Date.now
        }
    }
    
    func removePet(with id: UUID) {
        if let index = pets.firstIndex(where: { $0.id == id }) {
            pets.remove(at: index)
        }
    }
}

class EntriesDetails: ObservableObject {
    @Published var entries: [Entry] = [] {
        didSet {
            saveToStorage()
        }
    }

    init() {
        loadFromStorage()
    }
  
    func addEntry(_ entry: Entry) {
        entries.append(entry)
    }

    private func saveToStorage() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: "entries")
        }
    }

    private func loadFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "entries"),
           let savedEntries = try? JSONDecoder().decode([Entry].self, from: data) {
            entries = savedEntries
        }
    }
}
