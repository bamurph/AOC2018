//
//  Day6.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/14/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

fileprivate func distanceBetween(first: Coordinate, second: Coordinate) -> Int {
    let xDistance = abs(first.x - second.x)
    let yDistance = abs(first.y - second.y)
    return (xDistance + yDistance)
}

fileprivate struct Coordinate {
    let x: Int
    let y: Int

    func distanceTo(_ second: Coordinate) -> Int {
        return distanceBetween(first: self, second: second)
    }

    func isBounded(among: [Coordinate]) -> Bool {
        let northwest = among.contains { $0.x < self.x && $0.y < self.y }
        let northeast = among.contains { $0.x > self.x && $0.y < self.y }
        let southwest = among.contains { $0.x < self.x && $0.y > self.y }
        let southeast = among.contains { $0.x > self.x && $0.y > self.y }
        return (northeast && northwest && southwest && southeast)
    }

}

func daySix() {

    let lines = sample6.components(separatedBy: .newlines)

    let coordinates = lines.map { line -> Coordinate in
        let coords = line.components(separatedBy: ", ")
        return Coordinate(x: Int(coords[0])!, y: Int(coords[1])!)
    }

    let finiteCoordinates = coordinates.filter { $0.isBounded(among: coordinates)}


}
