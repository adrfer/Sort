//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Insertion Sort
//: ----
//:
//: ### About
//:
//: - Split the input array in two portions, one sorted and one unsorted
//: - Initially, the sorted portion is empty, while the unsorted one contains all the elements
//: - Find the apropriate insert position by comparing each element of the unsorted portion to sorted elements
//: - Shift already sorted elements as necessary to make room for the next sorted element
//: - Eventually, the unsorted portion becomes empty and the array sorted
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
/// This version showcases early exit `if`, `count`, `for-in`, `..<`, `-=`, and subcripting
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order
///
/// - Todo: Remove code annotations

func insertionSort_theClassic(_ array: [Int]) -> [Int] {

    // take in an array that is considered unsorted and make a copy of it
    var array = array

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pass through the elements of the unsorted portion, except the first which is considered sorted
    for i in 1 ..< array.count {

        // keep track of the unsorted element
        let element = array[i]
        var j = i

        // pass through the elements of the sorted portion to find the appropriate insert position
        while j > 0 && element < array [j - 1] {

            // shift each sorted element to make room for the unsorted one
            array[j] = array[j - 1]

            // update the index where the unsorted element will be inserted
            j -= 1
        }

        // insert the unsorted element into the sorted portion of the array
        array[j] = element
    }

    // return sorted array
    return array
}

// Tests

// Already Sorted
insertionSort_theClassic([Int]()) == [Int]()
insertionSort_theClassic([7]) == [7]
insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
insertionSort_theClassic([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
insertionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `guard`, `count`, `for-in`, `..<`, `while`, `-=`, subcripting, and `swap`
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func insertionSort_theSwiftish(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 1 ..< array.count {

        var j = i

        while j > 0 && array[j] < array[j - 1] {

            swap(&array[j], &array[j - 1])
            j -= 1
        }
    }

    return array
}

// Tests

// Already Sorted
insertionSort_theSwiftish([Int]()) == [Int]()
insertionSort_theSwiftish([7]) == [7]
insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
insertionSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
insertionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `guard`, `count`, `for-in`, `..<`, `remove`, subcripting, and `insert`
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func insertionSort_theSwiftest(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 1 ..< array.count {

        let element = array.remove(at: i)
        var j = i

        while j > 0 && element < array[j - 1] {
            j -= 1
        }

        array.insert(element, at: j)
    }

    return array
}

// Tests

// Already Sorted
insertionSort_theSwiftest([Int]()) == [Int]()
insertionSort_theSwiftest([7]) == [7]
insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
insertionSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
insertionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `guard`, `count`, `for-in`, `..<`, `remove`, subcripting, `insert`, and generics
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func insertionSort_theGeneric<T: Comparable>(_ array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 1 ..< array.count {

        let element = array.remove(at: i)
        var j = i

        while j > 0 && element < array[j - 1] {
            j -= 1
        }

        array.insert(element, at: j)
    }

    return array
}

// Tests

// Already Sorted
insertionSort_theGeneric([Int]()) == [Int]()
insertionSort_theGeneric([7]) == [7]
insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

insertionSort_theGeneric([String]()) == [String]()
insertionSort_theGeneric(["a"]) == ["a"]
insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"]) == ["a", "a", "b", "c", "d", "e"]

// Nearly Sorted
insertionSort_theGeneric([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theGeneric(["a", "b", "a", "c", "e", "d"]) == ["a", "a", "b", "c", "d", "e"]

// Reversed
insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"].reversed()) == ["a", "a", "b", "c", "d", "e"]

// Shuffled
insertionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffled()) == ["a", "a", "b", "c", "d", "e"]


/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// This version showcases `guard`, `count`, nested function, tuple decomposition, `isEmpty`, `dropFirst`, `+`, and `?:`
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func insertionSort_theFunctional(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func insert(_ first: Int, _ rest: [Int]) -> [Int] {

        guard !rest.isEmpty else {
            return [first]
        }

        let (newFirst, newRest) = (rest.first!, Array(rest.dropFirst()))

        return first < newFirst ? [first, newFirst] + newRest : [newFirst] + insert(first, newRest)
    }

    let (first, rest) = (array.first!, Array(array.dropFirst()))

    return insert(first, insertionSort_theFunctional(rest))
}

// Tests

// Already Sorted
insertionSort_theFunctional([Int]()) == [Int]()
insertionSort_theFunctional([7]) == [7]
insertionSort_theFunctional([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
insertionSort_theFunctional([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
insertionSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
insertionSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]


/// The Bonus Algorithm
///
/// A generic version based on The Swift-ish Algorithm that takes a strict weak ordering closure/predicate
///
/// This version showcases `guard`, `count`, `for-in`, `..<`, `while`, `-=`, subcripting, `swap`, `@noescape`, and generics
///
/// - Parameters:
///
///   - array: The `array` to be sorted
///   - isOrderedBefore: The predicate used to establish the order of the elements
///
/// - Returns: A new array with elements sorted based on the `isOrderedBefore` predicate

func insertionSort_theBonus<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 1 ..< array.count {

        var j = i

        while j > 0 && isOrderedBefore(array[j], array[j - 1]) {

            swap(&array[j], &array[j - 1])
            j -= 1
        }
    }

    return array
}

// Tests

// Already Sorted
insertionSort_theBonus([Int](), <) == [Int]()
insertionSort_theBonus([Int](), >) == [Int]()
insertionSort_theBonus([7], <) == [7]
insertionSort_theBonus([7], >) == [7]
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13], <) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13], >) == [1, 1, 2, 3, 5, 8, 13].reversed()

insertionSort_theBonus([String](), <) == [String]()
insertionSort_theBonus([String](), >) == [String]()
insertionSort_theBonus(["a"], <) == ["a"]
insertionSort_theBonus(["a"], >) == ["a"]
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"], <) == ["a", "a", "b", "c", "d", "e"]
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"], >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Nearly Sorted
insertionSort_theBonus([1, 2, 1, 3, 5, 13, 8], <) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theBonus([1, 2, 1, 3, 5, 13, 8], >) == [1, 1, 2, 3, 5, 8, 13].reversed()
insertionSort_theBonus(["a", "b", "a", "c", "e", "d"], <) == ["a", "a", "b", "c", "d", "e"]
insertionSort_theBonus(["a", "b", "a", "c", "e", "d"], >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Reversed
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), <) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), >) == [1, 1, 2, 3, 5, 8, 13].reversed()
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), <) == ["a", "a", "b", "c", "d", "e"]
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Shuffled
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), <) == [1, 1, 2, 3, 5, 8, 13]
insertionSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), >) == [1, 1, 2, 3, 5, 8, 13].reversed()
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), <) == ["a", "a", "b", "c", "d", "e"]
insertionSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), >) == ["a", "a", "b", "c", "d", "e"].reversed()
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
