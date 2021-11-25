//
//  Date.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 02/11/2020.
//

import Foundation

public extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { self.isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { self.isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { self.isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear: Bool {
        self.isInSameYear(as: Date())
    }

    var isInThisMonth: Bool {
        self.isInSameMonth(as: Date())
    }

    var isInThisWeek: Bool {
        self.isInSameWeek(as: Date())
    }

    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }


}
