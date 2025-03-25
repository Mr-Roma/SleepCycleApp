

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
