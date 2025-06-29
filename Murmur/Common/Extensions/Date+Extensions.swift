//
//  Date+Extensions.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd (E) a h:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
