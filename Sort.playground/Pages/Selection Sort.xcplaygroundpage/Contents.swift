//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//: ## Selection Sort
//: ---
//:
//: ### About
//:
//: - Split the input array in two portions, one sorted and one unsorted
//: - Initially, the sorted portion is empty, while the unsorted one contains all the elements
//: - Find the smallest element in the unsorted portion and move it to the end of the sorted portion
//: - Eventually, the unsorted portion becomes empty and the array sorted
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Not adaptative, as it does not benefit from the presortedness in the input array
//: - Not stable, as it does not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n²)_ and _O(n²)_
//:
//: ---
//:
/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func selectionSort_theClassic(_ array: [Int]) -> [Int] {

    // take in an array that is considered unsorted and make a copy of it
    var array = array

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pass through the array, but it needs only as many passes as the number of swaps required
    for i in 0 ..< array.count - 1 {

        // consider the first element of the unsorted portion to be the smallest
        var indexOfTheSmallestElement = i

        // pass through the unsorted portion to find the smallest unsorted element
        for j in (indexOfTheSmallestElement + 1) ..< array.count {

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

    // return the sorted array
    return array
}

// Sorted
selectionSort_theClassic([Int]()) == [Int]()
selectionSort_theClassic([7]) == [7]
selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
selectionSort_theClassic([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func selectionSort_theSwiftish(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 0 ..< array.count - 1 {

        var indexOfMinElement = i

        for j in (indexOfMinElement + 1) ..< array.count where array[j] < array[indexOfMinElement] {
            indexOfMinElement = j
        }

        if i == indexOfMinElement {
            continue
        }

        swap(&array[i], &array[indexOfMinElement])
    }

    return array
}

// Sorted
selectionSort_theSwiftish([Int]()) == [Int]()
selectionSort_theSwiftish([7]) == [7]
selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
selectionSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful features of the language yet
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func selectionSort_theSwiftest(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for index in 0 ..< array.count {

        let newArray = array[0 ..< array.count - index]

        if let minElement = newArray.min(), let indexOfMinElement = newArray.index(of: minElement) {

            array.remove(at: indexOfMinElement)
            array.append(minElement)
        }
    }

    return array
}

// Sorted
selectionSort_theSwiftest([Int]()) == [Int]()
selectionSort_theSwiftest([7]) == [7]
selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
selectionSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func selectionSort_theGeneric<T: Comparable>(_ array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for index in 0 ..< array.count {

        let newArray = array[0 ..< array.count - index]

        if let minElement = newArray.min(), let indexOfMinElement = newArray.index(of: minElement) {

            array.remove(at: indexOfMinElement)
            array.append(minElement)
        }
    }

    return array
}

// Sorted
selectionSort_theGeneric([Int]()) == [Int]()
selectionSort_theGeneric([7]) == [7]
selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

selectionSort_theGeneric([String]()) == [String]()
selectionSort_theGeneric(["a"]) == ["a"]
selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"]) == ["a", "a", "b", "c", "d", "e"]

// Nearly Sorted
selectionSort_theGeneric([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theGeneric(["a", "b", "a", "c", "e", "d"]) == ["a", "a", "b", "c", "d", "e"]

// Reversed
selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].reversed()) == ["a", "a", "b", "c", "d", "e"]

// Shuffled
selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffled()) == ["a", "a", "b", "c", "d", "e"]

//: ---
//:
/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func selectionSort_theFunctional(_ array: [Int]) -> [Int] {

    guard array.count > 1, let minElement = array.min() else {
        return array
    }

    let indexOfMinElement = array.index(of: minElement)!
    let rest = array.enumerated()
        .filter({ index, _ in index != indexOfMinElement })
        .map({ _, element in element })

    return [minElement] + selectionSort_theFunctional(rest)
}

// Sorted
selectionSort_theFunctional([Int]()) == [Int]()
selectionSort_theFunctional([7]) == [7]
selectionSort_theFunctional([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
selectionSort_theFunctional([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
selectionSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
selectionSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Bonus Algorithm
///
/// A generic version based on the swift-ish that takes a strict weak ordering predicate
///
/// - Parameters:
///
///   - array: The `array` to be sorted
///   - areInIncreasingOrder: The predicate used to establish the order of the elements
///
/// - Returns: A new array with elements sorted based on the `areInIncreasingOrder` predicate

func selectionSort_theBonus<T>(_ array: [T], by areInIncreasingOrder: (T, T) -> Bool) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 0 ..< array.count - 1 {

        var indexOfMinElement = i

        for j in (indexOfMinElement + 1) ..< array.count where areInIncreasingOrder(array[j], array[indexOfMinElement]) {
            indexOfMinElement = j
        }

        if i == indexOfMinElement {
            continue
        }

        swap(&array[i], &array[indexOfMinElement])
    }

    return array
}

// Sorted
selectionSort_theBonus([Int](), by: <) == [Int]()
selectionSort_theBonus([Int](), by: >) == [Int]()
selectionSort_theBonus([7], by: <) == [7]
selectionSort_theBonus([7], by: >) == [7]
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: <) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()

selectionSort_theBonus([String](), by: <) == [String]()
selectionSort_theBonus([String](), by: >) == [String]()
selectionSort_theBonus(["a"], by: <) == ["a"]
selectionSort_theBonus(["a"], by: >) == ["a"]
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"], by: <) == ["a", "a", "b", "c", "d", "e"]
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Nearly Sorted
selectionSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: <) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
selectionSort_theBonus(["a", "b", "a", "c", "e", "d"], by: <) == ["a", "a", "b", "c", "d", "e"]
selectionSort_theBonus(["a", "b", "a", "c", "e", "d"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Reversed
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: <) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: <) == ["a", "a", "b", "c", "d", "e"]
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Shuffled
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: <) == [1, 1, 2, 3, 5, 8, 13]
selectionSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: <) == ["a", "a", "b", "c", "d", "e"]
selectionSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

//: ---
//:
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous)
