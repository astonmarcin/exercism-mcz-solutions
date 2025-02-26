package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten":
		return 10
	case "jack":
		return 10
	case "queen":
		return 10
	case "king":
		return 10
	}
	return 0
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	card1_value := ParseCard(card1)
	card2_value := ParseCard(card2)
	dealerCard_value := ParseCard(dealerCard)
	switch {
	case card1_value == 11 && card2_value == 11:
		return "P"
	case card1_value + card2_value == 21:
		switch {
		case dealerCard_value < 10:
			return "W"
		case dealerCard_value >= 10:
			return "S"
		}
	case card1_value + card2_value >= 17 && card1_value + card2_value <= 20:
		return "S"
	case card1_value + card2_value >= 12 && card1_value + card2_value <= 16:
		switch {
		case dealerCard_value >= 7:
			return "H"
		case dealerCard_value < 7:
			return "S"
		}
	case card1_value + card2_value <= 11:
		return "H"
	}
	return ""
}
