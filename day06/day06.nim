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


proc algorithm(problems: seq[seq[string]]): int =
    ## Common algorithm for both parts
    for problem in problems:
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
                if n == "":
                    continue
                temp = temp + parseInt(n)
            result += temp
        else:
            raise newException(ValueError, "Unknown operation: " & problem[^1])


proc part1(input: string): int =
    ## Solve part 1
    let problems = readProblems(input)
    let tproblems = problems.transpose()

    #echo tproblems

    algorithm(tproblems)


proc readProblems2(input: string): seq[seq[string]] =
    # 123 328  51 64 
    #  45 64  387 23 
    #  6  98  215 314
    # *   +   *   +  
    for i in 0 ..< input.splitlines.len:
        result.add(newSeq[string]())
        for j in 0 ..< input.splitlines[i].len:
            let c = input.splitlines[i][j]
            result[i].add($c)
            
        

proc part2(input: string): int =
    ## Solve part 2
    
    let problems = readProblems2(input)
    let tproblems = problems.transpose()
    #echo tproblems
    
    var cproblems = newSeq[seq[string]]()
    var hasChanged = true
    var newproblem = newSeq[string]()
    for problem in tproblems:
        # @[@["1", " ", " ", "*"], @["2", "4", " ", " "], @["3", "5", "6", " "], @[" ", " ", " ", " "], @["3", "6", "9", "+"], @["2", "4", "8", " "], @["8", " ", " ", " "], @[" ", " ", " ", " "], @[" ", "3", "2", "*"], @["5", "8", "1", " "], @["1", "7", "5", " "], @[" ", " ", " ", " "], @["6", "2", "3", "+"], @["4", "3", "1", " "], @[" ", " ", "4", " "]]
        # ->
        # @[@["1", "24", "356", "*"], ...]

        # merge numbers, gether operation from first row, when an seq with only empty, new problem

        # If new problem
        if problem.allIt(it == " "):
            cproblems.add(newproblem)
            newproblem = newSeq[string]()
            hasChanged = true
            continue
        
        if hasChanged: 
            newproblem.add(problem[^1])  # add operator
            hasChanged = false

        # Merge numbers 0 .. ^2
        newproblem.add(problem[0..^2].join("").strip())
    
    cproblems.add(newproblem)
    newproblem = newSeq[string]()
    
    for i in 0 ..< cproblems.len:
        var temp = cproblems[i]
        temp.rotateLeft(1)
        cproblems[i] = temp

    #echo cproblems

    algorithm(cproblems)

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
