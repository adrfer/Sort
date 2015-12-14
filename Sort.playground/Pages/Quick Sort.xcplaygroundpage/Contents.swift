//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Quick Sort
//: ----
//:
//: ### About
//:
//: - Choose the pivot element of the array and rearrange all elements into three differente partitions
//: - Elements less than the pivot go the first partition, elements equal to the pivot go the second, and elements greater go the third
//: - Recursively sort each partition, except the partition where elements ara equal to the pivot
//: - Finally, join the first partition, the second, and the third partitions
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    pivot = pick any element of the array
//:
//:    lessThan, equal, greaterThan = empty partitions
//:
//:    for each element in array
//:
//:      if element < pivot then add element to lessThan
//:
//:      else if element > pivot then add element to greaterThan
//:
//:      else add element to equal
//:
//:    recursively sort both lessThan and greaterThan
//:
//:    join all partitions
//:
//:    return sorted array
//:
//:
//: ### Optimizations
//:
//: - Not choose the pivot as the leftmost element of the partition, since it would cause worst-case behavior on already sorted arrays
//: - With repeated elements, values equal to the pivot are considered already sorted, so only the less-than and greater-than partitions need to be recursively sorted
//:
//:
//: ### Properties
//:
//: - It is a divide and conquer technique, so computation can parallelized
//: - Not simple, both concept and implementation are relatively complex
//: - Not adaptative, as it does not benefit from the presortedness in the input array
//: - Not stable, as it doe not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases `if` early exit, and old-fashioned `for`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func quickSort_theClassic(array: [Int]) -> [Int] {

    // takes in an array that is considered unsorted and makes it mutable so it can be sorted in-place
    var array = array

    // returns the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // picks the pivot element
    let pivot = array[0]

    // partitions the array, indices move towards each other, until an inversion is detect
    var lessThan = [Int](), equal = [Int](), greaterThan = [Int]()

    for var i = 0; i < array.count - 1; ++i {

        if array[i] < pivot {
            lessThan.append(array[i])
        } else if array[i] > pivot {
            greaterThan.append(array[i])
        } else {
            equal.append(array[i])
        }
    }

    return quickSort_theClassic(lessThan) + equal + quickSort_theClassic(greaterThan)
}

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
/// This version showcases `guard`, `for-in`, and `switch`
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func quickSort_theSwiftish(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array[0]

    var lessThan = [Int](), equal = [Int](), greaterThan = [Int]()

    for element in array {

        switch element {
        case let element where element < pivot:
            lessThan.append(element)
        case let element where element > pivot:
            greaterThan.append(element)
        default:
            equal.append(element)
        }
    }

    return quickSort_theSwiftish(lessThan) + equal + quickSort_theSwiftish(greaterThan)
}

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
/// This version showcases `guard`, native methods from the standard library such
/// as `filter`, `+`, and `dropFirst`, and tuple decomposition
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func quickSort_theSwiftest(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let (pivot, rest) = (array.first!, array.dropFirst())

    let lessThanOrEqual = rest.filter {
        $0 <= pivot
    }

    let greaterThan = rest.filter {
        $0 > pivot
    }

    return quickSort_theSwiftest(lessThanOrEqual) + [pivot] + quickSort_theSwiftest(greaterThan)
}

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
/// This version showcases `guard`, native methods from the standard library such
/// as `filter`, `+`, and `dropFirst`, tuple decomposition, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func quickSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    let (pivot, rest) = (array.first!, array.dropFirst())

    let lessThanOrEqual = rest.filter {
        $0 <= pivot
    }

    let greaterThan = rest.filter {
        $0 > pivot
    }

    return quickSort_theGeneric(lessThanOrEqual) + [pivot] + quickSort_theGeneric(greaterThan)
}

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