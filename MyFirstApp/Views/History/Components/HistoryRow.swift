import SwiftUI

struct HistoryRow: View {
    var date: Date
    var result: SleepResult
    @State private var isExpanded = false // Track state of detail view
    
    var body: some View {
        VStack(spacing: 0) { // Menghindari jarak antara card utama dan expandable view
            Button(action: {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                 isExpanded.toggle()
                             }
            }) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(date, style: .date)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                        }
                        HStack  {
                            Text("\(result.totalCycles) Cycles")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(date, style: .time)
                                .font(.headline)
                                .foregroundColor(Color("Kuning"))
                        }
                    }
                    
                    Spacer()
                    
//                    Text("\(result.sleepDuration)")
//                        .font(.subheadline)
//                        .foregroundColor(.green)
                    
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .foregroundColor(Color("UnguMuda"))
                        .padding(.leading)
                }
                .padding()
                .frame(maxWidth: .infinity) // Membuat card penuh
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 1)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
            // Detail view
            if isExpanded {
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Best Sleep Time: \(result.deepSleepPercentage)")
                            .font(.subheadline)
                            .foregroundColor(Color("UnguMuda"))
                        Text("Best Wake-up Time: \(result.remSleepPercentage) ")
                            .font(.subheadline)
                            .foregroundColor(Color("UnguMuda"))
                        Text("Total Sleep Duration: \(result.sleepDuration) ")
                            .font(.subheadline)
                            .foregroundColor(Color("UnguMuda"))
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity) 
                .background(Color(.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.3))
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 1)
                .transition(.move(edge: .top).combined(with: .opacity)) // Animasi muncul dari atas
                .padding(.horizontal)
            }
        }
    }
}
