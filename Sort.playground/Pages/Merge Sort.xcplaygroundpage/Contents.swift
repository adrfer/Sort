//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//: ## Merge Sort
//: ---
//:
//: ### About
//:
//: - Recursively split the input array in two halves
//: - Sort the elements of both halves of the array
//: - Merge the two sorted halves
//:
//: ### Properties
//:
//: - Is a divide and conquer algorithm, so computation can parallelized
//: - Not simple, both concept and implementation are relatively complex
//: - Not adaptative, as it does not benefit from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n-log-n)_
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

func mergeSort_theClassic(_ array: [Int]) -> [Int] {

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // find the mid point in order to split the input array into two halves
    let pivot = array.count / 2

    // set the left half of the array
    var left = [Int]()

    for index in 0 ..< pivot {
        left.append(array[index])
    }

    // set the right half of the array
    var right = [Int]()

    for index in pivot ..< array.count {
        right.append(array[index])
    }

    // sort both halves recursively
    left = mergeSort_theClassic(left)
    right = mergeSort_theClassic(right)

    // create an array to be populated with sorted elements
    var sorted = [Int]()

    // set initial indices, start by comparing the first element of each half
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

    // return the sorted array
    return sorted
}

// Sorted
mergeSort_theClassic([Int]()) == [Int]()
mergeSort_theClassic([7]) == [7]
mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
mergeSort_theClassic([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
mergeSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func mergeSort_theSwiftish(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.count / 2

    var left = mergeSort_theSwiftish(Array(array[0 ..< pivot]))
    var right = mergeSort_theSwiftish(Array(array[pivot ..< array.count]))

    var sorted = [Int]()

    while !left.isEmpty && !right.isEmpty {

        if left.first! < right.first! {
            sorted.append(left.remove(at: 0))
        } else {
            sorted.append(right.remove(at: 0))
        }
    }

    while !left.isEmpty {
        sorted.append(left.remove(at: 0))
    }

    while !right.isEmpty {
        sorted.append(right.remove(at: 0))
    }

    return sorted
}

// Sorted
mergeSort_theSwiftish([Int]()) == [Int]()
mergeSort_theSwiftish([7]) == [7]
mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
mergeSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
mergeSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful features of the language yet
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func mergerSort_theSwiftest(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func merge(_ left: [Int], _ right: [Int]) -> [Int] {

        var left = left
        var right = right

        var merged = [Int]()

        while !left.isEmpty && !right.isEmpty {
            merged += left.first! < right.first! ? [left.remove(at: 0)] : [right.remove(at: 0)]
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

    let left = mergerSort_theSwiftest(Array(array[0 ..< pivot]))
    let right = mergerSort_theSwiftest(Array(array[pivot ..< array.count]))

    return merge(left, right)
}

// Sorted
mergerSort_theSwiftest([Int]()) == [Int]()
mergerSort_theSwiftest([7]) == [7]
mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
mergerSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
mergerSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func mergeSort_theGeneric<T: Comparable>(_ array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    func merge(_ left: [T], _ right: [T]) -> [T] {

        var left = left
        var right = right

        var merged = [T]()

        while !left.isEmpty && !right.isEmpty {
            merged += left.first! < right.first! ? [left.remove(at: 0)] : [right.remove(at: 0)]
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

    let left = mergeSort_theGeneric(Array(array[0 ..< pivot]))
    let right = mergeSort_theGeneric(Array(array[pivot ..< array.count]))

    return merge(left, right)
}

// Sorted
mergeSort_theGeneric([Int]()) == [Int]()
mergeSort_theGeneric([7]) == [7]
mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

mergeSort_theGeneric([String]()) == [String]()
mergeSort_theGeneric(["a"]) == ["a"]
mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"]) == ["a", "a", "b", "c", "d", "e"]

// Nearly Sorted
mergeSort_theGeneric([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theGeneric(["a", "b", "a", "c", "e", "d"]) == ["a", "a", "b", "c", "d", "e"]

// Reversed
mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"].reversed()) == ["a", "a", "b", "c", "d", "e"]

// Shuffled
mergeSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffled()) == ["a", "a", "b", "c", "d", "e"]

//: ---
//:
/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func mergerSort_theFunctional(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func merge(_ left: [Int], _ right: [Int]) -> [Int] {

        guard !left.isEmpty else {
            return right
        }

        guard !right.isEmpty else {
            return left
        }

        if left.first! < right.first! {
            return [left.first!] + merge(Array(left[1 ..< left.count]), right)
        } else {
            return [right.first!] + merge(left, Array(right[1 ..< right.count]))
        }
    }

    let pivot = array.count / 2

    let left = mergerSort_theSwiftest(Array(array[0 ..< pivot]))
    let right = mergerSort_theSwiftest(Array(array[pivot ..< array.count]))

    return merge(left, right)
}

// Sorted
mergerSort_theFunctional([Int]()) == [Int]()
mergerSort_theFunctional([7]) == [7]
mergerSort_theFunctional([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
mergerSort_theFunctional([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
mergerSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
mergerSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

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

func mergeSort_theBonus<T>(_ array: [T], by areInIncreasingOrder: (T, T) -> Bool) -> [T] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.count / 2

    var left = mergeSort_theBonus(Array(array[0 ..< pivot]), by: areInIncreasingOrder)
    var right = mergeSort_theBonus(Array(array[pivot ..< array.count]), by: areInIncreasingOrder)

    var sorted = [T]()

    while !left.isEmpty && !right.isEmpty {

        if areInIncreasingOrder(left.first!, right.first!) {
            sorted.append(left.remove(at: 0))
        } else {
            sorted.append(right.remove(at: 0))
        }
    }

    while !left.isEmpty {
        sorted.append(left.remove(at: 0))
    }

    while !right.isEmpty {
        sorted.append(right.remove(at: 0))
    }

    return sorted
}

// Sorted
mergeSort_theBonus([Int](), by: <) == [Int]()
mergeSort_theBonus([Int](), by: >) == [Int]()
mergeSort_theBonus([7], by: <) == [7]
mergeSort_theBonus([7], by: >) == [7]
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: <) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()

mergeSort_theBonus([String](), by: <) == [String]()
mergeSort_theBonus([String](), by: >) == [String]()
mergeSort_theBonus(["a"], by: <) == ["a"]
mergeSort_theBonus(["a"], by: >) == ["a"]
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"], by: <) == ["a", "a", "b", "c", "d", "e"]
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Nearly Sorted
mergeSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: <) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
mergeSort_theBonus(["a", "b", "a", "c", "e", "d"], by: <) == ["a", "a", "b", "c", "d", "e"]
mergeSort_theBonus(["a", "b", "a", "c", "e", "d"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Reversed
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: <) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: <) == ["a", "a", "b", "c", "d", "e"]
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Shuffled
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: <) == [1, 1, 2, 3, 5, 8, 13]
mergeSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: <) == ["a", "a", "b", "c", "d", "e"]
mergeSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

//: ---
//:
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
