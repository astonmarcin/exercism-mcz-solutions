package parsinglogfiles

import (
	"regexp"
)

func IsValidLine(text string) bool {
	return regexp.MustCompile(`^\[(TrC|DBG|INF|WRN|ERR|FTL)\]`).MatchString(text)
}

func SplitLogLine(text string) []string {
	return regexp.MustCompile(`<[~*=-]*>`).Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	pattern := regexp.MustCompile(`".*[Pp][Aa][Ss][Ss][Ww][Oo][Rr][Dd].*"`)
	counter := 0
	for _, line := range lines {
		if pattern.MatchString(line) {
			counter += 1
		}
	}
	return counter
}

func RemoveEndOfLineText(text string) string {
	return regexp.MustCompile(`end-of-line\d+`).ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	pattern := regexp.MustCompile(`User +([^ ]+)`)
	for idx, line := range lines {
		if pattern.MatchString(line) {
			lines[idx] = "[USR] " + pattern.FindStringSubmatch(line)[1] + " " + line
		}
	}
	return lines
}
