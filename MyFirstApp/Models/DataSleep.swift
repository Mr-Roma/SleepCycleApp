////
////  DataSleep.swift
////  MyFirstApp
////
////  Created by Michael on 19/03/25.
////
//
//
//import Foundation
//import SwiftData
//
//
//@Model
//class ResultSleep {
//    var sleepScore: Int
//    var sleepDuration: String
//    var deepSleepPercentage: Double
//    var remSleepPercentage: Double
//
//    init(sleepScore: Int, sleepDuration: String, deepSleepPercentage: Double, remSleepPercentage: Double) {
//        self.sleepScore = sleepScore
//        self.sleepDuration = sleepDuration
//        self.deepSleepPercentage = deepSleepPercentage
//        self.remSleepPercentage = remSleepPercentage
//    }
//}
//
//class ViewModelSleep: ObservableObject {
//    @Published var sleepData: DataSleep
//    @Published var sleepResults: [ResultSleep] = []
//
//    private var modelContext: ModelContext
//
//    init(context: ModelContext) {
//        self.modelContext = context
//
//        // Ambil data SleepData jika ada, jika tidak buat yang baru
//        let request = FetchDescriptor<DataSleep>()
//        if let existingData = try? context.fetch(request).first {
//            self.sleepData = existingData
//        } else {
//            let newData = DataSleep()
//            self.sleepData = newData
//            context.insert(newData)
//            try? context.save()
//        }
//
//        // Ambil sleep results dari database
//        let resultsRequest = FetchDescriptor<ResultSleep>()
//        if let results = try? context.fetch(resultsRequest) {
//            self.sleepResults = results
//        } else {
//            // Data default jika tidak ada di database
//            let defaultResults = [
//                ResultSleep(sleepScore: 87, sleepDuration: "8h 15m", deepSleepPercentage: 0.22, remSleepPercentage: 0.27),
//                ResultSleep(sleepScore: 82, sleepDuration: "7h 45m", deepSleepPercentage: 0.20, remSleepPercentage: 0.25),
//                ResultSleep(sleepScore: 79, sleepDuration: "7h 10m", deepSleepPercentage: 0.18, remSleepPercentage: 0.22),
//                ResultSleep(sleepScore: 91, sleepDuration: "8h 30m", deepSleepPercentage: 0.25, remSleepPercentage: 0.30),
//                ResultSleep(sleepScore: 85, sleepDuration: "8h 00m", deepSleepPercentage: 0.21, remSleepPercentage: 0.26)
//            ]
//            self.sleepResults = defaultResults
//            defaultResults.forEach { context.insert($0) }
//            try? context.save()
//        }
//    }
//
//    func updateSleepData(ageCategory: String, fallAsleepMinutes: Int, wakeUpTime: Date) {
//        sleepData.ageCategory = ageCategory
//        sleepData.fallAsleepMinutes = fallAsleepMinutes
//        sleepData.wakeUpTime = wakeUpTime
//        try? modelContext.save()
//    }
//
//    func calculateSleepCycle() -> (bestSleepTime: String, bestWakeUpTime: String, totalSleepDuration: String, totalCycles: Int) {
//        let ageCategory = sleepData.ageCategory
//        let fallAsleepMinutes = sleepData.fallAsleepMinutes
//        let wakeUpTime = sleepData.wakeUpTime
//
//        let numberOfCycles = getNumberOfCycles(for: ageCategory)
//        let totalSleepDuration = numberOfCycles * 90
//
//        let calendar = Calendar.current
//        let wakeUpTimeInMinutes = calendar.component(.hour, from: wakeUpTime) * 60 + calendar.component(.minute, from: wakeUpTime)
//        var bestSleepTimeInMinutes = wakeUpTimeInMinutes - totalSleepDuration - fallAsleepMinutes
//
//        if bestSleepTimeInMinutes < 0 {
//            bestSleepTimeInMinutes += 24 * 60
//        }
//
//        let bestSleepTime = convertMinutesToTime(minutes: bestSleepTimeInMinutes)
//        let bestWakeUpTime = convertMinutesToTime(minutes: wakeUpTimeInMinutes)
//
//        let totalSleepHours = totalSleepDuration / 60
//        let totalSleepMinutes = totalSleepDuration % 60
//        let totalSleepDurationFormatted = "\(totalSleepHours)h \(totalSleepMinutes)m"
//
//        return (bestSleepTime, bestWakeUpTime, totalSleepDurationFormatted, numberOfCycles)
//    }
//
//    func getAlternativeSleepTimes() -> [(sleepTime: String, wakeUpTime: String, duration: String)] {
//        let fallAsleepMinutes = sleepData.fallAsleepMinutes
//        let wakeUpTime = sleepData.wakeUpTime
//
//        let calendar = Calendar.current
//        let wakeUpTimeInMinutes = calendar.component(.hour, from: wakeUpTime) * 60 + calendar.component(.minute, from: wakeUpTime)
//
//        let durations = [270, 360, 450, 540]
//
//        return durations.map { duration in
//            var sleepTimeInMinutes = wakeUpTimeInMinutes - duration - fallAsleepMinutes
//
//            if sleepTimeInMinutes < 0 {
//                sleepTimeInMinutes += 24 * 60
//            }
//
//            let sleepTime = convertMinutesToTime(minutes: sleepTimeInMinutes)
//            let wakeUpTime = convertMinutesToTime(minutes: wakeUpTimeInMinutes)
//            let durationFormatted = "\(duration / 60)h \(duration % 60)m"
//            return (sleepTime, wakeUpTime, durationFormatted)
//        }
//    }
//
//    private func getNumberOfCycles(for ageCategory: String) -> Int {
//        switch ageCategory {
//        case "Children":
//            return 6
//        case "Teenagers":
//            return 5
//        case "Adults":
//            return 5
//        case "Elderly":
//            return 4
//        default:
//            return 5
//        }
//    }
//
//    private func convertMinutesToTime(minutes: Int) -> String {
//        let hours = minutes / 60
//        let mins = minutes % 60
//        return String(format: "%02d:%02d", hours, mins)
//    }
//}
