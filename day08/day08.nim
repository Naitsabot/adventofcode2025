import std/[strutils, sequtils, algorithm, math, tables, sets, hashes]
import ../lib/utils


const DAY = 8  # Change this for each day


type 
    Junction = object
        x, y, z: int

    Connection = object
        junctionA, junctionB: Junction

    Distance = object
        connection: Connection
        distance: float


proc `$`(j: Junction): string =
    result = "Junction(x: " & $j.x & ", y: " & $j.y & ", z: " & $j.z & ")"


proc `$`(c: Connection): string =
    result = "Connection(from: " & $c.junctionA & ", to: " & $c.junctionB & ")"


proc `$`(d: Distance): string =
    result = "Distance(connection: " & $d.connection & ", distance: " & $d.distance & ")"


proc `==`(a, b: Junction): bool =
    a.x == b.x and a.y == b.y and a.z == b.z


proc hash(j: Junction): Hash =
    var h: Hash = 0
    h = h !& hash(j.x)
    h = h !& hash(j.y)
    h = h !& hash(j.z)
    result = !$h


# https://en.wikipedia.org/wiki/Euclidean_distance
proc euclideanDistance(a, b: Junction): float =
    sqrt(((float(a.x) - float(b.x)) ^ 2) +
        ((float(a.y) - float(b.y)) ^ 2) +
        ((float(a.z) - float(b.z)) ^ 2))


proc readJunctions(input: string): seq[Junction] =
    ## Read junctions from input
    for line in input.splitLines():
        if line.len == 0: continue
        let parts = line.split(",")
        result.add(Junction(x: parts[0].parseInt(),
                            y: parts[1].parseInt(),
                            z: parts[2].parseInt()))


proc part1(input: string): int =
    ## Solve part 1
    
    var junctions: seq[Junction] = readJunctions(input)
    let junctionconnectiongoal = junctions.len

    # Each juctions starts as its own circuit
    var circuits: seq[HashSet[Junction]] = @[]
    for j in junctions:
        var circuit = initHashSet[Junction]()
        circuit.incl(j)
        circuits.add(circuit)

   
    # Calcualte distances bwtween all junctions, only unique
    var distances: seq[Distance] = @[]
    for i in 0..<junctions.len:
        for j in i+1..<junctions.len:
            let dist = euclideanDistance(junctions[i], junctions[j])
            distances.add(Distance(connection: Connection(junctionA: junctions[i], junctionB: junctions[j]), distance: dist))

    # Sort distances by distance
    proc cmp(x, y: Distance): int =
        if x.distance < y.distance: return -1
        elif x.distance > y.distance: return 1
        else: return 0

    distances.sort(cmp)

    for i, d in distances:
        if i == junctionconnectiongoal: break

        var c1index = -1
        var c2index = -1
        for j in 0..<circuits.len:
            if d.connection.junctionA in circuits[j]:
                c1index = j
            if d.connection.junctionB in circuits[j]:
                c2index = j
        
        if c1index == c2index: continue
            
        for junction in circuits[c2index]:
            circuits[c1index].incl(junction)
        
        circuits.delete(c2index)
    
    # Sort circuits by size (largest first)
    circuits.sort(proc(a, b: HashSet[Junction]): int =
        cmp(b.len, a.len)
    )
    
    result = circuits[0].len * circuits[1].len * circuits[2].len


proc part2(input: string): int =
    ## Solve part 2
    
    var junctions: seq[Junction] = readJunctions(input)

    # Each juctions starts as its own circuit
    var circuits: seq[HashSet[Junction]] = @[]
    for j in junctions:
        var circuit = initHashSet[Junction]()
        circuit.incl(j)
        circuits.add(circuit)

   
    # Calcualte distances bwtween all junctions, only unique
    var distances: seq[Distance] = @[]
    for i in 0..<junctions.len:
        for j in i+1..<junctions.len:
            let dist = euclideanDistance(junctions[i], junctions[j])
            distances.add(Distance(connection: Connection(junctionA: junctions[i], junctionB: junctions[j]), distance: dist))

    # Sort distances by distance
    proc cmp(x, y: Distance): int =
        if x.distance < y.distance: return -1
        elif x.distance > y.distance: return 1
        else: return 0

    distances.sort(cmp)

    var l1: Junction = Junction(x: 0, y: 0, z: 0)
    var l2: Junction = Junction(x: 0, y: 0, z: 0)

    for i, d in distances:
        var c1index = -1
        var c2index = -1
        for j in 0..<circuits.len:
            if d.connection.junctionA in circuits[j]:
                c1index = j
            if d.connection.junctionB in circuits[j]:
                c2index = j
        
        if c1index == c2index: continue
            
        for junction in circuits[c2index]:
            circuits[c1index].incl(junction)
        
        circuits.delete(c2index)

        l1 = d.connection.junctionA
        l2 = d.connection.junctionB
    
    result = l1.x * l2.x


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
