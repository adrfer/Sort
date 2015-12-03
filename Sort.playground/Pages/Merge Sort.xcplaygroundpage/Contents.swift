//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Insertion Sort
//: ----
//:
//: ### About
//:
//: - Recursively divides input array in two halves, by calling itself for both halves
//: - Sorts the elements of both halves of the array
//: - Merges the two sorted halves until the entire array is sorted
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    find the pivot point = n / 2
//:
//:    left array = from 0 to pivot
//:
//:    right array = from pivot to n
//:
//:    call sort on the both halves
//:
//:    while both halves still have elements
//:
//:      if left array[0] > rigth array[0]
//:
//:        append left array[0] to the sorted array
//:
//:     else
//:
//:        append right array[0] to the sorted array
//:
//:    while left half still has elements
//:
//:      add itd first element to the end of c
//:
//:    while right half still has elements
//:
//:      add itd first element to the end of c
//:
//:      remove a[0] from a
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
/// A die-hard style, rooted in tradition, in all its imperative glory... Well, not
/// quite, due to some Swift safety features when using the set subscription syntax
///
/// This version showcases `if` early exit, old-fashioned `for` and `while` loops
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func mergeSort_theClassic(array: [Int]) -> [Int] {

    // returns the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // finds the mid point in order to split the input array into two halves
    let pivot = array.count / 2

    // creates the left half of the array
    var leftArray = [Int]()

    for var i = 0; i < pivot; ++i {

        // it's not possible to use subscript to append a new item to the end of an array,
        // i.e. leftArray[i] = array[i], since modifying a value for an index that is out
        // of an array’s existing bounds is not allowed, therefore `append` has to be used
        leftArray.append(array[i])
    }

    // creates the right half of the array
    var rightArray = [Int]()

    for var j = pivot; j < array.count; ++j {
        rightArray.append(array[j])
    }

    // sorts the both halves of the array
    leftArray = mergeSort_theClassic(leftArray)
    rightArray = mergeSort_theClassic(rightArray)

    // creates a temporary array to serves as the result of the merge
    var mergedArray = [Int]()

    // starts by comparing the first element of each half
    var leftIndex = 0, rightIndex = 0

    // sorts and merges the two halves while there are elements in both of them
    while leftArray.count > leftIndex && rightArray.count > rightIndex {

        // compares elements of both halves and merges the smaller element of the respective half
        if leftArray[leftIndex] < rightArray[rightIndex] {

            // again, it's not possible to use subscript to append a new item to the end of an
            // array, i.e. mergedArray[mergedIndex++] = leftArray[leftIndex++], since modifying
            // a value for an index that is out of an array’s existing bounds is not allowed
            mergedArray.append(leftArray[leftIndex++])

        } else {
            mergedArray.append(rightArray[rightIndex++])
        }
    }

    // merges the remaining elements of the left half, if any
    while leftArray.count > leftIndex {
        mergedArray.append(leftArray[leftIndex++])
    }

    // merges the remaining elements of the right half, if any
    while rightArray.count > rightIndex {
        mergedArray.append(rightArray[rightIndex++])
    }

    return mergedArray
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
/// as `append` and `removeFirst`, and array slicing
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergeSort_theSwiftish(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    let pivot = array.count / 2

    var leftArray = Array(array[0..<pivot])
    var rightArray = Array(array[pivot..<array.count])

    leftArray = mergeSort_theSwiftish(leftArray)
    rightArray = mergeSort_theSwiftish(rightArray)

    var mergedArray = [Int]()

    while leftArray.count > 0 && rightArray.count > 0 {

        if leftArray.first < rightArray.first {
            mergedArray.append(leftArray.removeFirst())

        } else {
            mergedArray.append(rightArray.removeFirst())
        }
    }

    while leftArray.count > 0 {
        mergedArray.append(leftArray.removeFirst())
    }

    while rightArray.count > 0 {
        mergedArray.append(rightArray.removeFirst())
    }
    
    return mergedArray
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
/// as `append`, array slicing, tuple decomposition, and nested functions
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergerSort_theSwiftest(array: [Int]) -> [Int] {

    guard array.count > 1 else {
        return array
    }

    func split(array: [Int]) -> ([Int], [Int]) {

        let pivot = array.count / 2
        let leftArray = Array(array[0..<pivot])
        let rightArray = Array(array[pivot..<array.count])

        return (leftArray, rightArray)
    }

    func merge(leftArray: [Int], _ rightArray: [Int]) -> [Int] {

        guard !leftArray.isEmpty else {
            return rightArray
        }

        guard !rightArray.isEmpty else {
            return leftArray
        }

        if leftArray[0] < rightArray[0] {
            let raminingLeftArray = Array(leftArray[1..<leftArray.count])
            return [leftArray[0]] + merge(raminingLeftArray, rightArray)
        }
        else {
            let raminingRightArray = Array(rightArray[1..<rightArray.count])
            return [rightArray[0]] + merge(leftArray, raminingRightArray)
        }
    }

    var (leftArray, rightArray) = split(array)

    leftArray = mergerSort_theSwiftest(leftArray)
    rightArray = mergerSort_theSwiftest(rightArray)

    return merge(leftArray, rightArray)
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
/// as `append`, array slicing, tuple decomposition, nested functions, and generics
///
/// - parameter array: The `array` to be sorted
///
/// - returns: The `array` with elements sorted in ascending order

func mergeSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    guard array.count > 1 else {
        return array
    }

    func split(array: [T]) -> ([T], [T]) {

        let pivot = array.count / 2
        let leftArray = Array(array[0..<pivot])
        let rightArray = Array(array[pivot..<array.count])

        return (leftArray, rightArray)
    }

    func merge(leftArray: [T], _ rightArray: [T]) -> [T] {

        guard !leftArray.isEmpty else {
            return rightArray
        }

        guard !rightArray.isEmpty else {
            return leftArray
        }

        if leftArray[0] < rightArray[0] {
            let raminingLeftArray = Array(leftArray[1..<leftArray.count])
            return [leftArray[0]] + merge(raminingLeftArray, rightArray)
        }
        else {
            let raminingRightArray = Array(rightArray[1..<rightArray.count])
            return [rightArray[0]] + merge(leftArray, raminingRightArray)
        }
    }

    var (leftArray, rightArray) = split(array)

    leftArray = mergeSort_theGeneric(leftArray)
    rightArray = mergeSort_theGeneric(rightArray)
    
    return merge(leftArray, rightArray)
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
