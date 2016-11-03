//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//: ## Quick Sort
//: ---
//:
//: ### About
//:
//: - Rearrange all elements of the array in three partitions by choosing a pivot element
//: - Elements less than the pivot go into the first partition, elements equal into the second, and elements greater than into the third
//: - Sort each partition recursively, except the one where elements are equal to the pivot
//: - Join all partitions, the first partition, the second, and the third respectively
//:
//: ### Properties
//:
//: - Is a divide and conquer algorithm, so computation can parallelized
//: - Not simple, both concept and implementation are relatively complex
//: - Not adaptative, as it does not benefit from the presortedness in the input array
//: - Not stable, as it doe not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n²)_
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

func quickSort_theClassic(_ array: [Int]) -> [Int] {

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // pick the pivot element randomly
    let pivot = array.sampled()

    // define the partitions soon to be populated
    var lessThan = [Int](), equal = [Int](), greaterThan = [Int]()

    // pass through the array rearranging all elements into their corresponding partitions
    for i in 0 ..< array.count {

        if array[i] < pivot! {

            // append to the less-than partition elements smaller than the pivot
            lessThan.append(array[i])
            
        } else if array[i] > pivot! {
            
            // append to the greater-than partition elements larger than the pivot
            greaterThan.append(array[i])

        } else {
            
            // append to the equal partition elements equal to the pivot
            equal.append(array[i])
        }
    }

    // sort recursively all partitions but the equal one, and join all of them in the end
    return quickSort_theClassic(lessThan) + equal + quickSort_theClassic(greaterThan)
}

