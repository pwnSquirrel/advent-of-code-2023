package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func tieBreaker(hand1 string, hand2 string, order []byte) bool {
	for i := range hand1 {
		if hand1[i] == hand2[i] {
			continue
		}

		for _, c := range order {
			if hand1[i] == c {
				return false
			}
			if hand2[i] == c {
				return true
			}
		}
	}

	return false
}

func handValuePart1(hand string) uint {
	cards := make(map[rune]uint)
	count := uint(0)

	for _, v := range hand {
		cards[v] += 1
		count += cards[v]*2 - 1
	}

	return count
}

func lessPart1(hand1 string, hand2 string) bool {
	v1 := handValuePart1(hand1)
	v2 := handValuePart1(hand2)

	if v1 != v2 {
		return v1 < v2
	}

	return tieBreaker(hand1, hand2, []byte{'A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'})
}

func handValuePart2(hand string) uint {
	cards := make(map[rune]uint)
	count := uint(0)

	for _, v := range hand {
		if v == 'J' {
			continue
		}
		cards[v] += 1
		count += cards[v]*2 - 1
	}

	max := uint(0)
	for _, c := range cards {
		if c > max {
			max = c
		}
	}

	for _, v := range hand {
		if v == 'J' {
			max += 1
			count += max*2 - 1
		}
	}

	return count
}

func lessPart2(hand1 string, hand2 string) bool {
	v1 := handValuePart2(hand1)
	v2 := handValuePart2(hand2)

	if v1 != v2 {
		return v1 < v2
	}

	return tieBreaker(hand1, hand2, []byte{'A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'})
}

type hand struct {
	cards string
	bid   int
}

func processPart(hands []hand, lessFunc func(hand1 string, hand2 string) bool) {
	sort.Slice(hands, func(i, j int) bool { return lessFunc(hands[i].cards, hands[j].cards) })

	sum := 0
	for i, h := range hands {
		sum += (i + 1) * int(h.bid)
	}

	fmt.Println(sum)
}

func main() {
	rawInput, _ := os.ReadFile("../input.txt")
	input := string(rawInput)
	input = strings.Trim(input, "\n")

	hands := []hand{}

	for _, l := range strings.Split(input, "\n") {
		l := strings.Split(l, " ")
		bid, _ := strconv.Atoi(l[1])
		h := hand{cards: l[0], bid: bid}
		hands = append(hands, h)
	}

	processPart(hands, lessPart1)
	processPart(hands, lessPart2)
}
