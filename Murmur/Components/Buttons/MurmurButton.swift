//
//  MurmurButton.swift
//  Murmur
//
//  Created by Ethan on 6/29/25.
//

import Foundation
import SwiftUI

struct MurmurButton: View {
    let title: String
    let font: Font
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}
