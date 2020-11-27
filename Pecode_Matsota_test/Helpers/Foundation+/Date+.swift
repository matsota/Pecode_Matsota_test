//
//  Date+.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

//MARK: - Convertation
extension Date {
    
    /// - Transofrm date into single String with `MM-dd-yyyy HH:mm`
    func toSting_dd_MM_yy_HH_mm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "uk-UA")
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// - Transofrm date into single String with  `MMM d, yyyy`
    func toSting_MMM_d_yyyy() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "uk-UA")
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    
    /// - Local date depends on `UTC`
    func localizeDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}
        
        return localDate
    }
    
}
