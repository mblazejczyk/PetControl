import SwiftUI

struct NewEntry: View {
    @ObservedObject var entryData: EntriesDetails
    let petId: UUID
    @Binding var popover: Bool
    
    @State var weight: Double = 0
    @State var Activity: Bool = true
    @State var Appetite: Bool = true
    @State var Hygiene: Bool = true
    @State var Poop: Bool = true
    @State var Teeth: Bool = true
    @State var Vet: Bool = false
    @State var Temperature: Double = 0
    @State var Notes: String = ""

    var body: some View {
        HStack{
            Text("Add new entry")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Spacer()
            Button("Save") {
                let newEntry = Entry(
                    id: UUID(),
                    petId: petId,
                    date: Date.now,
                    weight: weight,
                    activity: Activity,
                    Apperire: Appetite,
                    Hygiene: Hygiene,
                    Poop: Poop,
                    Teeth: Teeth,
                    temperature: Temperature,
                    vetVisit: Vet,
                    notes: Notes
                )
                entryData.addEntry(newEntry)
                
                if Vet {
                    PetsData().updateLastVetVisit(for: petId)
                }
                popover.toggle()
            }.padding()
        }.background(Color.gray.opacity(0.2))
        VStack {
            
            Text("Toggle if it's in norm, otherwise describe problem")
                .font(.subheadline)
                .fontWeight(.light)
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Weight (g):")
                    Spacer()
                    TextField("Enter weight", value: $weight, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .frame(maxWidth: 100)
                }
                
                Toggle("Activity", isOn: $Activity)
                Toggle("Appetite", isOn: $Appetite)
                Toggle("Hygiene", isOn: $Hygiene)
                Toggle("Poop", isOn: $Poop)
                Toggle("Teeth", isOn: $Teeth)
                Toggle("Vet visit today", isOn: $Vet)
                
                HStack {
                    Text("Temperature (°C):")
                    Spacer()
                    TextField("Enter temperature", value: $Temperature, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .frame(maxWidth: 100)
                }
                Text("Notes:")
                    .font(.subheadline)
                    .fontWeight(.light)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.5))
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2) 

                    TextEditor(text: $Notes)
                        .foregroundColor(.primary)
                        .padding(8)
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                .frame(height: 150)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }

}

#Preview {
    NewEntry(entryData: EntriesDetails(), petId: UUID(), popover: .constant(true))
}
