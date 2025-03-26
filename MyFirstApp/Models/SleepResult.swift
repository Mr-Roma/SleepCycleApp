

import SwiftData
import Foundation

@Model
class SleepResult {
    var sleepDuration: String  // Simpan dalam detik
    var deepSleepPercentage: String
    var remSleepPercentage: String
    var totalCycles: Int
    var timestamp: Date

    init(sleepDuration: String, deepSleepPercentage: String, remSleepPercentage: String, totalCycles: Int, timestamp: Date = Date.now ) {
        self.sleepDuration = sleepDuration
        self.deepSleepPercentage = deepSleepPercentage
        self.remSleepPercentage = remSleepPercentage
        self.totalCycles = totalCycles
        self.timestamp = timestamp
    }
}

@Model
class SleepAlternative {
    var sleepDuration: String  // Simpan dalam detik
    var WakeUpTime: String
    var SleepTime: String
    var totalCycles: Int
    var timestamp: Date

    
    init(sleepDuration: String, WakeUpTime: String, SleepTime: String, totalCycles: Int, timestamp: Date = Date.now) {
        self.sleepDuration = sleepDuration
        self.WakeUpTime = WakeUpTime
        self.SleepTime = SleepTime
        self.totalCycles = totalCycles
        self.timestamp = timestamp
    }
}

