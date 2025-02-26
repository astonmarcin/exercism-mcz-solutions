package lasagna

func PreparationTime(layers []string, time int) int {
	if time == 0 {
		time = 2
	}
	return len(layers) * time
}

func Quantities(ingredients []string) (noodles int, sauce float64) {
	for _, value := range ingredients {
		if value == "noodles" {
			noodles += 50
		}
		if value == "sauce" {
			sauce += 0.2
		}
	}
	return
}

func AddSecretIngredient(friendsList, myList []string) {
	myList[len(myList)-1] = friendsList[len(friendsList)-1]
}

func ScaleRecipe(orig_quantities []float64, portions int) (new_quantities []float64) {
	new_quantities = make([]float64, len(orig_quantities))
	for idx, value := range orig_quantities {
		new_quantities[idx] = value / 2 * float64(portions)
	}
	return
}
