//
//  StringExtension.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 12/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

extension String {

  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}

/*
 str[1 ..< 3] // returns "bc"
 str[5] // returns "f"
 str[80] // returns ""
 str.substring(fromIndex: 3) // returns "def"
 str.substring(toIndex: str.length - 2) // returns "abcd"
 */
