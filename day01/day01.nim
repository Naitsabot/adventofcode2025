import std/[strutils, sequtils]
import ../lib/utils


const DAY = 1  # Change this for each day


type 
    Dial = object
        pos: int
        zerocounter: int
        clickcounter: int


template makeTurnProc(name: untyped, isRight: static[bool]) =
    proc name(d: var Dial, steps: int) =
        for i in 1..steps:
            when isRight:
                d.pos = (d.pos + 1) mod 100
            else:
                d.pos = d.pos - 1
                if d.pos < 0:
                    d.pos = 99
            
            if d.pos == 0:
                d.clickcounter += 1
        
        # Check if final position is zero
        if d.pos == 0:
            d.zerocounter += 1


makeTurnProc(turnRight, true)
makeTurnProc(turnLeft, false)


proc part1_example(): int =
    # Solve part 1 example

    let input: seq[string] = @["L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"]

    var dial: Dial = Dial(pos: 50, zerocounter: 0)

    for line in input:
        let dir = line[0]
        let steps = parseInt(line[1..^1])
        #echo "Direction: ", dir, ", Steps: ", steps
        if dir == 'L':
            dial.turnLeft(steps)
        elif dir == 'R':
            dial.turnRight(steps)
        else:
            raise newException(ValueError, "Invalid direction: " & $dir)
    
    return dial.zerocounter


proc part1(input: string): int =
    # Solve part 1

    var dial: Dial = Dial(pos: 50, zerocounter: 0)

    for line in readLines(DAY):
        let dir = line[0]
        let steps = parseInt(line[1..^1])
        #echo "Direction: ", dir, ", Steps: ", steps
        if dir == 'L':
            dial.turnLeft(steps)
        elif dir == 'R':
            dial.turnRight(steps)
        else:
            raise newException(ValueError, "Invalid direction: " & $dir)
    
    return dial.zerocounter


proc part2_example(): int =
    # Solve part 2 example

    let input: seq[string] = @["L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"]
    
    var dial: Dial = Dial(pos: 50, zerocounter: 0)

    for line in input:
        let dir = line[0]
        let steps = parseInt(line[1..^1])
        #echo "Direction: ", dir, ", Steps: ", steps
        if dir == 'L':
            dial.turnLeft(steps)
        elif dir == 'R':
            dial.turnRight(steps)
        else:
            raise newException(ValueError, "Invalid direction: " & $dir)
    
    return dial.clickcounter


proc part2(input: string): int =
    # Solve part 2

    var dial: Dial = Dial(pos: 50, zerocounter: 0)

    for line in readLines(DAY):
        let dir = line[0]
        let steps = parseInt(line[1..^1])
        #echo "Direction: ", dir, ", Steps: ", steps
        if dir == 'L':
            dial.turnLeft(steps)
        elif dir == 'R':
            dial.turnRight(steps)
        else:
            raise newException(ValueError, "Invalid direction: " & $dir)
    
    return dial.clickcounter


when isMainModule:
    solution(DAY):
        let answer1_example = part1_example()
        echo "Part 1 example: ", answer1_example

        let answer1 = part1(input)
        echo "Part 1: ", answer1

        let answer2_example = part2_example()
        echo "Part 2 example: ", answer2_example

        let answer2 = part2(input)
        echo "Part 2: ", answer2
