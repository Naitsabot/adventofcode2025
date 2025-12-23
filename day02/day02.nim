import std/[strutils, sequtils, math]
import ../lib/utils


const DAY = 2  # Change this for each day


type 
    Range = object
        min: int
        max: int
        invalid: seq[int]

proc part1(input: string): int =
    ## Solve part 1
    
    # Create range objects from input
    var ranges: seq[Range] = input.strip().split(",").mapIt(
        (let parts = it.split("-");
         Range(min: parseInt(parts[0]), max: parseInt(parts[1]), invalid: @[]))
    )

    # Within each range, find invalid numbers
    # Numbers whoes digits are doubbled, like 11 or 456456 are invalid
    for r in ranges.mitems:
        for num in r.min .. r.max:
            let str = $num
            # Compare the if some sequence of digits are repeated twice in the number
            # Add to invalid seq if so
            # 55 (5 twice), 6464 (64 twice), and 123123 (123 twice) would all be invalid IDs

            if str.len mod 2 == 0:
                if str[0 ..< str.len div 2] == str[str.len div 2 ..< str.len]:
                    r.invalid.add(num)
    
    # Sum invlaid numbers
    for r in ranges:
        #echo r.invalid
        for n in r.invalid:
            result += n


proc part2(input: string): int =
    ## Solve part 2
    ## 
    # Create range objects from input
    var ranges: seq[Range] = input.strip().split(",").mapIt(
        (let parts = it.split("-");
         Range(min: parseInt(parts[0]), max: parseInt(parts[1]), invalid: @[]))
    )

    # Within each range, find invalid numbers
    # Numbers whoes digits are doubbled, like 11 or 456456 are invalid
    for r in ranges.mitems:
        for num in r.min .. r.max:
            let str = $num
            # Compare the if some sequence of digits are repeated AT LEAST twice in the number
            # Add to invalid seq if so
            # 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs

            if str.len >= 2:
                # Check for all possible segment sizes
                for size in 1 ..< str.len div 2 + 1:
                    # Only check sizes that evenly divide the string length
                    if str.len mod size == 0:
                        # Calculate how many times the segment should repeat
                        let times = str.len div size
                        let segment = str[0 ..< size]
                        if segment.repeat(times) == str:
                            r.invalid.add(num)
                            break
    
    # Sum invlaid numbers
    for r in ranges:
        #echo r.invalid
        for n in r.invalid:
            result += n


when isMainModule:
    solution(DAY):
        let answer1_example = part1(test)
        echo "Part 1 example: ", answer1_example

        let answer1 = part1(input)
        echo "Part 1: ", answer1

        let answer2_example = part2(test)
        echo "Part 2 example: ", answer2_example

        let answer2 = part2(input)
        echo "Part 2: ", answer2
