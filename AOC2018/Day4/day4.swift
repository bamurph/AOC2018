//
//  day4.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/8/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func dayFour() {

    struct Record {
        let time: String
        let guardID: Int?
        let action: String
    }

    struct GuardRecord {
        let id: Int
        let minutesAsleep: [Range<Int>]

        func totalMinutesAsleep() -> Int {
            return minutesAsleep.map { $0.distance(from: $0.lowerBound, to:  $0.upperBound)}.reduce(0, +)
        }
    }

    // Parse out the input
    let lines = sample4.components(separatedBy: .newlines)
    var records: [Record] = lines
        .map { let split = $0.components(separatedBy: " ")
            let time = split.prefix(2).joined(separator: " ").dropFirst().dropLast()
            return Record(time:  String(time),
                          guardID: (split[2] == "Guard" ? Int(split[3].dropFirst()) : nil),
                          action: String(split.suffix(from: split.count - 2).joined(separator: " ")))
    }

    // Simple sort by timestamps
    records.sort {$0.time < $1.time}

    // Simple State Machine
    class StateMachine {

    }
}

