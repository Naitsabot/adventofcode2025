import std/[strutils, sequtils]
import ../lib/utils


const DAY = 4  # Change this for each day


proc read_input_fully(input: string): seq[seq[string]] =
    for line in input.strip().splitLines():
        let lineseq: seq[string] = line.mapit($it)
        result.add(lineseq)


proc algorithm(data: seq[seq[string]]): seq[seq[int]] =
    result.setLen(data.len)
    for i in 0 ..< data.len:
        result[i].setLen(data[i].len)
    
    for i in 0 ..< data.len:
        for j in 0 ..< data[i].len:

            if data[i][j] == ".":
                result[i][j] = -1
                continue

            var count = 0
            for di in -1..1:
                for dj in -1..1:
                    # check is not self
                    if di == 0 and dj == 0: continue
                    # check if out of bounds
                    if i + di < 0 or i + di >= data.len: continue
                    if j + dj < 0 or j + dj >= data[i].len: continue

                    if data[i + di][j + dj] == "@":
                        inc count

            result[i][j] = count


proc step(data: seq[seq[string]]): (seq[seq[string]], int) =
    ## one iteration of the shrink process
    let counts = algorithm(data)

    var newMap = data
    var removed = 0

    for i in 0 ..< data.len:
        for j in 0 ..< data[i].len:
            if data[i][j] == "@":
                if 0 <= counts[i][j] and counts[i][j] < 4:
                    newMap[i][j] = "."
                    inc removed

    (newMap, removed)

proc mapsEqual(a, b: seq[seq[string]]): bool =
    for i in 0 ..< a.len:
        for j in 0 ..< a[i].len:
            if a[i][j] != b[i][j]:
                return false
    true


proc part1(input: string): int =
    ## Solve part 1
    
    let data = read_input_fully(input)

    var ojin: seq[seq[int]]
    ojin.setLen(data.len)
    for i in 0 ..< data.len:
        ojin[i].setLen(data[i].len)
    
    for i in 0 ..< data.len:
        for j in 0 ..< data[i].len:

            if data[i][j] == ".":
                ojin[i][j] = -1
                continue

            var count = 0
            for di in -1..1:
                for dj in -1..1:
                    # check is not self
                    if di == 0 and dj == 0: continue
                    # check if out of bounds
                    if i + di < 0 or i + di >= data.len: continue
                    if j + dj < 0 or j + dj >= data[i].len: continue

                    if data[i + di][j + dj] == "@":
                        inc count

            ojin[i][j] = count
    
    for row in ojin:
        for num in row:
            if 0 <= num and num < 4:
                inc result


proc part2(input: string): int =
    ## Solve part 2

    var current = read_input_fully(input)
    var totalRemoved = 0

    while true:
        let (nextMap, removed) = step(current)
        if removed == 0 or mapsEqual(current, nextMap):
            break

        totalRemoved += removed
        current = nextMap

    totalRemoved


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
