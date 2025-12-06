import std/[strutils, sequtils, algorithm, math]
import ../lib/utils


const DAY = 1  # Change this for each day


proc part1(input: string): int =
    ## Solve part 1
    0


proc part2(input: string): int =
    ## Solve part 2
    0


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
