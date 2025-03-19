import SwiftUI

struct SummaryCard: View {
    @ObservedObject var viewModel: SleepViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weekly Average")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Sleep Cycle Score")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("40)")
                        .font(.title)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Sleep Cycles")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("70)")
                        .font(.title)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}
