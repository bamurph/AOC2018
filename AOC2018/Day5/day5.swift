//
//  Day5.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/14/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

extension Character {
    func isUpperCase() -> Bool {
        return CharacterSet.uppercaseLetters.contains(self.unicodeScalars.first!)
    }

    func isLowerCase() -> Bool {
        return !self.isUpperCase()
    }

    func isOpposite(of other: Character) -> Bool {
        if String(self).uppercased() == String(other).uppercased() {
            if self.isUpperCase() && other.isLowerCase() { return true }
            if self.isLowerCase() && other.isUpperCase() { return true }
        }
       return false
    }
}

func dayFive() {
    // Part 1
    let polymer = input5

    let reduced = polymer
        .reduce(into: "") { acc, next in
            if acc.count == 0 { acc.append(next); return }
            if acc.last!.isOpposite(of: next) { acc.removeLast(); return }
            acc.append(next)
    }
    print(reduced.count)

    // Part 2

    // make a dict of every letter removed + the polymer without that letter
    // i.e. [a: stringWithoutAora]

    // reduce each polymer
    // [a: reducedStringWithoutA]

    // count each reduced string

    // identify the shortest

}
