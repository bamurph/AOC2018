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
    let lines = input4.components(separatedBy: .newlines)

    let records: [Record] = lines.sorted()
        .map { let split = $0.components(separatedBy: " ")

            let timeString = String(split.prefix(2).joined(separator: " ").dropFirst().dropLast().suffix(2))
            let time = Int(timeString)
            return Record(time: time!,
                          guardID: (split[2] == "Guard" ? Int(split[3].dropFirst()) : nil),
                          action: String(split.suffix(from: split.count - 2).joined(separator: " ")))
    }
    let sorted1973 = records.filter {$0.guardID == 1973}

//    // Add guard IDs to each record
//    let guardRecords = records.reduce([Record]()) { acc, next in
//        if next.guardID != nil { return acc + [next] }
//        else { return acc + [Record(time: next.time,
//                              guardID: acc.last?.guardID!,
//                              action: next.action)]
//        }
//    }



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

    let guardSet = Set(sleepTimes.map {$0.id!})

    let sleepTimesFor1973 = sleepTimes.filter { $0.id == 1973}

    let sleepTotals = sleepTimes.reduce(into: [Int:Int]()) { dict, entry in
        let timeAsleep = Array(zip(entry.ends, entry.starts)).map { $0.0! - $0.1! }.reduce(0,+)
        dict[entry.id!, default: 0] += timeAsleep
    }

    let sleepiestGuard = sleepTotals
        .max { a, b in a.value < b.value }!
        .key



    func sleepTimesFor(guard gID: Int) -> [(Int?, Int?)] {
        return sleepTimes.filter {$0.id! == gID}
            .compactMap( { Array(zip($0.starts, $0.ends))})
            .reduce([],+)
    }


    // Find the minute the sleepiest guard was asleep the most
    let allAsleeps = sleepTimesFor(guard: sleepiestGuard)

    let joinedSleeps = allAsleeps
        .map { Array($0.0!..<$0.1!) }
        .reduce([], +)

    let mostAsleep = joinedSleeps
        .reduce(into: [:]) { counts, minute in counts[minute, default: 0] += 1 }
        .max { a, b in a.value < b.value }!
        .key
    print("The sleepiest Guard is \(sleepiestGuard)")
    print("is asleep for \(mostAsleep) minutes")
    print("Checksum: guard id * time asleep = \(sleepiestGuard * mostAsleep)")


    // Part 2
    // Of ALL the guards which guard is MOST FREQUENTLY ASLEEP on the SAME minute?

    var guardSleepTimes = [Int: [Int]]()

    sleepTimes.forEach {
        let minutes = Array(zip($0.starts, $0.ends))
            .map {Array($0.0!...$0.1!)}
            .flatMap { $0 }
    
        guardSleepTimes[$0.id!, default: []].append(contentsOf: minutes)
    }

    func countMinutes(minutes: [Int]) -> [Int:Int] {
        return minutes.reduce(into: [:]) { acc, next in
            acc[next, default: 0] += 1
        }
    }

    func countGuardMinutes(guardMinutes: [Int: [Int]]) -> [Int:[Int:Int]] {
        return guardMinutes.reduce(into: [:]) {acc, next in
            acc.updateValue(countMinutes(minutes: next.value), forKey: next.key)
        }
    }


    let countedGuardSleeps = countGuardMinutes(guardMinutes: guardSleepTimes)
    _ = countedGuardSleeps


    func maxSleepMinute(minutes: [Int: Int]) -> (Int, Int) {
        if minutes.count == 0 { return (0, 0)}
        let mm = minutes.max {a, b in a.value < b.value}

        return (mm!.key, mm!.value)
    }

    _ = countedGuardSleeps

    let guardsMaxSleepTimes = countedGuardSleeps
        .flatMap {
            [$0.key: maxSleepMinute(minutes: $0.value)]}
        .map {($0.key, $0.value.0, $0.value.1)}

    let sortedGuards = guardsMaxSleepTimes
        .max { a, b in a.2 < b.2 }

    print(sortedGuards!)
}

