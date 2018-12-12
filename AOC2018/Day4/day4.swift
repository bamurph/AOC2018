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
        let time: Int
        let guardID: Int?
        let action: String
    }

    struct SleepRecord {
        var id: Int?
        var starts: [Int?]
        var ends: [Int?]


    }

    enum Status {
        case awake, asleep
    }



    // Parse out the input
    let lines = sample4.components(separatedBy: .newlines)

    var records: [Record] = lines.sorted()
        .map { let split = $0.components(separatedBy: " ")

            let timeString = String(split.prefix(2).joined(separator: " ").dropFirst().dropLast().suffix(2))
            let time = Int(timeString)
            return Record(time: time!,
                          guardID: (split[2] == "Guard" ? Int(split[3].dropFirst()) : nil),
                          action: String(split.suffix(from: split.count - 2).joined(separator: " ")))
    }



    // Add guard IDs to each record
    let guardRecords = records.reduce([Record]()) { acc, next in
        if next.guardID != nil { return acc + [next] }
        else { return acc + [Record(time: next.time,
                              guardID: acc.last?.guardID!,
                              action: next.action)]
        }
    }



    // Find the guard with the most time spent asleep
    var sleepTimes = [SleepRecord]()
    records.forEach {
        print($0.action)
        if $0.action == "begins shift" { sleepTimes.append(SleepRecord(id: $0.guardID!, starts: [], ends: []))}
        let lastIndex = sleepTimes.count - 1
        print(lastIndex)
        if $0.action == "falls asleep" { sleepTimes[lastIndex].starts.append($0.time)}
        if $0.action == "wakes up" { sleepTimes[lastIndex].ends.append($0.time) }

    }

    let sleepTotals = sleepTimes.reduce(into: [Int:Int]()) { dict, entry in
        let timeAsleep = Array(zip(entry.ends, entry.starts)).map { $0.0! - $0.1! }.reduce(0,+)
        dict[entry.id!, default: 0] += timeAsleep
    }

    let sleepiestGuard = sleepTotals
        .max { a, b in a.value < b.value }!
        .value
    
}

