//
//  String+.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

//MARK: - Convertation
extension String {
    
    func toDate_yyyy_MM_dd_HH_mm_ss() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)
    }
    
    func toDate_MMM_d_yyyy() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.date(from: self)
    }
    
}
