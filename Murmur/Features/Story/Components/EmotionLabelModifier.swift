//
//  EmotionLabelModifier.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import Foundation
import SwiftUI

struct EmotionLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 18)
            .font(.PretendardBodyBold)
            .foregroundStyle(Color.text01)
            .background(Color.gray800)
            .cornerRadius(50)
    }
}
