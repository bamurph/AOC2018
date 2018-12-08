//
//  day3.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/4/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

let input3e = """
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2
"""

func dayThree() {

    let splitInput = input3
        .components(separatedBy: .newlines)
        .map {
            $0.dropFirst()
                .replacingOccurrences(of: " @ ", with: ",")
                .replacingOccurrences(of: ": ", with: ",")
                .replacingOccurrences(of: "x", with: ",")
                .components(separatedBy: ",")
                .map { Int($0) }}

    var fabric = Array(repeating: (Array(repeating: 0, count: 2500)), count: 2500)

    func forAreaIn(input: [[Int?]], closure: (Int, Int, Int) -> () ) {
        for area in input {
            let id = area[0]
            let xPos = area[1]
            let yPos = area[2]
            let width = area[3]
            let height = area[4]

            (xPos! ..< xPos! + width!).forEach { x in
                (yPos! ..< yPos! + height!).forEach { y in
                    closure(id!, x, y)
                }
            }
        }
    }

    forAreaIn(input: splitInput) {_, x, y in
        fabric[x][y] += 1
    }







    let flatFabric = fabric
        .map { $0.filter { a in a > 1 }.count }
        .reduce(0, +)


    print("Overlapping: \(flatFabric)")


    // MARK: - Part 2

    var claimCount = [Int:Bool]()
    for line in splitInput {
        claimCount.updateValue(true, forKey: line[0]!)
    }
    forAreaIn(input: splitInput) { id, x, y in
        if fabric[x][y] != 1 {
            claimCount.updateValue(false, forKey: id)
        }
    }
    print(claimCount.filter { $0.value == true})


}







