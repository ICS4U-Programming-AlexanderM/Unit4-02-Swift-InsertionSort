import Foundation
//  Created by Alexander Matheson
//  Created on 2023-May-09
//  Version 1.0
//  Copyright (c) 2023 Alexander Matheson. All rights reserved.
//
//  This program uses a bubble sort to sort an array.

// Enum for error checking.
enum InputError: Error {
  case InvalidInput
}

// Input in separate function for error checking.
func convert(strUnconverted: String) throws -> Int {
  guard let numConverted = Int(strUnconverted.trimmingCharacters(in: CharacterSet.newlines)) else {
    throw InputError.InvalidInput
  }
  return numConverted
}

// This function uses a bubble sort.
func sort(listOfNum: [Int]) -> [Int] {
  // New array because "listOfNum" is seen as a let constant for some reason.
  var listNum = listOfNum
  for element in 0...listNum.count - 1 {
    // I am aware that "ꙮ" is a completely nonsensical and terrible variable name,
    // but I wanted to test what swift would accept as a variable name.
    let ꙮ = listNum[element]
    var compare = element - 1

    // Move elements of the array that are greater than ꙮ,
    // to one position ahead of their current position.
    while compare >= 0 && listNum[compare] > ꙮ {
      listNum[compare + 1] = listNum[compare]
      compare = compare - 1
    }
    listNum[compare + 1] = ꙮ
  }
  return listNum
}

// Read in lines from input.txt.
let inputFile = URL(fileURLWithPath: "input.txt")
let inputData = try String(contentsOf: inputFile)
let lineArray = inputData.components(separatedBy: .newlines)

// Open the output file for writing.
let outputFile = URL(fileURLWithPath: "output.txt")

// Call function and print to output file.
var indexString = ""
var counter = 0
while counter < lineArray.count {
  // Convert to int.
  var error = false
  let tempArr = lineArray[counter].components(separatedBy: " ")
  var numArr: [Int] = []
  do {
    for location in tempArr {
      numArr.append(try convert(strUnconverted: location))
    }
  } catch InputError.InvalidInput {
    error = true
  }

  // Check for errors
  if error {
    indexString = indexString + "Cannot convert line to int\n"
  } else {
    // Call function and output results.
    let index = sort(listOfNum: numArr)
    indexString = indexString + "\(index)\n"
  }
  try indexString.write(to: outputFile, atomically: true, encoding: .utf8)
  counter = counter + 1
}
print(indexString)
