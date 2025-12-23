import std/[strutils, sequtils, algorithm]
import ../lib/utils


const DAY = 3  # Change this for each day


proc part1(input: string): int =
    ## Solve part 1
    
    for line in input.strip().splitLines():
        let lineseq: seq[int] = line.mapit(parseInt($it))

        let maximum = lineseq[0.. lineseq.len-2].max
        let maxloc = lineseq[0.. lineseq.len-2].find(maximum)
        let nextmaximum = lineseq[maxloc + 1.. lineseq.len-1].max
        #echo $maximum & $nextmaximum
        result += parseInt($maximum & $nextmaximum)


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
