import SwiftUI

struct AgeDropdown: View {
    @Binding var selectedOption: String
    
    let ageCategories = [
        "Select Age Category",
        "Newborn (0-3 months)",
        "Infant (4-12 months)",
        "Toddler (1-2 years)",
        "Preschool (3-5 years)",
        "School Age (6-12 years)",
        "Teen (13-18 years)",
        "Adults (19-60 years)",
        "Older Adult (61-64 years)",
        "Senior (65+ years)"
    ]
    
    var body: some View {
        Menu {
            Picker("Age Category", selection: $selectedOption) {
                ForEach(ageCategories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
        } label: {
            HStack {
                Text(selectedOption)
                    .foregroundColor(selectedOption == "Select Age Category" ? .gray : .primary)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.secondary)
            }
            .modifier(ConsistentTextFieldStyle())
        }
    }
}
