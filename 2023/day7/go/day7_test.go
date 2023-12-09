package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHandValuePart1(t *testing.T) {
	assert.EqualValues(t, 25, handValuePart1("AAAAA"))
	assert.EqualValues(t, 17, handValuePart1("2AAAA"))
	assert.EqualValues(t, 13, handValuePart1("22AAA"))
	assert.EqualValues(t, 5, handValuePart1("23456"))
}

func TestLessPart1(t *testing.T) {
	assert.True(t, lessPart1("23456", "22456"))
	assert.True(t, lessPart1("23456", "32456"))
	assert.True(t, lessPart1("2AAAA", "AAAAK"))
	assert.True(t, lessPart1("AAAKK", "AAAA2"))
}

func TestHandValuePart2(t *testing.T) {
	assert.EqualValues(t, 25, handValuePart2("AAAAA"))
	assert.EqualValues(t, 17, handValuePart2("2AAAA"))
	assert.EqualValues(t, 13, handValuePart2("22AAA"))
	assert.EqualValues(t, 5, handValuePart2("23456"))

	assert.EqualValues(t, 7, handValuePart2("J3456"))
	assert.EqualValues(t, 11, handValuePart2("J345J"))
	assert.EqualValues(t, 25, handValuePart2("JAAAJ"))
}

func TestLessPart2(t *testing.T) {
	assert.True(t, lessPart2("23456", "J2456"))
	assert.True(t, lessPart2("J3456", "JJ456"))
	assert.True(t, lessPart2("AAA22", "JJJJJ"))
	assert.True(t, lessPart2("AAA22", "JJJJJ"))
	assert.True(t, lessPart2("JAA22", "AJA22"))
}
