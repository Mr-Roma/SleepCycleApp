//
//  PrimaryButton.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

import SwiftUI


struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
