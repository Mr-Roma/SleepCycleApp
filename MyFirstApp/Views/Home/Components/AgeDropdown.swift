import SwiftUI

struct AgeDropdown: View {
    @Binding var selectedOption: String
    @State private var isExpanded = false
    
    // Updated options to match CDC/NIH age categories
    let options = [
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
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedOption)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color("UnguMuda"))
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            withAnimation {
                                isExpanded = false
                            }
                        }) {
                            Text(option)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(
                                    selectedOption == option ?
                                        Color.blue.opacity(0.1) :
                                        Color(.systemBackground)
                                )
                        }
                        Divider()
                    }
                }
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        }
    }
}
