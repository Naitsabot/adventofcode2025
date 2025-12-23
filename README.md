# adventofcode2025

Advent of code, using nim, _trying_ to learn _some_ metaprogramming

## Add Day

- Make folder `/dayXX`, where `XX` is the the day
- Copy over from `/templates` the `dayXX.nim` file and change its name likewise as the folder
- In `dayXX.nim` change `const DAY = 0` to be the same as the day as the directory
- Add in `/dayXX` two files `text.txt` and `input.txt` for the test input and the full puzzle input

## Add Input

- In the days folder, add a file `input.txt` with the puzzle input
- [Inputs are ignored by git](https://www.reddit.com/r/adventofcode/comments/7lesj5/is_it_kosher_to_share_puzzle_inputs_and_answers/drlt9am/)

## Runing
```bash
nim c -r [PATH-OF-DAYS-NIM-FILE]
```
