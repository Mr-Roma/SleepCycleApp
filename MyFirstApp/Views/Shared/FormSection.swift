import SwiftUI

struct FormSection<Content: View>: View {
    var title: String
    var isRequired: Bool = true
    let content: Content
    
    init(title: String, isRequired: Bool = true, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isRequired = isRequired
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section header with required indicator
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                if isRequired {
                    Text("*")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .offset(y: -2) // Better visual alignment
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            // Content with consistent padding
            content
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}
