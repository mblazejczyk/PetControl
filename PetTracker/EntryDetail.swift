import SwiftUI

struct EntryDetail: View {
    let entry: Entry
    let petName: String
    
    var body: some View {
        HStack{
            Text("\(petName) - \(entry.date.formatted(.dateTime.day().month().year()))")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
        HStack{
            VStack(alignment: .leading){
                Text("Weight: \(String(format: "%.1f", entry.weight))g")
                Text("Activity: \(entry.activity ? "OK" : "Not OK")")
                Text("Appetite: \(entry.Apperire ? "OK" : "Not OK")")
                Text("Hygiene: \(entry.Hygiene ? "OK" : "Not OK")")
                Text("Poop: \(entry.Poop ? "OK" : "Not OK")")
                Text("Teeth: \(entry.Teeth ? "OK" : "Not OK")")
                if entry.vetVisit{
                    Text("Vet visit was today")
                }
                Text("Temperature (around): \(String(format: "%.1f", entry.temperature))°C")
                
                if(entry.notes.isEmpty){
                    Text("\n[No notes]")
                }
                Text("\n\(entry.notes)")
            }.padding()
            Spacer()
        }
        
        Spacer()
    }
}

#Preview {
    EntryDetail(entry: Entry(
        id: UUID(),
        petId: UUID(),
        date: Date.now,
        weight: 1.0,
        activity: true ,
        Apperire: true,
        Hygiene: true,
        Poop: true,
        Teeth: true,
        temperature: 1.0,
        vetVisit: true,
        notes: "")
        , petName: "Edzio"
    )
}
