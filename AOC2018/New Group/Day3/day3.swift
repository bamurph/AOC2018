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
            $0.replacingOccurrences(of: " @ ", with: ",")
                .replacingOccurrences(of: ": ", with: ",")
                .replacingOccurrences(of: "x", with: ",")
                .components(separatedBy: ",")
                .map { Int($0) }}

    var fabric = Array(repeating: (Array(repeating: 0, count: 2500)), count: 2500)
    for area in splitInput {
        let xPos = area[1]
        let yPos = area[2]
        let width = area[3]
        let height = area[4]

        (xPos! ..< xPos! + width!).forEach { x in
            (yPos! ..< yPos! + height!).forEach { y in
                fabric[x][y] += 1
            }
        }
    }

    let flatFabric = fabric
        .map { $0.filter { a in a > 1 }.count }
        .reduce(0, +)


    print(flatFabric)

 //Used a known good result to find my mistake. OFF BY ONE!
    func harshilsCode() -> String{
        let lines = input3
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: .newlines)

        var board = Array(repeating: Array(repeating: 0, count: 2000), count: 2000)

        lines.forEach { line in
            let components = line.components(separatedBy: .whitespaces)
            let insets = components[2]
            let xInset = Int(insets.components(separatedBy: .punctuationCharacters)[0])!
            let yInset = Int(insets.components(separatedBy: .punctuationCharacters)[1])!

            let size = components[3]
            let xSize = Int(size.prefix(while: { $0 != "x" }))!
            let ySize = Int(size.drop(while: { $0 != "x" }).dropFirst())!

            (xInset ..< xInset + xSize).forEach { x in
                (yInset ..< yInset + ySize).forEach { y in
                    board[x][y] += 1
                }
            }
        }

        func partOne() -> String {
            let overlappingCount = board
                .map { $0.reduce(0, { $1 > 1  ? $0 + 1 : $0 }) }
                .reduce(0, { $1 > 1 ? $0 + 1 : $0 })

            return "\(overlappingCount)"
        }
        return partOne()
    }

    print(harshilsCode())
}







