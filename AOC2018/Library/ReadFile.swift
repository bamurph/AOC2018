//
//  ReadFile.swift
//  AOC2018
//
//  Created by Ben Murphy on 12/1/18.
//  Copyright © 2018 Constellation Software. All rights reserved.
//

import Foundation

func read(file: String, of type: String) -> [String] {
    if let path = Bundle.main.path(forResource: file, ofType: type) {
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let lines = data.components(separatedBy: .newlines)
            return lines
        } catch {
            print(error)
        }
    }
    return [""]
}
