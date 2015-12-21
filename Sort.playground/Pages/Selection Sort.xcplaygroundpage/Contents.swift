//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Selection Sort
//: ----
//:
//: ### Idea
//:
//: - Split the input array in two portions, one sorted and one unsorted
//: - Initially, the sorted portion is empty, while the unsorted one contains all the elements
//: - Find the smallest element in the unsorted portion and move it to the end of the sorted portion
//: - Eventually, the unsorted portion becomes empty and the array sorted
//:
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Not Adaptative, as it does not benefit from the presortedness in the input array
//: - Not Stable, as it does not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n²)_ and _O(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases early exit `if`, `count`, `for-in`, `..<`, subcripting, and tuple swapping
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order
///
/// - todo: Remove code annotations

func selectionSort_theClassic(array: [Int]) -> [Int] {

    // take in an array that is considered unsorted and make a copy of it
    var array = array

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pass through the array, but it needs only as many passes as the number of swaps required
    for i in 0..<array.count - 1 {
        
        // consider the first element of the unsorted portion to be the smallest
        var indexOfTheSmallestElement = i

        // pass thorugh the unsorted portion to find the smallest unsorted element
        for j in (indexOfTheSmallestElement + 1)..<array.count {

            // compare the current element to the considered smallest element
            if array[j] < array[indexOfTheSmallestElement] {

                // remember the current element as the new smallest one
                indexOfTheSmallestElement = j
            }
        }

        // check if the smallest element is not already in its correct location
        if i != indexOfTheSmallestElement {

            // swap the smallest element with the first unsorted element, appending it to the sorted portion
            (array[i], array[indexOfTheSmallestElement]) = (array[indexOfTheSmallestElement], array[i])
        }
    }

    // return sorted array
    return array
}

// Tests

// Already Sorted
assert(selectionSort_theClassic([Int]()).isSorted())
assert(selectionSort_theClassic([7]).isSorted())
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `guard`, `count`, `for-in-where`, `..<`, subcripting,`continue`, and `swap`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func selectionSort_theSwiftish(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 0..<array.count - 1 {

        var indexOfMinElement = i

        for j in (indexOfMinElement + 1)..<array.count where array[j] < array[indexOfMinElement] {
            indexOfMinElement = j
        }

        if i == indexOfMinElement {
            continue
        }

        swap(&array[i], &array[indexOfMinElement])
    }
    
    return array
}

// Tests

// Already Sorted
assert(selectionSort_theSwiftish([Int]()).isSorted())
assert(selectionSort_theSwiftish([7]).isSorted())
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `guard`, `count`, `for-in`, subcripting, `..<`, `minElement`, `indexOf`, `removeAtIndex`, and `append`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func selectionSort_theSwiftest(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for index in 0..<array.count {

        let newArray = array[0..<array.count - index]

        if let minElement = newArray.minElement(), indexOfMinElement = newArray.indexOf(minElement) {

            array.removeAtIndex(indexOfMinElement)
            array.append(minElement)
        }
    }
    
    return array
}

// Tests

// Already Sorted
assert(selectionSort_theSwiftest([Int]()).isSorted())
assert(selectionSort_theSwiftest([7]).isSorted())
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `guard`, `count`, `for-in`, subcripting, `..<`, `minElement`, `indexOf`, `removeAtIndex`, `append`, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func selectionSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for index in 0..<array.count {

        let newArray = array[0..<array.count - index]

        if let minElement = newArray.minElement(), indexOfMinElement = newArray.indexOf(minElement) {

            array.removeAtIndex(indexOfMinElement)
            array.append(minElement)
        }
    }

    return array
}

// Tests

// Already Sorted
assert(selectionSort_theGeneric([Int]()).isSorted())
assert(selectionSort_theGeneric([7]).isSorted())
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(selectionSort_theGeneric([String]()).isSorted())
assert(selectionSort_theGeneric(["a"]).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(selectionSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(selectionSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
