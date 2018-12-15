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

let befores = Set(steps.flatMap { Array($0.key) })
let afters = Set(steps.flatMap { Array($0.value) })
let all = afters.union(befores).map {String($0)}

func daySeven() {

   let a = all.sorted()
    // Determine the order in which steps should be completed, if more than one is ready then do alphabetically.

    // Start by finding first step that has no unsatisfied predicates

    var completed = all
        .filter { befores.contains($0.first!) != true }
        .sorted()
        .first!

    func workThrough(list: [String: String], completed: String) -> String {
        let completable = list.filter { completed
            .contains($0.value) == true }
            .min { a, b in a.key < b.key }
        if completable == nil { return completed }
        let newlist = list.filter { $0 != completable!}
        let updatedCompleted = completed + completable!.key

        let toReturn = workThrough(list: newlist, completed: updatedCompleted)
        return toReturn
    }

    print(workThrough(list: steps, completed: completed))




}
