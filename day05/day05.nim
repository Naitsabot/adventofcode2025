import std/[strutils, sequtils, algorithm, math]
import ../lib/utils


const DAY = 5  # Change this for each day


type
    IngredientIDRanges = object
        fr: int
        to: int


proc mergeIntersectingRanges(ranges: seq[IngredientIDRanges]): seq[IngredientIDRanges] =
    # https://www.geeksforgeeks.org/dsa/merging-intervals/
    var sortedRanges: seq[IngredientIDRanges] = ranges.sorted(proc(a, b: IngredientIDRanges): int =
        cmp(a.fr, b.fr)
    )

    for r in sortedRanges:
        if result.len == 0:
            result.add(r)
            continue

        if r.fr <= result[^1].to:
            result[^1].to = max(result[^1].to, r.to)
        else:
            result.add(r)


proc readInput(input: string): (seq[IngredientIDRanges], seq[int]) =
    # Format:
    # 1-3
    # 5-7
    # 
    # 1
    # 2
    # 3

    var isRanges = true
    for line in input.splitLines():
        if line.len == 0:
            isRanges = false
            continue
        
        if isRanges:
            let parts = line.split('-')
            result[0].add(IngredientIDRanges(fr: parseInt(parts[0]), to: parseInt(parts[1])))
        else:
            result[1].add(parseInt(line))



proc part1(input: string): int =
    ## Solve part 1
    let inputt = readInput(input)
    let ids: seq[int] = inputt[1]

    let freshIds = ids.filter(proc(id: int): bool =
        not inputt[0].anyIt(id >= it.fr and id <= it.to)
    )

    freshIds.len


proc part2(input: string): int =
    ## Solve part 2
    
    let inputt = readInput(input)
    let mergedRanges = mergeIntersectingRanges(inputt[0])

    for i in mergedRanges:
        result += (i.to - i.fr + 1)


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
