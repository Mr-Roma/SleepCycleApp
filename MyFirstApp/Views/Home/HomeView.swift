import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SleepViewModel
    @State private var showResultsView = false
    @State private var showValidationAlert = false // To show an alert if fields are not filled
    @State private var validationMessage = "" // Message to display in the alert
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // App Title
                    Text("SleepCycle")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    // Image
                    Image(systemName: "moon.stars.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                        .padding()
                    
                    // Description
                    Text("Analyze your sleep patterns to improve your rest quality and wake up refreshed.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Form Fields
                    FormSection(title: "Age") {
                        AgeDropdown(selectedOption: $viewModel.sleepData.ageCategory)
                    }
                    
                    FormSection(title: "Time to Fall Asleep") {
                        TimeToSleepPicker(fallAsleepMinutes: $viewModel.sleepData.fallAsleepMinutes)
                    }
                    
                    FormSection(title: "Wake-up Time") {
                        WakeUpTimePicker(wakeUpTime: $viewModel.sleepData.wakeUpTime)
                    }
                    
                    // Analyze Button
                    Button(action: {
                        // Validate inputs before proceeding
                        if validateInputs() {
                            showResultsView = true // Navigate to ResultsView only if inputs are valid
                        } else {
                            showValidationAlert = true // Show alert if validation fails
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
                    .disabled(!areInputsValid()) // Disable button if inputs are not valid
                    .opacity(areInputsValid() ? 1 : 0.6) // Reduce opacity if button is disabled
                    
                    // NavigationLink to ResultsView
                    NavigationLink(
                        destination: ResultsView(viewModel: viewModel),
                        isActive: $showResultsView,
                        label: { EmptyView() }
                    )
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .alert(isPresented: $showValidationAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use stack navigation for full-screen transitions
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
}
