
import SwiftUI

// HomeView.swift
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SleepViewModel
    @State private var showResultsView = false
    @State private var showValidationAlert = false
    @State private var validationMessage = ""
   
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Image
                    Image(systemName: "moon.stars.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                        .padding()
                    
                    // Description and "Read More" link
                    VStack {
                        Text("Analyze your sleep patterns to improve your rest quality and wake up refreshed. Please read the full information below.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        NavigationLink(destination: SleepCycleInfo()) {
                            Text("See more")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.top, 8)
                        }
                    }
                    
                    // Form Fields
                    FormSection(title: "Age") {
                        AgeDropdown(selectedOption: $viewModel.sleepData.ageCategory)
                    }
                    
                    FormSection(title: "Time to Fall A Sleep") {
                        TimeToSleepPicker(fallAsleepMinutes: $viewModel.sleepData.fallAsleepMinutes)
                    }
                    
                    FormSection(title: "Wake-up Time") {
                        WakeUpTimePicker(wakeUpTime: $viewModel.sleepData.wakeUpTime)
                    }
                    
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
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .disabled(!areInputsValid())
                    .opacity(areInputsValid() ? 1 : 0.6)
                    
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
}
