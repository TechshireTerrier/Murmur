//
//  LongButtonModifier.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import Foundation
import SwiftUI
import UIKit

struct LongButtonModifier: ViewModifier {
    var buttonColor: Color
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.height }
    static var widthSize: CGFloat { screenWidth * 0.9 }
    static var heightSize: CGFloat { screenHeight * 0.07 }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.PretendardBodyBold)
            .foregroundStyle(Color.text07)
            .frame(width: LongButtonModifier.widthSize, height: LongButtonModifier.heightSize)
            .background(buttonColor)
            .cornerRadius(15)
    }
}
