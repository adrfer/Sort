//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Quick Sort
//: ----
//:
//: ### About
//:
//: - Rearrange all elements of the array in three partitions by choosing a pivot element
//: - Elements less than the pivot go into the first partition, elements equal into the second, and elements greater than into the third
//: - Sort each partition recursively, except the one where elements are equal to the pivot
//: - Join all partitions, the first partition, the second, and the third respectively
//:
//:
//: ### Properties
//:
//: - Is a divide and conquer algorithm, so computation can parallelized
//: - Not simple, both concept and implementation are relatively complex
//: - Not adaptative, as it does not benefit from the presortedness in the input array
//: - Not stable, as it doe not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases early exit `if`, `count`, `pick`, `for-in`, `..<`, subcripting, `append`tuple swapping, and `break`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order
///
/// - todo: Remove code annotations

func quickSort_theClassic(array: [Int]) -> [Int] {

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pick the pivot element randomly
    let pivot = array.pick()

    // define the partitions soon to be populated
    var lessThan: [Int] = [], equal: [Int] = [], greaterThan: [Int] = []

    // pass through the array rearranging all elements into their corresponding partitions
    for i in 0..<array.count {

        // append to the less-than partition elements smaller than the pivot
        if array[i] < pivot {

            lessThan.append(array[i])

        // append to the greater-than partition elements larger than the pivot
        } else if array[i] > pivot {

            greaterThan.append(array[i])

        // append to the equal partition elements equal to the pivot
        } else {

            equal.append(array[i])
        }
    }

    // sort recursively all partitions but the equal one, and join all of them in the end
    return quickSort_theClassic(lessThan) + equal + quickSort_theClassic(greaterThan)
}

// Tests

// Already Sorted
assert(quickSort_theClassic([Int]()).isSorted())
assert(quickSort_theClassic([7]).isSorted())
assert(quickSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(quickSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(quickSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(quickSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `guard`, `count`, `pick`, `for-in`, `switch`, `+=`, and `+`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func quickSort_theSwiftish(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.pick()
    
    var lessThan: [Int] = [], equal: [Int] = [], greaterThan: [Int] = []

    for element in array {

        switch element {
        case let element where element < pivot: lessThan += [element]
        case let element where element > pivot: greaterThan += [element]
        default: equal += [element]

        }
    }

    return quickSort_theSwiftish(lessThan) + equal + quickSort_theSwiftish(greaterThan)
}

// Tests

// Already Sorted
assert(quickSort_theSwiftish([Int]()).isSorted())
assert(quickSort_theSwiftish([7]).isSorted())
assert(quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(quickSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `guard`, `count`, `removeFirst`, `filter, and `+`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func quickSort_theSwiftest(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    let pivot = array.removeFirst()

    let lessThan = array.filter {
        $0 < pivot
    }

    let greaterThanOrEqual = array.filter {
        $0 >= pivot
    }

    return quickSort_theSwiftest(lessThan) + [pivot] + quickSort_theSwiftest(greaterThanOrEqual)
}

// Tests

// Already Sorted
assert(quickSort_theSwiftest([Int]()).isSorted())
assert(quickSort_theSwiftest([7]).isSorted())
assert(quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(quickSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `guard`, `count`, `removeFirst`, `filter, and `+`, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func quickSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    let pivot = array.removeFirst()

    let lessThan = array.filter {
        $0 < pivot
    }

    let greaterThanOrEqual = array.filter {
        $0 >= pivot
    }

    return quickSort_theGeneric(lessThan) + [pivot] + quickSort_theGeneric(greaterThanOrEqual)
}

// Tests

// Already Sorted
assert(quickSort_theGeneric([Int]()).isSorted())
assert(quickSort_theGeneric([7]).isSorted())
assert(quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(quickSort_theGeneric([String]()).isSorted())
assert(quickSort_theGeneric(["a"]).isSorted())
assert(quickSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(quickSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(quickSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(quickSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(quickSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
