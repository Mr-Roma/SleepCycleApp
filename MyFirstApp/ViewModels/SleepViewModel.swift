import Foundation

class SleepViewModel: ObservableObject {
    @Published var sleepData = SleepData(
        ageCategory: "Select Age Category",
        fallAsleepMinutes: 15,
        wakeUpTime: Date()
    )
    
    @Published var sleepResults: [SleepResult] = [
        SleepResult(sleepScore: 87, sleepDuration: "8h 15m", deepSleepPercentage: 0.22, remSleepPercentage: 0.27),
        SleepResult(sleepScore: 82, sleepDuration: "7h 45m", deepSleepPercentage: 0.20, remSleepPercentage: 0.25),
        SleepResult(sleepScore: 79, sleepDuration: "7h 10m", deepSleepPercentage: 0.18, remSleepPercentage: 0.22),
        SleepResult(sleepScore: 91, sleepDuration: "8h 30m", deepSleepPercentage: 0.25, remSleepPercentage: 0.30),
        SleepResult(sleepScore: 85, sleepDuration: "8h 00m", deepSleepPercentage: 0.21, remSleepPercentage: 0.26)
    ]
    
    // MARK: - Ultradian Sleep Cycle Calculations
    
    /// Calculate the best sleep time, wake-up time, and total sleep duration
    func calculateSleepCycle() -> (bestSleepTime: String, bestWakeUpTime: String, totalSleepDuration: String, totalCycles: Int) {
        let ageCategory = sleepData.ageCategory
        let fallAsleepMinutes = sleepData.fallAsleepMinutes
        let wakeUpTime = sleepData.wakeUpTime
        
        // Determine the number of sleep cycles based on age
        let numberOfCycles = getNumberOfCycles(for: ageCategory)
        
        // Calculate total sleep duration in minutes
        let totalSleepDuration = numberOfCycles * 90
        
        // Calculate the best sleep time
        let calendar = Calendar.current
        let wakeUpTimeInMinutes = calendar.component(.hour, from: wakeUpTime) * 60 + calendar.component(.minute, from: wakeUpTime)
        var bestSleepTimeInMinutes = wakeUpTimeInMinutes - totalSleepDuration - fallAsleepMinutes
        
        // Ensure the sleep time is on the same night as the wake-up time
        if bestSleepTimeInMinutes < 0 {
            bestSleepTimeInMinutes += 24 * 60 // Adjust to the previous night
        }
        
        let bestSleepTime = convertMinutesToTime(minutes: bestSleepTimeInMinutes)
        
        // Calculate the best wake-up time
        let bestWakeUpTimeInMinutes = wakeUpTimeInMinutes
        let bestWakeUpTime = convertMinutesToTime(minutes: bestWakeUpTimeInMinutes)
        
        // Convert total sleep duration to hours and minutes
        let totalSleepHours = totalSleepDuration / 60
        let totalSleepMinutes = totalSleepDuration % 60
        let totalSleepDurationFormatted = "\(totalSleepHours)h \(totalSleepMinutes)m"
        
        return (bestSleepTime, bestWakeUpTime, totalSleepDurationFormatted, numberOfCycles)
    }
    
    /// Get alternative sleep times (4.5, 6, 7.5, or 9 hours)
    func getAlternativeSleepTimes() -> [(sleepTime: String, wakeUpTime: String, duration: String)] {
        let fallAsleepMinutes = sleepData.fallAsleepMinutes
        let wakeUpTime = sleepData.wakeUpTime
        
        let calendar = Calendar.current
        let wakeUpTimeInMinutes = calendar.component(.hour, from: wakeUpTime) * 60 + calendar.component(.minute, from: wakeUpTime)
        
        let durations = [270, 360, 450, 540] // 4.5, 6, 7.5, 9 hours in minutes
        
        return durations.map { duration in
            var sleepTimeInMinutes = wakeUpTimeInMinutes - duration - fallAsleepMinutes
            
            // Ensure the sleep time is on the same night as the wake-up time
            if sleepTimeInMinutes < 0 {
                sleepTimeInMinutes += 24 * 60 // Adjust to the previous night
            }
            
            let sleepTime = convertMinutesToTime(minutes: sleepTimeInMinutes)
            let wakeUpTime = convertMinutesToTime(minutes: wakeUpTimeInMinutes)
            let durationFormatted = "\(duration / 60)h \(duration % 60)m"
            return (sleepTime, wakeUpTime, durationFormatted)
        }
    }
    
    /// Get the number of sleep cycles based on age category
    private func getNumberOfCycles(for ageCategory: String) -> Int {
        switch ageCategory {
        case "Children":
            return 6
        case "Teenagers":
            return 5
        case "Adults":
            return 5
        case "Elderly":
            return 4
        default:
            return 5 // Default to 5 cycles for adults
        }
    }
    
    /// Convert minutes to time format (HH:mm)
    private func convertMinutesToTime(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return String(format: "%02d:%02d", hours, mins)
    }
}
