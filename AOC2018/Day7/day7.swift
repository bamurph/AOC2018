//
//  day7.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/15/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

// Parse out steps with predicates like "step: [predicate]"
fileprivate let steps = input7
    .components(separatedBy: .newlines)
    .map { $0.components(separatedBy: " ") }
    .map { [$0[7]: $0[1]] }
    .reduce(into: [String: String]()) { acc, next in
        acc.merge(next, uniquingKeysWith: +)}

let befores = Set(steps.flatMap { Array($0.key) })
let afters = Set(steps.flatMap { Array($0.value) })
let all = afters.union(befores).map {String($0)}

func daySeven() {


    // Determine the order in which steps should be completed, if more than one is ready then do alphabetically.

    // Start by finding first step that has no unsatisfied predicates

    let fs = all.filter { befores.contains($0.first!) != true }
        .sorted()
        .joined()

    func sortThrough(list: [String: String], completed: String, initials: String) -> String {

        let completable = list
            .filter { Set($0.value).isSubset(of: Set(completed))}
            .map { $0.key }
            .sorted().joined() + initials

        if completable == "" { return completed }

        let next = String(completable.first!)

        let newInitials = initials.replacingOccurrences(of: next, with: "")

        let newlist = list.filter { $0.key != next}
        let updatedCompleted = completed + next

        let toReturn = sortThrough(list: newlist, completed: updatedCompleted, initials: newInitials)
        return toReturn
    }

    let ls = sortThrough(list: steps, completed: "", initials: String(fs))


    print(ls)

}
