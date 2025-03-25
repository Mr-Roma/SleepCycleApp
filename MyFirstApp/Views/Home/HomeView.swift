import SwiftUI

// Define a model for sleep recommendations
struct SleepRecommendation {
    let category: String
    let age: String
    let hours: String
    let description: String
}

// HomeView.swift
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SleepViewModel
    @State private var showResultsView = false
    @State private var showValidationAlert = false
    @State private var validationMessage = ""
    
    // Sleep recommendations based on age categories
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
        NavigationView {
            ScrollView {
                VStack() {
                    
                    GifImage(name: "home_animation")
                        .frame(width: 280, height: 280)
                        .padding(.bottom, -50)
                    
                    // Display selected age category information
                    if !viewModel.sleepData.ageCategory.isEmpty && viewModel.sleepData.ageCategory != "Select Age Category" {
                        if let selected = sleepRecommendations.first(where: { $0.category == viewModel.sleepData.ageCategory }) {
                            VStack(spacing: 12) {
                                Text(selected.category)
                                    .font(.headline)
                                    .foregroundColor(Color("UnguMuda"))
                                
                                HStack(alignment: .top, spacing: 2) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("Recommended: \(selected.hours)")
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                                .fontWeight(.medium)
                                        }
                                        
                                        Text(selected.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    
                                    Spacer()
                                    
                                    // Icon based on age category
                                    Image(systemName: ageIcon(for: selected.category))
                                        .font(.system(size: 32))
                                        .foregroundColor(Color("UnguMuda"))
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("UnguTua"), lineWidth: 2)
                            )
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        }
                    } else {
                        // Description and "Read More" link when no age category is selected
                        VStack {
                            Text("Analyze your sleep patterns to improve your rest quality and wake up refreshed.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    
                    // Form Fields
                    FormSection(title: "Age") {
                        AgeDropdown(selectedOption: $viewModel.sleepData.ageCategory)
                    }.padding(.bottom, 8)
                    
                    
                    FormSectionWithInfo(title: "Time to Fall A Sleep",
                                       infoDestination: AnyView(TimeToFallAsleepInfo())) {
                    TimeToSleepPicker(fallAsleepMinutes: $viewModel.sleepData.fallAsleepMinutes)
                    }.padding(.bottom, 8)
                        

                    FormSectionWithInfo(title: "Wake-up Time",
                                       infoDestination: AnyView(WakeUpTimeInfo())) {
                        WakeUpTimePicker(wakeUpTime: $viewModel.sleepData.wakeUpTime)
                    }.padding(.bottom, 8)
                        
                    
                    
                    // Analyze Button
                    Button(action: {
                        if validateInputs() {
                            // Calculate sleep score, duration, and total cycles
                            let (bestTimeToSleep, bestTimeToWake, totalSleepDuration, totalCycles) = viewModel.calculateSleepCycle()
                            let sleepDurationInSeconds = convertDurationToSeconds(totalSleepDuration)
                            
                            viewModel.saveSleepResult(
                                context: modelContext,
                                sleepDuration: totalSleepDuration,
                                deepSleepPercentage: bestTimeToSleep,
                                remSleepPercentage: bestTimeToWake,
                                totalCycles: totalCycles
                            )
                            
                            // Navigate to ResultsView
                            showResultsView = true
                        } else {
                            showValidationAlert = true
                        }
                    }) {
                        Text("Analyze")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("UnguMuda"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    
                    // NavigationLink to ResultsView
                    NavigationLink(
                        destination: ResultsView(viewModel: viewModel),
                        isActive: $showResultsView,
                        label: { EmptyView() }
                    )
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showValidationAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    // MARK: - Input Validation
    
    /// Check if all inputs are valid
    private func areInputsValid() -> Bool {
        return !viewModel.sleepData.ageCategory.isEmpty &&
        viewModel.sleepData.ageCategory != "Select Age Category" &&
        viewModel.sleepData.fallAsleepMinutes > 0 &&
        viewModel.sleepData.wakeUpTime != Date() // Ensure wake-up time is not the default value
    }
    
    /// Validate inputs and set validation message
    private func validateInputs() -> Bool {
        if viewModel.sleepData.ageCategory.isEmpty || viewModel.sleepData.ageCategory == "Select Age Category" {
            validationMessage = "Please select your age category."
            return false
        }
        if viewModel.sleepData.fallAsleepMinutes <= 0 {
            validationMessage = "Please enter a valid time to fall asleep."
            return false
        }
        if viewModel.sleepData.wakeUpTime == Date() {
            validationMessage = "Please select a wake-up time."
            return false
        }
        return true
    }
    
    func convertDurationToSeconds(_ duration: String) -> TimeInterval {
        let components = duration.split(separator: " ")
        var totalSeconds: TimeInterval = 0
        
        for component in components {
            if component.hasSuffix("h"), let hours = Int(component.dropLast()) {
                totalSeconds += TimeInterval(hours * 3600)
            } else if component.hasSuffix("m"), let minutes = Int(component.dropLast()) {
                totalSeconds += TimeInterval(minutes * 60)
            }
        }
        return totalSeconds
    }
    
    func ageIcon(for category: String) -> String {
        switch category {
        case "Newborn (0-3 months)":
            return "figure.2.arms.open" // Updated from "baby.fill"
        case "Infant (4-12 months)":
            return "figure.and.child.holdinghands" // Updated from "figure.baby"
        case "Toddler (1-2 years)":
            return "figure.child" // Updated from "figure.child.circle"
        case "Preschool (3-5 years)":
            return "figure.child.and.lock" // Updated from "figure.child.circle.fill"
        case "School Age (6-12 years)":
            return "figure.2.arms.open" // Updated from "figure.child.and.lock.open"
        case "Teen (13-18 years)":
            return "person.crop.circle" // Updated from "figure.youth"
        case "Adults (19-60 years)":
            return "person.crop.rectangle" // Updated from "figure.arms.open"
        case "Older Adult (61-64 years)":
            return "person.crop.rectangle.fill" // Updated from "figure.mind.and.body"
        case "Senior (65+ years)":
            return "person.fill" // Updated from "figure.seated.side.air.distribution"
        default:
            return "person.fill" // Remains the same
        }
    }
}
