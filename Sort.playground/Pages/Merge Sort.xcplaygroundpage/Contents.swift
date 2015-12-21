//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Merge Sort
//: ----
//:
//: ### Idea
//:
//: - Recursively split the input array in two halves
//: - Sort the elements of both halves of the array
//: - Merge the two sorted halves
//:
//:
//: ### Properties
//:
//: - Is a divide and conquer algorithm, so computation can parallelized
//: - Not Simple, both concept and implementation are relatively complex
//: - Not Adaptative, as it does not benefit from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n-log-n)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases early exit `if`, `count`, `while`, subcripting, `+=`, and `append`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order
///
/// - todo: Remove code annotations

func mergeSort_theClassic(array: [Int]) -> [Int] {

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // find the mid point in order to split the input array into two halves
    let pivot = array.count / 2

    // set the left half of the array
    var left: [Int] = []

    for element in 0..<pivot {
        left.append(element)
    }

    // set the right half of the array
    var right: [Int] = []

    for element in pivot..<array.count {
        right.append(element)
    }

    // sort both halves recursively
    left = mergeSort_theClassic(left)
    right = mergeSort_theClassic(right)

    // create an array to be populated with sorted elements
    var sorted: [Int] = []

    // set initial indidces, start by comparing the first element of each half
    var leftIndex = 0, rightIndex = 0

    // sort and merge the two halves while there are elements in both of them
    while left.count > leftIndex && right.count > rightIndex {

        // compare elements of both halves and merge the smaller element of the respective half
        if left[leftIndex] < right[rightIndex] {
            sorted.append(left[leftIndex])
            leftIndex += 1
        } else {
            sorted.append(right[rightIndex])
            rightIndex += 1
        }
    }

    // merge remaining elements of the left half, if any
    while left.count > leftIndex {
        sorted.append(left[leftIndex])
        leftIndex += 1
    }

    // merge remaining elements of the right half, if any
    while right.count > rightIndex {
        sorted.append(right[rightIndex])
        rightIndex += 1
    }

    return sorted
}

// Tests

// Already Sorted
assert(mergeSort_theClassic([Int]()).isSorted())
assert(mergeSort_theClassic([7]).isSorted())
assert(mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(mergeSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `guard`, `count`, subcripting, `..<`, `while`, `isEmpty`, and `removeFirst`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func mergeSort_theSwiftish(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.count / 2

    var left = mergeSort_theSwiftish(Array(array[0..<pivot]))
    var right = mergeSort_theSwiftish(Array(array[pivot..<array.count]))

    var sorted: [Int] = []

    while !left.isEmpty && !right.isEmpty {

        if left[0] < right[0] {
            sorted.append(left.removeFirst())
        } else {
            sorted.append(right.removeFirst())
        }
    }

    while !left.isEmpty {
        sorted.append(left.removeFirst())
    }

    while !right.isEmpty {
        sorted.append(right.removeFirst())
    }
    
    return sorted
}

// Tests

// Already Sorted
assert(mergeSort_theSwiftish([Int]()).isSorted())
assert(mergeSort_theSwiftish([7]).isSorted())
assert(mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(mergeSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `guard`, `count`, nested function, `while`, `isEmpty`, subcripting, `+=`, and `removeFirst`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func mergerSort_theSwiftest(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func merge(left: [Int], _ right: [Int]) -> [Int] {

        var left = left
        var right = right

        var merged: [Int] = []

        while !left.isEmpty && !right.isEmpty {

            if left[0] < right[0] {
                merged += [left.removeFirst()]
            } else {
                merged += [right.removeFirst()]
            }
        }

        if !left.isEmpty {
            merged += left
        }

        if !right.isEmpty {
            merged += right
        }

        return merged
    }

    let pivot = array.count / 2

    let left = mergerSort_theSwiftest(Array(array[0..<pivot]))
    let right = mergerSort_theSwiftest(Array(array[pivot..<array.count]))

    return merge(left, right)
}

// Tests

// Already Sorted
assert(mergerSort_theSwiftest([Int]()).isSorted())
assert(mergerSort_theSwiftest([7]).isSorted())
assert(mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(mergerSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `guard`, `count`, nested function, `while`, `isEmpty`, subcripting, `+=`, `removeFirst`, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func mergeSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    func merge(left: [T], _ right: [T]) -> [T] {

        var left = left
        var right = right

        var merged: [T] = []

        while !left.isEmpty && !right.isEmpty {

            if left[0] < right[0] {
                merged += [left.removeFirst()]
            } else {
                merged += [right.removeFirst()]
            }
        }

        if !left.isEmpty {
            merged += left
        }

        if !right.isEmpty {
            merged += right
        }

        return merged
    }

    let pivot = array.count / 2

    let left = mergeSort_theGeneric(Array(array[0..<pivot]))
    let right = mergeSort_theGeneric(Array(array[pivot..<array.count]))
    
    return merge(left, right)
}

// Tests

// Already Sorted
assert(mergeSort_theGeneric([Int]()).isSorted())
assert(mergeSort_theGeneric([7]).isSorted())
assert(mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(mergeSort_theGeneric([String]()).isSorted())
assert(mergeSort_theGeneric(["a"]).isSorted())
assert(mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(mergeSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(mergeSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)