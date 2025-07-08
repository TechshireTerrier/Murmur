//
//  LongButtonModifier.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import Foundation
import SwiftUI

struct LongButtonModifier: ViewModifier {
    var buttonColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.PretendardBodyBold)
            .foregroundStyle(Color.text07)
            .frame(width: 361, height: 54)
            .background(buttonColor)
            .cornerRadius(15)
    }
}
