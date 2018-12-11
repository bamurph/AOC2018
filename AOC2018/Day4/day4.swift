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
}
