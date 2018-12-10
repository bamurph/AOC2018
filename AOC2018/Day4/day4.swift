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
    let lines = sample4.components(separatedBy: .newlines)
    let records: [Record] = lines
        .map {
            let time = String(String($0.dropFirst()).prefix(through: $0.firstIndex(of: "]")!).dropLast(2))
            let eventString = String(String($0.suffix(from: $0.firstIndex(of: "]")!)).dropFirst(2))
            var guardID: Int? = nil
            if eventString.range(of: "Guard") != nil {
                guardID = Int(String(eventString.dropFirst(7).split(separator: " ").first!))
            }
            let actionString: String? = eventString.split(separator: " ").suffix(from: 2).joined(separator: " ")
            return Record(time: time, guardID: guardID, action: actionString!)
    }
    print(records.randomElement())
}
