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

    func reduced(string: String) -> String {
       return string.reduce(into: "") { acc, next in
            if acc.count == 0 { acc.append(next); return }
            if acc.last!.isOpposite(of: next) { acc.removeLast(); return }
            acc.append(next)
        }

    }

    // Part 2

    // make a dict of every letter removed + the polymer without that letter
    // i.e. [a: stringWithoutAora]
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    let editedPolymers = alphabet.compactMap { char -> String in
        print(char)
        let lc = String(char).lowercased()
        let uc = String(char).uppercased()
        let newPolymer = polymer
            .replacingOccurrences(of: lc, with: "")
            .replacingOccurrences(of: uc, with: "")
        return newPolymer
    }
    // reduce each polymer

    let reducedNew = editedPolymers.map { reduced(string: $0).count }

  // count each reduced string
    let min = reducedNew.min()
    print(min)
}

