import SwiftUI

// Define a model for sleep recommendations
struct SleepRecommendation {
    let category: String
    let age: String
    let hours: String
    let description: String
}


struct ResultsView: View {
    @ObservedObject var viewModel: SleepViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    // Sleep recommendations array (same as in HomeView)
    let sleepRecommendations: [SleepRecommendation] = [
        SleepRecommendation(category: "Newborn (0-3 months)", age: "0-3 months", hours: "14-17 hours", description: "Newborns need the most sleep as their brains and bodies develop rapidly."),
        SleepRecommendation(category: "Infant (4-12 months)", age: "4-12 months", hours: "12-16 hours", description: "Infants need plenty of sleep for healthy growth and development."),
        SleepRecommendation(category: "Toddler (1-2 years)", age: "1-2 years", hours: "11-14 hours", description: "Toddlers need consistent sleep to support their increasingly active lifestyle."),
        SleepRecommendation(category: "Preschool (3-5 years)", age: "3-5 years", hours: "10-13 hours", description: "Preschoolers need adequate sleep to support learning and development."),
        SleepRecommendation(category: "School Age (6-12 years)", age: "6-12 years", hours: "9-12 hours", description: "School-age children need sufficient sleep to focus and perform well in school."),
        SleepRecommendation(category: "Teen (13-18 years)", age: "13-18 years", hours: "8-10 hours", description: "Teens undergo significant changes and need quality sleep despite changing sleep patterns."),
        SleepRecommendation(category: "Adults (19-60 years)", age: "19-60 years", hours: "7-9 hours", description: "Adults need consistent sleep to maintain cognitive function and overall health."),
        SleepRecommendation(category: "Older Adult (61-64 years)", age: "61-64 years", hours: "7-8 hours", description: "Older adults may experience changes in sleep patterns but still need quality rest."),
        SleepRecommendation(category: "Senior (65+ years)", age: "65+ years", hours: "7-8 hours", description: "Seniors benefit from regular sleep schedules to maintain health and well-being.")
    ]
    
    var body: some View {
        let (bestSleepTime, bestWakeUpTime, totalSleepDuration, totalCycles) = viewModel.calculateSleepCycle()
        let alternativeSleepTimes = viewModel.getAlternativeSleepTimes()
        
        ScrollView {
            VStack(spacing: 0) {
                // Header area
                VStack(spacing: 20) {
                    // Neon Image with Sleep Cycles
                    ZStack {
                        Image("neon")
                            .resizable()
                            .scaledToFit()
                            .padding(.leading, 5)
                            .phaseAnimator([false, true]) { wwdc24, chromaRotate in
                                wwdc24
                                    .hueRotation(.degrees(chromaRotate ? 420 : 0))
                            } animation: { chromaRotate in
                                .easeInOut(duration: 2)
                            }
                        
                        // Display total sleep cycles
                        VStack {
                            Text("\(totalCycles)")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            Text("Cycles")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Sleep Recommendations Card
                    if let selectedRecommendation = sleepRecommendations.first(where: { $0.category == viewModel.sleepData.ageCategory }) {
                        VStack(alignment: .leading, spacing: 12) {
                            // Header
                            Text("Sleep Recommendations")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 16)
                                .padding(.top, 12)
                            
                            // Content
                            HStack(alignment: .top, spacing: 12) {
                                VStack(alignment: .leading, spacing: 8) {
                                    // Age Category
                                    HStack(spacing: 4) {
                                        Image(systemName: "person.text.rectangle")
                                            .foregroundColor(Color("Kuning").opacity(0.7)) // Changed to Kuning
                                        Text("Age Category")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(selectedRecommendation.category)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 4)
                                    
                                    // Recommended Sleep
                                    HStack(spacing: 4) {
                                        Image(systemName: "clock")
                                            .foregroundColor(Color("Kuning").opacity(0.7)) // Changed to Kuning
                                        Text("Recommended Sleep")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(selectedRecommendation.hours)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 4)
                                    
                                    // Description
                                    Text(selectedRecommendation.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.top, 4)
                                }
                                
                                Spacer()
                                
                                // Age Category Icon
                                Image(systemName: ageIcon(for: selectedRecommendation.category))
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("UnguMuda")) // Kept UnguMuda as requested
                                    .padding(.top, 4)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                        }
                        .background(Color(.systemGray6).opacity(0.1))
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color("UnguMuda").opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 16)
                    }
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 16) {
                    // Best Sleep Times Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Best Sleep Times")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                        
                        VStack(spacing: 10) {
                            DataCard(
                                title: "Best Sleep Time",
                                subtitle: "Optimal bedtime",
                                data: bestSleepTime,
                                iconName: "moon.zzz.fill",
                                accentColor: Color("Kuning") // Changed to Kuning color
                            )
                            
                            DataCard(
                                title: "Wake-up Time",
                                subtitle: "Optimal wake-up time",
                                data: bestWakeUpTime,
                                iconName: "sun.max.fill",
                                accentColor: Color("Kuning") // Changed to Kuning color
                            )
                            
                            DataCard(
                                title: "Total Sleep Duration",
                                subtitle: "Time spent sleeping",
                                data: totalSleepDuration,
                                iconName: "clock.fill",
                                accentColor: Color("Kuning") // Changed to Kuning color
                            )
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom, 12)
                    }
                    .background(Color(.systemGray6).opacity(0.1))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color("UnguMuda").opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Alternative Sleep Times Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Alternative Sleep Times")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                        
                        VStack(spacing: 10) {
                            ForEach(alternativeSleepTimes, id: \.sleepTime) { time in
                                DataCard(
                                    title: "Sleep at \(time.sleepTime)",
                                    subtitle: "Wake up at \(time.wakeUpTime)",
                                    data: time.duration,
                                    iconName: "bed.double.fill",
                                    accentColor: Color("UnguMuda") // Kept UnguMuda as requested
                                )
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom, 12)
                    }
                    .background(Color(.systemGray6).opacity(0.1))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color("UnguMuda").opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function for age category icon (same as in HomeView)
    func ageIcon(for category: String) -> String {
        switch category {
        case "Newborn (0-3 months)":
            return "figure.2.arms.open"
        case "Infant (4-12 months)":
            return "figure.and.child.holdinghands"
        case "Toddler (1-2 years)":
            return "figure.child"
        case "Preschool (3-5 years)":
            return "figure.child.and.lock"
        case "School Age (6-12 years)":
            return "figure.2.arms.open"
        case "Teen (13-18 years)":
            return "person.crop.circle"
        case "Adults (19-60 years)":
            return "person.crop.rectangle"
        case "Older Adult (61-64 years)":
            return "person.crop.rectangle.fill"
        case "Senior (65+ years)":
            return "person.fill"
        default:
            return "person.fill"
        }
    }
}
