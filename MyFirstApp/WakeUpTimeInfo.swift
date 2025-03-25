import SwiftUI

struct WakeUpTimeInfo: View {
    
    // Reusing the same data model from TimeToFallAsleepInfo
    private struct FindingItem: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let description: String
        let color: Color
    }

    // Data Models
    private let recommendations = [
        FindingItem(icon: "clock.arrow.2.circlepath",
                   title: "Optimal Cycle Count",
                   description: "Aim to complete 5-6 cycles (7.5-9 hours) for optimal health benefits",
                    color: Color("UnguMuda")),
        FindingItem(icon: "brain.head.profile",
                   title: "REM Sleep Importance",
                   description: "REM sleep increases in later cycles - crucial for memory and mood",
                   color: Color("UnguMuda")),
        FindingItem(icon: "heart.fill",
                   title: "Deep Sleep Benefits",
                   description: "Deep N3 sleep dominates early cycles - vital for physical restoration",
                   color: Color("UnguMuda"))
    ]
    
    private let wakeTimeTips = [
        "Calculate backwards from your bedtime",
        "Add your average time to fall asleep",
        "Add sleep cycles in 90-minute increments",
        "Target waking during light sleep (N1)",
        "Experiment to find your perfect timing"
    ]
    
    private let cycleDurations = [
        ("4 cycles", "6 hours"),
        ("5 cycles", "7.5 hours"),
        ("6 cycles", "9 hours")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Section
                headerSection
                
                // Cycle Completion Section
                section(title: "Cycle Completion Matters") {
                    Text("Waking at the end of a sleep cycle (during light N1 sleep) leaves you feeling refreshed. Waking mid-cycle (especially during deep N3 or REM) causes sleep inertia - that groggy feeling that can last 30+ minutes.")
                        .foregroundColor(.secondary)
                }
                
                // 90-Minute Rhythm Section
                section(title: "The 90-Minute Rhythm") {
                    Text("Since ultradian sleep cycles average 90 minutes, timing your wake-up to coincide with cycle completion is key:")
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(cycleDurations, id: \.0) { cycle, duration in
                            HStack(spacing: 8) {
                                Text("•")
                                Text("\(cycle) = \(duration)")
                            }
                            .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 8)
                }
                
                // Scientific Recommendations Section
                section(title: "Scientific Recommendations") {
                    ForEach(recommendations) { recommendation in
                        findingRow(finding: recommendation)
                    }
                }
                
                // Finding Ideal Wake Time Section
                section(title: "Finding Your Ideal Wake Time") {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(wakeTimeTips, id: \.self) { tip in
                            Text("• \(tip)")
                        }
                    }
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                // Call to Action
                callToAction
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Wake-up Time")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        VStack {
            Image("sleepInfo")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .padding(.vertical, 8)
        }
    }
    
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            content()
        }
        .padding(.bottom, 8)
    }
    
    private func findingRow(finding: FindingItem) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: finding.icon)
                .font(.system(size: 20))
                .foregroundColor(finding.color)
                .frame(width: 36)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(finding.title)
                    .font(.headline)
                    .foregroundColor(finding.color)
                
                Text(finding.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var callToAction: some View {
        VStack(spacing: 8) {
            Text("Optimize Your Mornings")
                .font(.headline)
            
            Text("Use the calculator to find wake times that align with your natural sleep cycle completion points.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Image(systemName: "arrow.up")
                .font(.system(size: 18))
                .foregroundColor(Color("UnguMuda"))
                .padding(.top, 4)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("UnguMuda"), lineWidth: 1.5)
        )
    }
}

