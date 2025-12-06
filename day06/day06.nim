import std/[strutils, sequtils, algorithm, math, re]
import ../lib/utils


const DAY = 6  # Change this for each day


proc readProblems(input: string): seq[seq[string]] =
    # 123 328  51 64 
    #  45 64  387 23 
    #   6 98  215 314
    # *   +   *   +  
    # split lines and split by empty whitespace to get matrix

    result = input.splitlines.mapIt(
        it.splitWhitespace()
    )


proc transpose[T](s: seq[seq[T]]): seq[seq[T]] =
    for i in 0 ..< s.len:
        for j in 0 ..< s[i].len:
            if result.len <= j:
                result.add(newSeq[T]())
            result[j].add(s[i][j])


proc part1(input: string): int =
    ## Solve part 1
    let problems = readProblems(input)
    let tproblems = problems.transpose()

    #echo tproblems

    for problem in tproblems:
        case problem[^1]:
        of "*":
            #echo "* operation on" & $ problem[0..^2]
            var temp = 1
            for n in problem[0..^2]:
                temp = temp * parseInt(n)
            result += temp
        of "+":
            #echo "+ operation on" & $ problem[0..^2]
            var temp = 0
            for n in problem[0..^2]:
                temp = temp + parseInt(n)
            result += temp
        else:
            raise newException(ValueError, "Unknown operation: " & problem[^1])


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
