//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Merge Sort
//: ----
//:
//: ### About
//:
//: - Recursively split the input array in two halves
//: - Sort the elements of both halves of the array
//: - Merge the two sorted halves
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    pivot = mid point of the array
//:
//:    left array = from first element to pivot, non inclusive
//:
//:    right array = from pivot to last element
//:
//:    sort recursively both halves
//:
//:    merge both halves when sorted
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
//: - It is a divide and conquer technique, so computation can parallelized
//: - Not Simple, both concept and implementation are relatively complex
//: - Not Adaptative, as it does not benefit from the presortedness in the input array
//: - Stable, as it preserves the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n-log-n)_ and _O(n-log-n)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases `if` early exit, `for-in` and `while` loops,
/// and native methods from the standard library such as `count` and `append
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func mergeSort_theClassic(array: [Int]) -> [Int] {

    // return the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // find the mid point in order to split the input array into two halves
    let pivot = array.count / 2

    // create the left half of the array
    var left = [Int]()

    for element in 0..<pivot {
        left.append(element)
    }

    // create the right half of the array
    var right = [Int]()

    for element in pivot..<array.count {
        right.append(element)
    }

    // sort the both halves of the array recursively
    left = mergeSort_theClassic(left)
    right = mergeSort_theClassic(right)

    // create a temporary array to serves as the result of the merge
    var merged = [Int]()

    // start by comparing the first element of each half
    var leftIndex = 0, rightIndex = 0

    // sort and merge the two halves while there are elements in both of them
    while left.count > leftIndex && right.count > rightIndex {

        // compare elements of both halves and merge the smaller element of the respective half
        if left[leftIndex] < right[rightIndex] {
            merged.append(left[leftIndex])
            leftIndex += 1
        } else {
            merged.append(right[rightIndex])
            rightIndex += 1
        }
    }

    // merge remaining elements of the left half, if any
    while left.count > leftIndex {
        merged.append(left[leftIndex])
        leftIndex += 1
    }

    // merge remaining elements of the right half, if any
    while right.count > rightIndex {
        merged.append(right[rightIndex])
        rightIndex += 1
    }

    return merged
}

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
/// This version showcases `guard`, native methods from the standard library such
/// as `count` and `removeFirst`, and array slicing
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergeSort_theSwiftish(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.count / 2
    var left = mergeSort_theSwiftish(Array(array[0..<pivot]))
    var right = mergeSort_theSwiftish(Array(array[pivot..<array.count]))

    var merged = [Int]()

    while left.count > 0 && right.count > 0 {

        if left[0] < right[0] {
            merged.append(left.removeFirst())
        } else {
            merged.append(right.removeFirst())
        }
    }

    while left.count > 0 {
        merged.append(left.removeFirst())
    }

    while right.count > 0 {
        merged.append(right.removeFirst())
    }
    
    return merged
}

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
/// This version showcases `guard`, native methods from the standard library such
/// as `count`, `+`, and `isEmpty`, array slicing, and nested functions
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergerSort_theSwiftest(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func merge(left: [Int], _ right: [Int]) -> [Int] {

        guard !left.isEmpty else {
            return right
        }

        guard !right.isEmpty else {
            return left
        }

        if left[0] < right[0] {
            return [left[0]] + merge(Array(left[1..<left.count]), right)
        } else {
            return [right[0]] + merge(left, Array(right[1..<right.count]))
        }
    }

    let pivot = array.count / 2
    let left = mergerSort_theSwiftest(Array(array[0..<pivot]))
    let right = mergerSort_theSwiftest(Array(array[pivot..<array.count]))

    return merge(left, right)
}

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
/// This version showcases `guard`, native methods from the standard library such
/// as `count`, `+`, and `isEmpty`, array slicing, nested functions, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergeSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    func merge(left: [T], _ right: [T]) -> [T] {

        guard !left.isEmpty else {
            return right
        }

        guard !right.isEmpty else {
            return left
        }

        if left[0] < right[0] {
            return [left[0]] + merge(Array(left[1..<left.count]), right)
        } else {
            return [right[0]] + merge(left, Array(right[1..<right.count]))
        }
    }

    let pivot = array.count / 2
    let left = mergeSort_theGeneric(Array(array[0..<pivot]))
    let right = mergeSort_theGeneric(Array(array[pivot..<array.count]))

    return merge(left, right)
}

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
