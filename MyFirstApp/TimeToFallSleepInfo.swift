import SwiftUI

// MARK: - Data Models

private struct StageItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let color: Color
}

private struct FindingItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
}


struct TimeToFallAsleepInfo: View {
    // Data Models
    private let sleepStages = [
        StageItem(name: "N1 Stage",
                 description: "The 'dozing off' phase (1-7 minutes). Light sleep with slow brain waves. You may experience hypnic jerks.",
                 icon: "moon",
                 color: .unguMuda),
        StageItem(name: "N2 Stage",
                 description: "Light sleep (50% of total sleep). Heart rate decreases and body temperature drops. Essential for memory consolidation.",
                 icon: "moon.fill",
                 color: .unguMuda),
        StageItem(name: "N3 Stage",
                 description: "Deep, restorative sleep. Critical for hormone regulation, memory consolidation, tissue repair, and immune function.",
                 icon: "moon.stars",
                 color: .unguMuda),
        StageItem(name: "REM Stage",
                 description: "Dream state with high brain activity. Crucial for memory and mood regulation. Occurs at the end of each cycle.",
                 icon: "moon.stars.fill",
                 color: .unguMuda)
    ]
    
    private let findings = [
        FindingItem(icon: "clock.badge.checkmark",
                  title: "Normal Sleep Onset",
                  description: "Taking 15-20 minutes to fall asleep is considered normal and healthy",
                    color: Color("UnguMuda")),
        FindingItem(icon: "exclamationmark.triangle",
                  title: "Potential Sleep Deprivation",
                  description: "Falling asleep in <5 minutes may indicate sleep deprivation",
                  color:  Color("UnguMuda")),
        FindingItem(icon: "timer",
                  title: "Possible Insomnia",
                  description: "Taking >30 minutes regularly may suggest insomnia",
                  color:  Color("UnguMuda"))
    ]
    
    private let optimizationTips = [
        "Maintain consistent sleep schedule",
        "Create a relaxing pre-bed routine",
        "Keep bedroom cool (60-67°F)",
        "Avoid caffeine 6+ hours before bed",
        "Limit screen time before sleep"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Section
                headerSection
                
                // Why It Matters Section
                section(title: "Why It Matters") {
                    Text("The time it takes you to fall asleep directly affects your sleep cycles. Most adults take 10-20 minutes to fall asleep (sleep latency). This duration impacts when you enter your first complete sleep cycle.")
                        .foregroundColor(.secondary)
                }
                
                // Ultradian Sleep Cycles Section
                section(title: "Ultradian Sleep Cycles") {
                    Text("Human sleep follows ultradian rhythms - repeating cycles of about 90-110 minutes throughout the night. Each cycle progresses through N1, N2, N3 (deep sleep), and REM stages.")
                        .foregroundColor(.secondary)
                    
                    stagesList
                    
                    Text("If you take longer to fall asleep, your first cycle may be incomplete, potentially reducing the quality of your most restorative deep sleep in the early cycles.")
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
                
                // Research Findings Section
                section(title: "Key Research Findings") {
                    ForEach(findings) { finding in
                        findingRow(finding: finding)
                    }
                }
                
                // Optimization Section
                section(title: "Optimizing Your Sleep Onset") {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(optimizationTips, id: \.self) { tip in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("UnguMuda"))
                                    .frame(width: 36)
                                
                                Text(tip)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                // Call to Action
                callToAction
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Fall A Sleep Time")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        VStack {
            Image("timeInfo")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .padding(.vertical, 8)
        }
    }
    
    private var stagesList: some View {
        ForEach(sleepStages) { stage in
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: stage.icon)
                    .font(.system(size: 20))
                    .foregroundColor(stage.color)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(stage.name)
                        .font(.headline)
                        .foregroundColor(stage.color)
                    
                    Text(stage.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(12)
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
            Text("Adjust Your Routine")
                .font(.headline)
            
            Text("Use your average time to fall asleep to calculate more accurate bedtimes that ensure complete sleep cycles.")
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

