import SwiftUI
// ResultsView.swift

// ResultsView.swift
struct ResultsView: View {
    @ObservedObject var viewModel: SleepViewModel
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        let (bestSleepTime, bestWakeUpTime, totalSleepDuration, totalCycles) = viewModel.calculateSleepCycle()
        let alternativeSleepTimes = viewModel.getAlternativeSleepTimes()
        
        VStack(spacing: 0) {
            // Header area
            VStack(spacing: 20) {
                Text("Result")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 40)
                
                // Circle (represent total sleep cycles)
                ZStack {
                    Image("neon")
                        .resizable()
                        .scaledToFit()
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
            }
            .frame(maxWidth: .infinity)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Best Recommendation
                    Text("Best Sleep Times")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                    
                    // Best Sleep Time
                    DataCard(
                        title: "Best Sleep Time",
                        subtitle: "Optimal bedtime",
                        data: bestSleepTime
                    )
                    
                    // Best Wake-up Time
                    DataCard(
                        title: "Best Wake-up Time",
                        subtitle: "Optimal wake-up time",
                        data: bestWakeUpTime
                    )
                    
                    // Total Sleep Duration
                    DataCard(
                        title: "Total Sleep Duration",
                        subtitle: "Time spent sleeping",
                        data: totalSleepDuration
                    )
                    
                    // Alternative Sleep Times
                    Text("Alternative Sleep Times")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                    
                    ForEach(alternativeSleepTimes, id: \.sleepTime) { time in
                        DataCard(
                            title: "Sleep at \(time.sleepTime)",
                            subtitle: "Wake up at \(time.wakeUpTime)",
                            data: time.duration
                        )
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        // Remove the onAppear modifier
    }
}
