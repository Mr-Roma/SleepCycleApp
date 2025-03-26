import SwiftUI

struct TimeToSleepPicker: View {
    @Binding var fallAsleepMinutes: Int
    @State private var showPicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Time display with tap action
                Button(action: {
                    withAnimation(.spring()) {
                        showPicker.toggle()
                    }
                }) {
                    Text("\(fallAsleepMinutes) min")
                        .foregroundColor(.primary)
                        .frame(minWidth: 80, alignment: .leading)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Picker button positioned between text and stepper
                Button(action: {
                    withAnimation(.spring()) {
                        showPicker.toggle()
                    }
                }) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(showPicker ? 180 : 0))
                }
                .padding(.horizontal, 8)
                
                // Stepper remains on far right
                Stepper("", value: $fallAsleepMinutes, in: 1...60)
                    .labelsHidden()
            }
            .modifier(ConsistentTextFieldStyle())
            
            // Picker that appears below
            if showPicker {
                HStack {
                    Spacer()
                    Picker("Minutes to fall asleep", selection: $fallAsleepMinutes) {
                        ForEach(1..<121) { minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 120)
                    Spacer()
                }
                .transition(.scale.combined(with: .opacity))
                .padding(.top, 8)
            }
        }
    }
}
