//
//  Day6.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/14/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func daySix() {

    let lines = sample6.components(separatedBy: .newlines)

    let coordinates = lines.map { line -> (Int, Int) in
        let coords = line.components(separatedBy: ", ")
        return (Int(coords[0])!, Int(coords[1])!)
    }
    
}
