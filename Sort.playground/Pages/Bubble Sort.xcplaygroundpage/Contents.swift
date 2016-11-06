//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//: ## Bubble Sort
//: ---
//:
//: ### About
//:
//: - Pass through the array repeatedly comparing each pair of adjacent elements
//: - At each pass, swap these elements if they happen to be in the wrong order
//: - When swaps are no more, initially unsorted elements will be in the right order
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Adaptative, as it benefits from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
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

func bubbleSort_theClassic(_ array: [Int]) -> [Int] {

    // take in an array that is considered unsorted and make a copy of it
    var array = array

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pass through the array, but it needs only as many passes as the number of swaps needed
    for i in 0 ..< array.count - 1 {

        // define a flag to keep track of swaps, no swaps means the array is sorted
        var hasSwapped = false

        // compare each pair of adjacent elements, except to already sorted elements
        for j in 0 ..< array.count - i - 1 {

            // check if elements are in the wrong order
            if array[j] > array[j + 1] {

                // perform the swap if they do
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

    // return the sorted array
    return array
}

// Sorted
bubbleSort_theClassic([Int]()) == [Int]()
bubbleSort_theClassic([7]) == [7]
bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
bubbleSort_theClassic([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func bubbleSort_theSwiftish(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped: Bool
    var count = array.count

    repeat {
        hasSwapped = false

        for i in 0 ..< count - 1 where array[i] > array[i + 1] {
            
            (array[i], array[i + 1]) = (array[i + 1], array[i])
            hasSwapped = true
        }

        count -= 1

    } while hasSwapped

    return array
}

// Sorted
bubbleSort_theSwiftish([Int]()) == [Int]()
bubbleSort_theSwiftish([7]) == [7]
bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
bubbleSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful features of the language yet
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func bubbleSort_theSwiftest(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped = false

    for i in 0 ..< array.count - 1 where array[i] > array[i + 1] {
        
        swap(&array[i], &array[i + 1])
        hasSwapped = true
    }

    return !hasSwapped ? array : bubbleSort_theSwiftest(array)
}

// Sorted
bubbleSort_theSwiftest([Int]()) == [Int]()
bubbleSort_theSwiftest([7]) == [7]
bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
bubbleSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func bubbleSort_theGeneric<T: Comparable>(_ array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped = false

    for i in 0 ..< array.count - 1 where array[i] > array[i + 1] {
        
        swap(&array[i], &array[i + 1])
        hasSwapped = true
    }

    return !hasSwapped ? array : bubbleSort_theGeneric(array)
}

// Sorted
bubbleSort_theGeneric([Int]()) == [Int]()
bubbleSort_theGeneric([7]) == [7]
bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

bubbleSort_theGeneric([String]()) == [String]()
bubbleSort_theGeneric(["a"]) == ["a"]
bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"]) == ["a", "a", "b", "c", "d", "e"]

// Nearly Sorted
bubbleSort_theGeneric([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theGeneric(["a", "b", "a", "c", "e", "d"]) == ["a", "a", "b", "c", "d", "e"]

// Reversed
bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].reversed()) == ["a", "a", "b", "c", "d", "e"]

// Shuffled
bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffled()) == ["a", "a", "b", "c", "d", "e"]

//: ---
//:
/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func bubbleSort_theFunctional(_ array: [Int]) -> [Int] {

    func isSorted(_ array: [Int]) -> Bool {

        guard array.count > 1 else {
            return true
        }

        let (first, second, rest) = (array[0], array[1], array.dropFirst())

        return first <= second ? isSorted(Array(rest)) : false
    }

    func bubble(_ array: [Int]) -> [Int] {

        guard array.count > 1 else {
            return array
        }

        let (first, second, rest) = (array[0], array[1], Array(array.dropFirst(2)))

        return [min(first, second)] + bubble([max(first, second)] + rest)
    }

    return isSorted(array) ? array : bubbleSort_theFunctional(bubble(array))
}

// Sorted
bubbleSort_theFunctional([Int]()) == [Int]()
bubbleSort_theFunctional([7]) == [7]
bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
bubbleSort_theFunctional([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
bubbleSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

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

func bubbleSort_theBonus<T>(_ array: [T], by areInIncreasingOrder: (T, T) -> Bool) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var hasSwapped: Bool
    var count = array.count

    repeat {
        hasSwapped = false

        for i in 0 ..< count - 1 where areInIncreasingOrder(array[i + 1], array[i]) {
            
            (array[i], array[i + 1]) = (array[i + 1], array[i])
            hasSwapped = true
        }

        count -= 1

    } while hasSwapped

    return array
}

// Sorted
bubbleSort_theBonus([Int](), by: <) == [Int]()
bubbleSort_theBonus([Int](), by: >) == [Int]()
bubbleSort_theBonus([7], by: <) == [7]
bubbleSort_theBonus([7], by: >) == [7]
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: <) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()

bubbleSort_theBonus([String](), by: <) == [String]()
bubbleSort_theBonus([String](), by: >) == [String]()
bubbleSort_theBonus(["a"], by: <) == ["a"]
bubbleSort_theBonus(["a"], by: >) == ["a"]
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"], by: <) == ["a", "a", "b", "c", "d", "e"]
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Nearly Sorted
bubbleSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: <) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
bubbleSort_theBonus(["a", "b", "a", "c", "e", "d"], by: <) == ["a", "a", "b", "c", "d", "e"]
bubbleSort_theBonus(["a", "b", "a", "c", "e", "d"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Reversed
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: <) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: <) == ["a", "a", "b", "c", "d", "e"]
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Shuffled
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: <) == [1, 1, 2, 3, 5, 8, 13]
bubbleSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: <) == ["a", "a", "b", "c", "d", "e"]
bubbleSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

//: ---
//:
//: [Table of Contents](Table%20of%20Contents) | [Next](@next)
