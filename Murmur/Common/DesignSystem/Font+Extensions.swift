//
//  Font+Extensions.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI

extension Font {
    static let PretendardLargeTitle = Font.custom("Pretendard-Regular", size: 34, relativeTo: .largeTitle)
    static let PretendardLargeTitleBold = Font.custom("Pretendard-Bold", size: 34, relativeTo: .largeTitle)

    static let PretendardTitle1 = Font.custom("Pretendard-Regular", size: 28, relativeTo: .title)
    static let PretendardTitle1Bold = Font.custom("Pretendard-Bold", size: 28, relativeTo: .title)

    static let PretendardTitle2 = Font.custom("Pretendard-Regular", size: 22, relativeTo: .title2)
    static let PretendardTitle2Bold = Font.custom("Pretendard-Bold", size: 22, relativeTo: .title2)

    static let PretendardTitle3 = Font.custom("Pretendard-Regular", size: 20, relativeTo: .title3)
    static let PretendardTitle3Bold = Font.custom("Pretendard-Bold", size: 20, relativeTo: .title3)

    static let PretendardBody = Font.custom("Pretendard-Regular", size: 17, relativeTo: .body)
    static let PretendardBodyBold = Font.custom("Pretendard-Bold", size: 17, relativeTo: .body)

    static let PretendardCallout = Font.custom("Pretendard-Regular", size: 16, relativeTo: .callout)
    static let PretendardCalloutBold = Font.custom("Pretendard-Bold", size: 16, relativeTo: .callout)

    static let PretendardSubheadline = Font.custom("Pretendard-Regular", size: 15, relativeTo: .subheadline)
    static let PretendardSubheadlineBold = Font.custom("Pretendard-Bold", size: 15, relativeTo: .subheadline)
}
