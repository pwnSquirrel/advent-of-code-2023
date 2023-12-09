package main

import (
	"fmt"
	"os"
	"strings"
)

type entry struct {
	left  string
	right string
}

func main() {
	// requires preprocessed input file
	rawInput, _ := os.ReadFile("../input.txt")
	stringInput := strings.Trim(string(rawInput), "\n")
	input := strings.Split(stringInput, "\n")

	m := map[string]entry{}
	inst := input[0]
	input = input[1:]

	var starts []string
	for _, l := range input {
		l := strings.Split(l, " ")
		m[l[0]] = entry{left: l[1], right: l[2]}

		if l[0][2] == 'A' {
			starts = append(starts, l[0])
		}
	}

	count := 0
	pos := "AAA"
	for {
		for _, c := range inst {
			count += 1
			if c == 'L' {
				pos = m[pos].left
			} else {
				pos = m[pos].right
			}

			if pos == "ZZZ" {
				break
			}
		}

		if pos == "ZZZ" {
			break
		}
	}

	fmt.Println(count)

	// Part 2

	loops := []uint{}
	for _, s := range starts {
		count := 0
		pos := s
		for {
			for _, c := range inst {
				count += 1
				if c == 'L' {
					pos = m[pos].left
				} else {
					pos = m[pos].right
				}

				if pos[2] == 'Z' {
					break
				}
			}

			if pos[2] == 'Z' {
				break
			}
		}
		loops = append(loops, uint(count))
	}

	fmt.Println(loops)

	// Calculate lcm / kgv of all the loop lengths to find the solution (used math software)
}
