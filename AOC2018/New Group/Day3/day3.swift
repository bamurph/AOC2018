//
//  day3.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/4/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

typealias Area = (ClosedRange<Int>, ClosedRange<Int>)

protocol Occupies {
    var occupies: Area { get }
    func overlaps(_ other: Area) -> Bool
}



func dayThree() {

    struct Claim: Occupies {
        let id: Int
        let x: Int
        let y: Int
        let width: Int
        let height: Int

        func occupies(offset: Int, length: Int) -> ClosedRange<Int> {
                let origin = x - 1
                return (origin ... (origin + width))
            }

        var occupiesX: ClosedRange<Int> {
            return occupies(offset: x, length: width)
        }

        var occupiesY: ClosedRange<Int> {
            return occupies(offset: y, length: height)
        }

        var occupies: Area {
            return (occupiesX, occupiesY)
        }

        func overlaps(_ other: Area) -> Bool {
            return occupies.0.overlaps(other.0) && occupies.1.overlaps(other.1)
        }
    }

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
    let claims = splitInput
        .map {  Claim(id: $0[0]!,
                     x: $0[1]!,
                     y: $0[2]!,
                     width: $0[3]!,
                     height: $0[4]!) }





}







