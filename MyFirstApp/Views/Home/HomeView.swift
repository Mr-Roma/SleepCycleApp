import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.modelContext) private var modelContext1
    @ObservedObject var viewModel: SleepViewModel
    @State private var showResultsView = false
    @State private var showValidationAlert = false
    @State private var validationMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    GifImage(name: "home_animation")
                        .frame(width: 280, height: 280)
                        .padding(.bottom, -50)
                    
                    // Description when no age category is selected
                    VStack {
                        Text("Analyze your sleep patterns to improve your rest quality and wake up refreshed.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    // Form Fields
                    FormSection(title: "Age") {
                        AgeDropdown(selectedOption: $viewModel.sleepData.ageCategory)
                    }
                    .padding(.bottom, 8)
                    
                    FormSectionWithInfo(
                        title: "Time to Fall Asleep",
                        infoDestination: AnyView(TimeToFallAsleepInfo())
                    ) {
                        TimeToSleepPicker(fallAsleepMinutes: $viewModel.sleepData.fallAsleepMinutes)
                    }
                    .padding(.bottom, 8)
                    
                    FormSectionWithInfo(
                        title: "Wake-up Time",
                        infoDestination: AnyView(WakeUpTimeInfo())
                    ) {
                        WakeUpTimePicker(wakeUpTime: $viewModel.sleepData.wakeUpTime)
                    }
                    .padding(.bottom, 8)
                    
                    // Analyze Button
                    Button(action: {
                        if validateInputs() {
                            
                            do {
                                      // Hapus semua SleepResult
                              try modelContext.delete(model: SleepResult.self)
                              
                              // Hapus semua SleepAlternative
                              try modelContext.delete(model: SleepAlternative.self)
                              
                              // Simpan perubahan
                              try modelContext.save()
                          } catch {
                              print("Error deleting existing records: \(error)")
                          }
                            // Calculate sleep score, duration, and total cycles
                            let (bestTimeToSleep, bestTimeToWake, totalSleepDuration, totalCycles) = viewModel.calculateSleepCycle()
                            let sleepDurationInSeconds = convertDurationToSeconds(totalSleepDuration)
                            
                            let alternativeSleepTimes = viewModel.getAlternativeSleepTimes()
                            
                            
                            alternativeSleepTimes.forEach { (time) in
                                print("Alternative sleep time: \(time)")
                                viewModel.saveSleepAlternativ(context: modelContext, sleepDuration: time.duration, WakeUpTime: time.sleepTime, SleepTime: time.wakeUpTime, totalCycles: 0)
                                
                            }
                            
                            viewModel.saveSleepAlternativ(context: modelContext1, sleepDuration: "a", WakeUpTime: "a", SleepTime: "a", totalCycles: 0)
                            
                            
                            
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
            .background(Color.black.ignoresSafeArea())
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
