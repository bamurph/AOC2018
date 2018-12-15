//
//  day7.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/15/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

// Parse out steps with predicates like "step: [predicate]"
fileprivate let steps = sample7
    .components(separatedBy: .newlines)
    .map { $0.components(separatedBy: " ") }
    .map { [$0[7]: $0[1]] }
    .reduce(into: [String: String]()) { acc, next in
        acc.merge(next, uniquingKeysWith: +)}

let seconds = Set(steps.flatMap { Array($0.key) })
let firsts = Set(steps.flatMap { Array($0.value) })
let all = firsts.union(seconds).map {String($0)}

func daySeven() {

    _ = all
    // Determine the order in which steps should be completed, if more than one is ready then do alphabetically.

    // Start by finding first step that has no unsatisfied predicates
    
    // Now recheck predicates and sort steps with all satisfied

    // Repeat until done


}
