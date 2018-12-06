//
//  day3.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/4/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation



func dayThree() {

    let splitInput = input3
        .components(separatedBy: .newlines)
        .map {
            $0.replacingOccurrences(of: "@ ", with: "")
                .replacingOccurrences(of: "#", with: "")
                .replacingOccurrences(of: ",", with: " ")
                .replacingOccurrences(of: ":", with: "")
                .replacingOccurrences(of: "x", with: " ")
                .components(separatedBy: .whitespaces)
                .map { Int($0) }}


    var fabric = Array(repeating: (Array(repeating: 0, count: 2500)), count: 2500)
    for area in splitInput {
        let xPos = area[0]
        let yPos = area[1]
        let width = area[2]
        let height = area[3]

        (xPos! ..< xPos! + width!).forEach { x in
            (yPos! ..< yPos! + height!).forEach { y in
                fabric[x][y] += 1
            }
        }
    }

    let flatFabric = Array(fabric.joined())
        .filter { $0 > 1 }
        .count
    print(flatFabric)
}







