//
//  SleepResult.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

//import Foundation
//
//// SleepResult.swift
//
//struct SleepResult {
//    var sleepDuration: String
//    var deepSleepPercentage: Double
//    var remSleepPercentage: Double
//    var totalCycles: Int // Add total cycles
//    var timestamp: Date // Add timestamp for sorting
//}



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