// Sorted
quickSort_theClassic([Int]()) == [Int]()
quickSort_theClassic([7]) == [7]
quickSort_theClassic([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
quickSort_theClassic([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
quickSort_theClassic([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
quickSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func quickSort_theSwiftish(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.sampled()

    var lessThan = [Int](), equal = [Int](), greaterThan = [Int]()

    for element in array {

        switch element {
        case let element where element < pivot!:
            lessThan += [element]
        case let element where element > pivot!:
            greaterThan += [element]
        default:
            equal += [element]
        }
    }

    return quickSort_theSwiftish(lessThan) + equal + quickSort_theSwiftish(greaterThan)
}

// Sorted
quickSort_theSwiftish([Int]()) == [Int]()
quickSort_theSwiftish([7]) == [7]
quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
quickSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
quickSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful features of the language yet
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func quickSort_theSwiftest(_ array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    let pivot = array.remove(at: 0)

    let lessThan = array.filter({ $0 < pivot })
    let greaterThanOrEqual = array.filter({ $0 >= pivot })

    return quickSort_theSwiftest(lessThan) + ([pivot] as [Int]) + quickSort_theSwiftest(greaterThanOrEqual)
}

// Sorted
quickSort_theSwiftest([Int]()) == [Int]()
quickSort_theSwiftest([7]) == [7]
quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
quickSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
quickSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

//: ---
//:
/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func quickSort_theGeneric<T: Comparable>(_ array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    let pivot = array.remove(at: 0)

    let lessThan = array.filter({ $0 < pivot })
    let greaterThanOrEqual = array.filter({ $0 >= pivot })

    return quickSort_theGeneric(lessThan) + ([pivot] as [T]) + quickSort_theGeneric(greaterThanOrEqual)
}

// Sorted
quickSort_theGeneric([Int]()) == [Int]()
quickSort_theGeneric([7]) == [7]
quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

quickSort_theGeneric([String]()) == [String]()
quickSort_theGeneric(["a"]) == ["a"]
quickSort_theGeneric(["a", "a", "b", "c", "d", "e"]) == ["a", "a", "b", "c", "d", "e"]

// Nearly Sorted
quickSort_theGeneric([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theGeneric(["a", "b", "a", "c", "e", "d"]) == ["a", "a", "b", "c", "d", "e"]

// Reversed
quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theGeneric(["a", "a", "b", "c", "d", "e"].reversed()) == ["a", "a", "b", "c", "d", "e"]

// Shuffled
quickSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffled()) == ["a", "a", "b", "c", "d", "e"]

//: ---
//:
/// The Functional Algorithm
///
/// A quirky take that unleashes some of the neat declarative aspects of the language
///
/// - Parameter array: The `array` to be sorted
///
/// - Returns: A new array with elements sorted in ascending order

func quickSort_theFunctional(_ array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let (pivot, rest) = (array.first!, array.dropFirst())

    let lessThan = rest.filter({ $0 < pivot })
    let greaterThanOrEqual = rest.filter({ $0 >= pivot })

    return quickSort_theFunctional(lessThan) + ([pivot] as [Int]) + quickSort_theFunctional(greaterThanOrEqual)
}

// Sorted
quickSort_theFunctional([Int]()) == [Int]()
quickSort_theFunctional([7]) == [7]
quickSort_theFunctional([1, 1, 2, 3, 5, 8, 13]) == [1, 1, 2, 3, 5, 8, 13]

// Nearly Sorted
quickSort_theFunctional([1, 2, 1, 3, 5, 13, 8]) == [1, 1, 2, 3, 5, 8, 13]

// Reversed
quickSort_theFunctional([1, 1, 2, 3, 5, 8, 13].reversed()) == [1, 1, 2, 3, 5, 8, 13]

// Shuffled
quickSort_theFunctional([1, 1, 2, 3, 5, 8, 13].shuffled()) == [1, 1, 2, 3, 5, 8, 13]

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

func quickSort_theBonus<T>(_ array: [T], by areInIncreasingOrder: (T, T) -> Bool) -> [T] {

    guard array.count > 1, let pivot = array.sampled() else {
        return array
    }

    var lessThan = [T](), equal = [T](), greaterThan = [T]()

    for element in array {

        switch element {
        case let element where areInIncreasingOrder(element, pivot):
            lessThan += [element]
        case let element where areInIncreasingOrder(pivot, element):
            greaterThan += [element]
        default:
            equal += [element]
        }
    }

    lessThan = quickSort_theBonus(lessThan, by: areInIncreasingOrder)
    greaterThan = quickSort_theBonus(greaterThan, by: areInIncreasingOrder)

    return lessThan + equal + greaterThan
}

// Sorted
quickSort_theBonus([Int](), by: <) == [Int]()
quickSort_theBonus([Int](), by: >) == [Int]()
quickSort_theBonus([7], by: <) == [7]
quickSort_theBonus([7], by: >) == [7]
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: <) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()

quickSort_theBonus([String](), by: <) == [String]()
quickSort_theBonus([String](), by: >) == [String]()
quickSort_theBonus(["a"], by: <) == ["a"]
quickSort_theBonus(["a"], by: >) == ["a"]
quickSort_theBonus(["a", "a", "b", "c", "d", "e"], by: <) == ["a", "a", "b", "c", "d", "e"]
quickSort_theBonus(["a", "a", "b", "c", "d", "e"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Nearly Sorted
quickSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: <) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theBonus([1, 2, 1, 3, 5, 13, 8], by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
quickSort_theBonus(["a", "b", "a", "c", "e", "d"], by: <) == ["a", "a", "b", "c", "d", "e"]
quickSort_theBonus(["a", "b", "a", "c", "e", "d"], by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Reversed
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: <) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13].reversed(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
quickSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: <) == ["a", "a", "b", "c", "d", "e"]
quickSort_theBonus(["a", "a", "b", "c", "d", "e"].reversed(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

// Shuffled
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: <) == [1, 1, 2, 3, 5, 8, 13]
quickSort_theBonus([1, 1, 2, 3, 5, 8, 13].shuffled(), by: >) == [1, 1, 2, 3, 5, 8, 13].reversed()
quickSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: <) == ["a", "a", "b", "c", "d", "e"]
quickSort_theBonus(["a", "a", "b", "c", "d", "e"].shuffled(), by: >) == ["a", "a", "b", "c", "d", "e"].reversed()

//: ---
//:
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
