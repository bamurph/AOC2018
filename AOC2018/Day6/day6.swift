//
//  Day6.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/14/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

fileprivate let lines = input6.components(separatedBy: .newlines)

fileprivate let coordinates = lines.map { line -> Coordinate in
    let coords = line.components(separatedBy: ", ")
    return Coordinate(x: Int(coords[0])!, y: Int(coords[1])!)
}


fileprivate func distanceBetween(first: Coordinate, second: Coordinate) -> Int {
    let xDistance = abs(first.x - second.x)
    let yDistance = abs(first.y - second.y)
    return (xDistance + yDistance)
}

fileprivate struct Coordinate: Hashable {
    let x: Int
    let y: Int

    func distanceTo(_ second: Coordinate) -> Int {
        return distanceBetween(first: self, second: second)
    }



    func totalDistanceTo(_ coordinates: [Coordinate]) -> Int {
        return coordinates
            .map { self.distanceTo($0) }
            .reduce(0,+)
    }

    func isBounded(among: [Coordinate]) -> Bool {
        let northwest = among.contains { $0.x < self.x && $0.y < self.y }
        let northeast = among.contains { $0.x > self.x && $0.y < self.y }
        let southwest = among.contains { $0.x < self.x && $0.y > self.y }
        let southeast = among.contains { $0.x > self.x && $0.y > self.y }
        return (northeast && northwest && southwest && southeast)
    }

    func closest(among: [Coordinate]) -> [Coordinate] {
        return among.reduce(into: [Coordinate]()) {acc, next in
            if acc.count == 0 { acc.append(next); return }
            if acc.last!.distanceTo(self) == next.distanceTo(self) { acc.append(next); return  }
            if acc.last!.distanceTo(self) > next.distanceTo(self) { acc = [next]; return }
        }

    }

}

func daySix() {

    let finiteCoordinates = coordinates.filter { $0.isBounded(among: coordinates)}

    let minX = coordinates.map { $0.x }.min()
    let maxX = coordinates.map { $0.x }.max()
    let minY = coordinates.map { $0.y }.min()
    let maxY = coordinates.map { $0.y }.max()

    let sequenceX = minX!...maxX!
    let sequenceY = minY!...maxY!

    let sequenceX2 = 0...500
    let sequenceY2 = 0...500

    let board2 = Set(sequenceX2.flatMap { x in sequenceY2.map { y in Coordinate(x: x, y:y)}})
    let board = Set(sequenceX.flatMap { x in sequenceY.map { y in Coordinate(x: x, y: y)}})



    let distances = board.map { ($0, $0.closest(among: coordinates)) }.filter {$0.1.count == 1}
    let distances2 = board2.map {($0, $0.closest(among: coordinates))}.filter {$0.1.count == 1}

    let areas1 = distances.reduce(into: [Coordinate:Int]()) { acc, next in
        acc[next.1.first!, default: 0] += 1 }

    let areas2 = distances2.reduce(into: [Coordinate:Int]()) { acc, next in
        acc[next.1.first!, default: 0] += 1 }

    let result = zip(areas1, areas2)
        .filter { $0 == $1 }
        .map {$0.0.value}
        .max()!


}

func daySixPartTwo() {
    assert(Coordinate(x: 4, y: 3).distanceTo(Coordinate(x:1,y:1)) == 5)
    assert(Coordinate(x: 4, y: 3).distanceTo(Coordinate(x:8,y:9)) == 10)
    let range = 0...400
    let board = range.flatMap { x in range.map { y in Coordinate(x: x, y: y)}}

    let totalDistances = board
        .map { $0.totalDistanceTo(coordinates) }

    let inRegion = totalDistances.filter { $0 < 10000}
    _ = inRegion
}

