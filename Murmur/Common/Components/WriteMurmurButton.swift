
//
//  MurmurButton.swift
//  Murmur
//
//  Created by Ethan on 6/29/25.
//

import Foundation
import SwiftUI

struct WriteMurmurButton: View {
    let title: String
    let font: Font
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let action: () -> Void

    init(title: String, font: Font, backgroundColor: Color = .PointMint, foregroundColor: Color = .Gray900, cornerRadius: CGFloat = 15.0, action: @escaping () -> Void) {
        self.title = title
        self.font = font
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.action = action
    }

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
