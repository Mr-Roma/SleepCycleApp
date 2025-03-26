import SwiftUI

struct WakeUpTimePicker: View {
    
    @Binding var wakeUpTime: Date
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        HStack {
            Text(timeFormatter.string(from: wakeUpTime))
                .foregroundColor(.primary)
            
            Spacer()
            
            DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .colorScheme(.dark) // Force dark style
                .frame(width: 100)
            
            
        }
        .modifier(ConsistentTextFieldStyle())
    }
}
