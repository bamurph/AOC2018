//
//  day3.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/4/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func dayThree() {

    struct Claim {
        let id: Int
        let x: Int
        let y: Int
        let width: Int
        let height: Int
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

    print(claims)
    print(claims.count)


}







