//
//  day1.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/1/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func dayOne() {
    // MARK: - Get the input
    let input = input1.components(separatedBy: .newlines)
    let steps = input.compactMap { str in Int(str) }
    // Part 1
    let result1 = steps.reduce(0, +)
    print("Part 1: \(result1)")

    // Part 2

    var previousFrequencies = Set<Int>()
    var freq = 0
    var n = 0

    while previousFrequencies.insert(freq).inserted {
        let step = steps[n % steps.count]
        freq = freq + step
        n += 1
        print(freq)
    }
}

