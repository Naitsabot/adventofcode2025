import std/[strutils, sequtils, times, os]


proc readInput*(day: int): string =
    ## Read input file for a given day
    let path = "day" & $day.intToStr(2) & "/input.txt"
    if not fileExists(path):
        raise newException(IOError, "Input file not found: " & path)
    readFile(path)


proc readTest*(day: int): string =
    ## Read test file for a given day
    let path = "day" & $day.intToStr(2) & "/test.txt"
    if not fileExists(path):
        raise newException(IOError, "Test file not found: " & path)
    readFile(path)


proc readLines*(day: int): seq[string] =
    ## Read input as lines
    readInput(day).strip().splitLines()


proc readInts*(day: int): seq[int] =
    ## Read input as integers (one per line)
    readLines(day).map(parseInt)


template benchmark*(name: string, body: untyped) =
    ## Simple benchmarking template
    let start = cpuTime()
    body
    let elapsed = cpuTime() - start
    echo name, " took ", elapsed * 1000, " ms"


template solution*(day: int, body: untyped) =
    ## Main solution template
    echo "=== Day ", day, " ==="
    let input {.inject.} = readInput(day)
    let test {.inject.} = readTest(day)
    body
    echo ""
