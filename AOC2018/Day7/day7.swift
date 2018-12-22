//
//  day7.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/15/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

// Parse out steps with predicates like "step: [predicate]"
fileprivate var steps = sample7
    .components(separatedBy: .newlines)
    .map { $0.components(separatedBy: " ") }
    .map { [$0[7]: $0[1]] }
    .reduce(into: [String: String]()) { acc, next in
        acc.merge(next, uniquingKeysWith: +)}

let befores = Set(steps.flatMap { Array($0.key) })
let afters = Set(steps.flatMap { Array($0.value) })
let all = afters.union(befores).map {String($0)}
let noReqs = afters.subtracting(befores).flatMap { [String($0): ""] }
let allReqs = steps.merging(noReqs, uniquingKeysWith: +)
func daySeven() {


    // Determine the order in which steps should be completed, if more than one is ready then do alphabetically.
   print(allReqs)
//    let stepsWithRequirements = steps
//        .reduce([String: [String]]()) { acc, next in
//           let reqs = steps.wher
//    }

    // Start by finding first step that has no unsatisfied predicates


    func completable(in list: [String: String]) -> [String: String] {
        return list
            .filter {$0.value == ""}
    }

    func sortThrough(list: [String: String], completed: String) -> String {
        let clist = completable(in: list)
            .reduce(into: [String: String]()) { acc, next in
            if completed.contains(next.key) != true {
                acc.updateValue(next.value, forKey: next.key) }}

        guard let next = clist.keys.sorted().first else { return completed }

        let newList = list.mapValues { value in
            value.replacingOccurrences(of: next, with: "")
        }
        let newCompleted = completed + next

        return sortThrough(list: newList, completed: newCompleted)
    }

    let ls = sortThrough(list: allReqs, completed: "")


    print(ls)

    // Part 2

    let baseTime = 0 // Change this to 60 for real problem
    let workers = [1:"", 2:""] // Change to 5 workers for real problem

    let stepTimes = zip(Array("abcdefghijklmnopqrstuvwxyz"), 1...26)
        .map {[$0.0:$0.1]}
        .reduce(into: [:]) { acc, next in
            acc.merge(next, uniquingKeysWith: +)
    }
    let allReqsWithTimes = allReqs
        .map { [$0.key: ($0.value, stepTimes[$0.key.first!]!)]}

    // The updated Sort Function needs to also take current time (an int) and
    // a hash of worker:(step::(timecount, stepTimeForThatStep) to track which
    // worker is working which step and for how long they have been working on it.
    // The function needs to check the count of the current worker's steps vs.
    // the stepTimeForThatStep and when theyre equal that steps is counted as done


}
