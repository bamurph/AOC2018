//
//  day2.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/2/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func dayTwo() {
    // MARK: - Part 1
    var boxIDs = input2

    let first = boxIDs.first!


    func countCharacters(in string: String) -> [Character : Int] {
       return string.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
            }
    }

    func charactersPerBox(in boxes: [String]) -> [[Character : Int]] {
        return boxes.map {
            countCharacters(in: $0)
        }

    }

    let cpb = charactersPerBox(in: boxIDs)

    let triples = cpb.filter {$0.contains(where: {$0.value == 3})}

    let doubles = cpb.filter {$0.contains(where: {$0.value == 2})}

    print(triples.count)
    print(doubles.count)
    print(triples.count * doubles.count)


    // MARK: - Part 2

    func differences(first: String, second: String) -> Int {
        return zip(first, second)
            .filter { $0.0 != $0.1 }
            .count
    }

    func compareAll(boxes: [String]) -> [(String, String)] {
        var combined = [(String, String)]()
        for box in boxes {
            for second in boxes {
                combined.append((box, second))
            }
        }
        return combined
    }

    let combined = compareAll(boxes: boxIDs)

    let compared = combined.map { ($0.0, $0.1, differences(first: $0.0, second: $0.1))}

    let single = compared.filter { (d) -> Bool in
        d.2 == 1
    }.first!
    let common = zip(single.0, single.1)
        .filter {$0.0 == $0.1}
        .map {$0.0}

}

