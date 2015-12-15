//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Insertion Sort
//: ----
//:
//: ### About
//:
//: - Based on the idea that the input array is divided into two portions, one sorted and on unsorted
//: - Initially, the sorted portion is empty, while the unsorted portion contains all the elements
//: - Each element from the unsorted portion is compared to sorted elements, until an insertion location is determined
//: - Already sorted elements are shifted as necessary to make room for the unsorted element
//: - One by one, unsorted elements are inserted into their appropriate positions in the sorted portion of the array
//: - Eventually, the unsorted portion becomes empty and the array sorted in-place
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    for i = 1 to n
//:
//:      unsorted element = array[i]
//:
//:      insertion position j = i
//:
//:      while j > 0 and element < array[j - 1]
//:
//:        array[j] = array[j - 1]
//:
//:        j = j - 1
//:
//:      array[j] = element
//:
//:    return sorted array
//:
//:
//: ### Optimizations
//:
//: - Early return in case the input array is empty or contains a single element, for it is sorted
//:
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Adaptative, as it benefits from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
//: - Online, as it can be used to sort an input array as it receives it
//: - The best and worst case runtime are respectively of complexity _Ω(n)_ and _O(n²)_


/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases `if` early exit, and old-fashioned `for` and `while` loops
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func insertionSort_theClassic(array: [Int]) -> [Int] {

    // takes in an array that is considered unsorted and makes it mutable so it can be sorted in-place
    var array = array

    // returns the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // iterates through the elements of the unsorted portion of the array, except the first, which is considered sorted
    for var i = 1; i < array.count; i += 1 {

        // keeps track of the unsorted element
        let element = array[i]
        var j = i

        // iterates through the sorted portion of the array to find the appropriate position to insert the unsorted element
        while j > 0 && element < array [j - 1] {

            // shifts each sorted element to make room for the unsorted element
            array[j] = array[j - 1]

            // updates the index where the unsorted element will be inserted
            j -= 1
        }

        // inserts the unsorted element into the sorted portion of the array
        array[j] = element
    }

    return array
}

// Already Sorted
assert(insertionSort_theClassic([Int]()).isSorted())
assert(insertionSort_theClassic([7]).isSorted())
assert(insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(insertionSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `var` argument, `guard`, `for-in`, and `swap`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func insertionSort_theSwiftish(var array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    for i in 1..<array.count {
        var j = i

        while j > 0 && array[j] < array[j - 1] {
            swap(&array[j], &array[j - 1])
            j -= 1
        }
    }
    
    return array
}

// Already Sorted
assert(insertionSort_theSwiftish([Int]()).isSorted())
assert(insertionSort_theSwiftish([7]).isSorted())
assert(insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(insertionSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `var` argument, `guard`, `for-in`, and native methods from
/// the standard library such as `removeAtIndex` and `insert`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func insertionSort_theSwiftest(var array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    for i in 1..<array.count {

        let element = array.removeAtIndex(i)
        var j = i

        while j > 0 && element < array[j - 1] {
            j -= 1
        }

        array.insert(element, atIndex: j)
    }

    return array
}

// Already Sorted
assert(insertionSort_theSwiftest([Int]()).isSorted())
assert(insertionSort_theSwiftest([7]).isSorted())
assert(insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(insertionSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `var` argument, `guard`, `for-in`, native methods from
/// the standard library such as `removeAtIndex` and `insert`, and generics
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func insertionSort_theGeneric<T: Comparable>(var array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    for i in 1..<array.count {

        let element = array.removeAtIndex(i)
        var j = i

        while j > 0 && element < array[j - 1] {
            j -= 1
        }

        array.insert(element, atIndex: j)
    }

    return array
}

// Already Sorted
assert(insertionSort_theGeneric([Int]()).isSorted())
assert(insertionSort_theGeneric([7]).isSorted())
assert(insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(insertionSort_theGeneric([String]()).isSorted())
assert(insertionSort_theGeneric(["a"]).isSorted())
assert(insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(insertionSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(insertionSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
