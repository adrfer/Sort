//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Bubble Sort
//: ----
//:
//: ### About
//:
//: - Passes through the array are repeated until swaps are no longer needed
//: - Compares each pair of adjacent elements and swaps them if they are in the wrong order
//: - Eventually, all unsorted elements bubble up to their appropiated positions, then array is the sorted in-place
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    for i = 0 to n - 1
//:
//:      for j = 0 to n - i - 1
//:
//:        if array[j] > array[j + 1]
//:
//:          swap array[j] and array[j + 1]
//:
//:          mark that a swap ocurred
//:
//:    until no more swaps
//:
//:    return sorted array
//:
//:
//: ### Optimizations
//:
//: - The number of passes through the array needed is the same as to the maximum number of swaps required
//: - At each pass the algorithm keeps track of whether a swap ocurred and, if not, it indicates the array is sorted
//: - At the end of the i-th pass, the last i elements are already sorted, so they are not considered on subsequent passes
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
/// This version showcases `if` early exit, old-fashioned `for`, and
/// manual swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func bubbleSort_theClassic(array: [Int]) -> [Int] {

    // takes in an array that is considered unsorted and makes it mutable so it can be sorted in-place
    var array = array

    // returns the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // passes through the array, but it needs only so many passes due to the number of swaps required
    for var i = 0; i < array.count - 1; i += 1  {

        var swapped = false

        // compares each pair of adjacent elements, but do not compare to sorted elements on subsequent passes
        for var j = 0; j < array.count - i - 1; j += 1 {

            // check is elements are in the wrong order
            if array[j] > array[j + 1] {

                // performs a manual swap
                let temporary = array[j]
                array[j] = array[j + 1]
                array[j + 1] = temporary

                // flags that the array is not properly sorted yet
                swapped = true
            }
        }

        // checks if a swap ocurred, if not, the array is then sorted
        if !swapped {
            break
        }
    }

    return array
}

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
/// This version showcases `guard`, `for-in`, and `swap`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theSwiftish(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    for i in 0..<array.count - 1 {

        var swapped = false

        for j in 0..<array.count - i - 1 {

            if array[j] > array[j + 1] {

                swap(&array[j], &array[j + 1])
                swapped = true
            }
        }

        guard swapped else {
            break
        }

    }

    return array
}

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
/// This version showcases `guard`, `for-in-where`, `repeat-while`, and tuple swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theSwiftest(array: [Int]) -> [Int] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var swapped: Bool
    var endIndex = array.count

    repeat {

        swapped = false

        for i in 0..<endIndex - 1 where array[i] > array[i + 1] {

            (array[i], array[i + 1]) = (array[i + 1], array[i])
            swapped = true
        }

        endIndex -= 1

    } while swapped

    return array
}

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
/// This version showcases `guard`, `for-in-where`, `repeat-while`, tuple swapping,
/// and generics
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theGeneric<T: Comparable>(array: [T]) -> [T] {

    var array = array

    guard array.count > 1 else {
        return array
    }

    var swapped: Bool
    var endIndex = array.count

    repeat {

        swapped = false

        for i in 0..<endIndex - 1 where array[i] > array[i + 1] {

            (array[i], array[i + 1]) = (array[i + 1], array[i])
            swapped = true
        }

        endIndex -= 1

    } while swapped

    return array
}

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

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
