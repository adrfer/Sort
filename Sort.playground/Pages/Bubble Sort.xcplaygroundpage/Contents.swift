//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Bubble Sort
//: ----
//:
//: ### About
//:
//: - Pass through the array repeatedly comparing each pair of adjacent elements
//: - At each pass, swap these elements if they happen to be in the wrong order
//: - Wnen there are no more swaps, unsorted elements will have bubbled up to their appropiated positions
//:
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Adaptative, as it benefits from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n²)_ and _O(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases early exit `if`, `count`, `for-in`, `..<`, subcripting, tuple swapping, and `break`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order
///
/// - todo: Remove code annotations

func bubbleSort_theClassic(array: [Int]) -> [Int] {

    // take in an array that is considered unsorted and make a copy of it
    var array = array

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pass through the array, but it needs only as many passes as the number of swaps required
    for i in 0..<array.count - 1 {

        // define a flag keep track if the array is already sorted
        var hasSwapped = false

        // compare each pair of adjacent elements, except to already sorted elements on subsequent passes
        for j in 0..<array.count - i - 1 {

            // check is elements are in the wrong order
            if array[j] > array[j + 1] {

                // perform a swap
                (array[j], array[j + 1]) = (array[j + 1], array[j])

                // flag if array is not properly sorted yet
                hasSwapped = true
            }
        }

        // check if a swap ocurred, if not, the array is then sorted
        if !hasSwapped {
            break
        }
    }

    // return sorted array
    return array
}

// Tests

// Already Sorted
assert(bubbleSort_theClassic([Int]()).isSorted())
assert(bubbleSort_theClassic([7]).isSorted())
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `guard`, `count`, `repeat-while`, `for-in-where`, subcripting, `..<`, and tuple swapping
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func bubbleSort_theSwiftish(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped: Bool
    var count = array.count

    repeat {

        hasSwapped = false

        for i in 0..<count - 1 where array[i] > array[i + 1] {
            (array[i], array[i + 1]) = (array[i + 1], array[i])
            hasSwapped = true
        }

        count -= 1
        
    } while hasSwapped

    return array
}

// Tests

// Already Sorted
assert(bubbleSort_theSwiftish([Int]()).isSorted())
assert(bubbleSort_theSwiftish([7]).isSorted())
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `guard`, `count`, `for-in-where`, `..<`, subcripting, `swap`, `?:`, and `dropFirst`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func bubbleSort_theSwiftest(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped = false

    for i in 0..<array.count - 1 where array[i] > array[i + 1] {
        swap(&array[i], &array[i + 1])
        hasSwapped = true
    }

    return !hasSwapped ? array : bubbleSort_theSwiftest(Array(array.dropFirst()))
}

// Tests

// Already Sorted
assert(bubbleSort_theSwiftest([Int]()).isSorted())
assert(bubbleSort_theSwiftest([7]).isSorted())
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `guard`, `count`, `for-in-where`, `..<`, subcripting, `swap`, `?:`, `dropFirst`, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func bubbleSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    var array = array
    
    guard array.count > 1 else {
        return array
    }

    var hasSwapped = false

    for i in 0..<array.count - 1 where array[i] > array[i + 1] {
        swap(&array[i], &array[i + 1])
        hasSwapped = true
    }

    return !hasSwapped ? array : bubbleSort_theGeneric(Array(array.dropFirst()))
}

// Tests

// Already Sorted
assert(bubbleSort_theGeneric([Int]()).isSorted())
assert(bubbleSort_theGeneric([7]).isSorted())
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(bubbleSort_theGeneric([String]()).isSorted())
assert(bubbleSort_theGeneric(["a"]).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(bubbleSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(bubbleSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())


/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// This version showcases `guard`, `count`, nested function, tuple decomposition, subscripting, `dropFirst`, `min`, `max`, and `?:`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: A new array with elements sorted in ascending order

func bubbleSort_theFunctional(array: [Int]) -> [Int] {

    func isSorted(array: [Int]) -> Bool {

        guard array.count > 1 else {
            return true
        }

        let (first, second, rest) = (array[0], array[1], array.dropFirst())

        return first <= second ? isSorted(Array(rest)) : false
    }

    func bubble(array: [Int]) -> [Int] {

        guard array.count > 1 else {
            return array
        }

        let (first, second, rest) = (array[0], array[1], Array(array.dropFirst(2)))

        return [min(first, second)] + bubble([max(first, second)] + rest)
    }

    return isSorted(array) ? array : bubbleSort_theFunctional(bubble(array))
}

// Tests

// Already Sorted
assert(bubbleSort_theFunctional([Int]()).isSorted())
assert(bubbleSort_theFunctional([7]).isSorted())
assert(bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theFunctional([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)