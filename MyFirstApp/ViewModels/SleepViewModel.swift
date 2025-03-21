import Foundation
import SwiftData

class SleepViewModel: ObservableObject {
    @Published var sleepData = SleepData(
        ageCategory: "Select Age Category",
        fallAsleepMinutes: 15,
        wakeUpTime: Date()
    )
    
    @Published var sleepResults: [SleepResult] = []
    
    // Function to save sleep results
    func saveSleepResult(context: ModelContext, sleepDuration: String, deepSleepPercentage: String, remSleepPercentage: String, totalCycles: Int) {
        let newResult = SleepResult(
            sleepDuration: sleepDuration,
            deepSleepPercentage: deepSleepPercentage,
            remSleepPercentage: remSleepPercentage,
            totalCycles: totalCycles
        )
        
        context.insert(newResult)
        
        do {
            try context.save() // Simpan ke SwiftData dengan error handling
            print("""
                ✅ Data saved successfully:
                - Sleep Duration: \(newResult.sleepDuration) seconds
                - Deep Sleep: \(newResult.deepSleepPercentage)%
                - REM Sleep: \(newResult.remSleepPercentage)%
                - Total Cycles: \(newResult.totalCycles)
                - Timestamp: \(newResult.timestamp)
                """)
        } catch {
            print("❌ Error saving sleep result: \(error.localizedDescription)")
        }
    }
    
    /// Calculate the best sleep time, wake-up time, and total sleep duration
    func calculateSleepCycle() -> (bestSleepTime: String, bestWakeUpTime: String, totalSleepDuration: String, totalCycles: Int) {
        let ageCategory = sleepData.ageCategory
        let fallAsleepMinutes = sleepData.fallAsleepMinutes
        let wakeUpTime = sleepData.wakeUpTime
        
        // Determine the number of sleep cycles based on age
        let numberOfCycles = getNumberOfCycles(for: ageCategory)
        
        // Calculate total sleep duration in minutes
        let totalSleepDuration = numberOfCycles * 90
        
        // Convert wakeUpTime to total minutes in the day
        let calendar = Calendar.current
        let wakeUpTimeInMinutes = calendar.component(.hour, from: wakeUpTime) * 60 + calendar.component(.minute, from: wakeUpTime)
        
        // Calculate the best sleep time
        var bestSleepTimeInMinutes = wakeUpTimeInMinutes - totalSleepDuration - fallAsleepMinutes
        
        // Ensure the sleep time is on the same night as the wake-up time
        if bestSleepTimeInMinutes < 0 {
            bestSleepTimeInMinutes += 24 * 60 // Adjust to the previous night
        }
        
        let bestSleepTime = convertMinutesToTime(bestSleepTimeInMinutes)
        let bestWakeUpTime = convertMinutesToTime(wakeUpTimeInMinutes)
        
        // Format total sleep duration
        let totalSleepDurationFormatted = "\(totalSleepDuration / 60)h \(totalSleepDuration % 60)m"
        
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
            
            if sleepTimeInMinutes < 0 {
                sleepTimeInMinutes += 24 * 60 // Adjust to the previous night
            }
            
            let sleepTime = convertMinutesToTime(sleepTimeInMinutes)
            let wakeUpTime = convertMinutesToTime(wakeUpTimeInMinutes)
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
    private func convertMinutesToTime(_ minutes: Int) -> String {
        let hours = (minutes / 60) % 24  // Pastikan tetap dalam format 24 jam
        let mins = minutes % 60
        return String(format: "%02d:%02d", hours, mins)
    }
}
