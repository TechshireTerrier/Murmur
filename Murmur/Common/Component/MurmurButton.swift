//
//  MurmurButton.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import SwiftUI

struct MurmurButton: View {
    var action: () -> Void
    var text: String
    var textColor: Color
    var bgColor: Color

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.PretendardTitle1Bold)
                .foregroundStyle(textColor)
        }
        .frame(width: 300, height: 100)
        .background(bgColor)
        .cornerRadius(20)
    }
}
