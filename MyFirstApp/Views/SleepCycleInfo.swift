import SwiftUI

struct SleepCycleInfo: View {
    // For age category selection
    @State private var selectedAgeCategory: String = "Adult"
    
    // Sleep recommendation data
    let sleepRecommendations: [(category: String, age: String, hours: String)] = [
        ("Newborn", "0–3 months", "14–17 hours"),
        ("Infant", "4–12 months", "12–16 hours per 24 hours, including naps"),
        ("Toddler", "1–2 years", "11–14 hours per 24 hours, including naps"),
        ("Preschool", "3–5 years", "10–13 hours per 24 hours, including naps"),
        ("School Age", "6–12 years", "9–12 hours per 24 hours"),
        ("Teen", "13–18 years", "8–10 hours per 24 hours"),
        ("Adult", "18–60 years", "7 or more hours per night"),
        ("Older Adult", "61–64 years", "7–9 hours"),
        ("Senior", "65 years and older", "7–8 hours")
    ]
    
    // Sleep cycle stages info
    let sleepStages: [(name: String, description: String, icon: String, color: Color)] = [
        ("N1 Stage", "The 'dozing off' phase (1-7 minutes). Light sleep with slow brain waves. You may experience hypnic jerks.", "moon", .blue),
        ("N2 Stage", "Light sleep (50% of total sleep). Heart rate decreases and body temperature drops. Essential for memory consolidation.", "moon.fill", .indigo),
        ("N3 Stage", "Deep, restorative sleep. Critical for hormone regulation, memory consolidation, tissue repair, and immune function.", "moon.stars", .purple),
        ("REM Stage", "Dream state with high brain activity. Crucial for memory and mood regulation. Occurs at the end of each cycle.", "moon.stars.fill", .pink)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Title and moon image
                VStack {
                    
                    Image(systemName: "moon.stars.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                        .foregroundColor(.blue)
                        .padding(.vertical)
                }
                
                // Intro card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Sleep Cycle Basics")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                    
                    VStack {
                        Text("A typical sleep cycle lasts about 90-110 minutes. Most people need 4-6 complete cycles per night for optimal rest. In one cycle are filled of several stages: N1, N2, N3, and REM.")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal)
              
                }
               
                
                // Sleep stages
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sleep Cycle Stages")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ForEach(sleepStages, id: \.name) { stage in
                        HStack(alignment: .top, spacing: 15) {
                            Image(systemName: stage.icon)
                                .font(.system(size: 24))
                                .foregroundColor(stage.color)
                                .frame(width: 40)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(stage.name)
                                    .font(.headline)
                                    .foregroundColor(stage.color)
                                
                                Text(stage.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                    }
                }
                
                // Recommended sleep by age
                VStack(alignment: .leading, spacing: 15) {
                    Text("How Much Sleep Do You Need?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Age category picker
                    Picker("Age Category", selection: $selectedAgeCategory) {
                        ForEach(sleepRecommendations, id: \.category) { recommendation in
                            Text(recommendation.category).tag(recommendation.category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // Display selected age category details
                    if let selected = sleepRecommendations.first(where: { $0.category == selectedAgeCategory }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(selected.category)
                                    .font(.headline)
                                
                                Text("Age: \(selected.age)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("Recommended: \(selected.hours)")
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                            // Icon based on age category
                            Image(systemName: ageIcon(for: selected.category))
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .padding(.horizontal)
                        .cornerRadius(20)
                    }
                }
                
                // Tips for better sleep
                VStack(alignment: .leading, spacing: 15) {
                    Text("Tips for Better Sleep")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        tipView(icon: "moon.zzz.fill", title: "Consistent Schedule", description: "Go to bed and wake up at the same time every day, even on weekends.")
                        
                        tipView(icon: "lightbulb.slash.fill", title: "Limit Blue Light", description: "Avoid screens 1-2 hours before bedtime to help your body produce melatonin.")
                        
                        tipView(icon: "bed.double.fill", title: "Comfortable Environment", description: "Keep your bedroom cool, quiet, and dark for optimal sleep conditions.")
                        
                        tipView(icon: "sparkles", title: "Relaxation Techniques", description: "Try deep breathing, meditation, or gentle stretching before bed.")
                    }
                    .padding(.horizontal)
                }
                
                // Call to action
                VStack {
                    Text("Ready to optimize your sleep?")
                        .font(.headline)
                    
                    Text("Use the calculator to find your ideal bedtime based on your wake-up time and target 4-6 complete sleep cycles.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.vertical)
        }
      
    }
    
    // Helper function for tip view
    private func tipView(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
        )
    }
    
    // Helper function to get appropriate icon for age category
    private func ageIcon(for category: String) -> String {
        switch category {
        case "Newborn", "Infant":
            return "figure.baby"
        case "Toddler", "Preschool":
            return "figure.child"
        case "School Age":
            return "figure.child.and.lock"
        case "Teen":
            return "figure.wave"
        case "Adult":
            return "figure.stand"
        case "Older Adult", "Senior":
            return "figure.roll"
        default:
            return "person"
        }
    }
}

struct SleepCycleInfo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SleepCycleInfo()
        }
    }
}
