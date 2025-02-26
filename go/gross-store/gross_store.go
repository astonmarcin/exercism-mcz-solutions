package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	units := map[string]int{}
	units["quarter_of_a_dozen"] = 3
	units["half_of_a_dozen"] = 6
	units["dozen"] = 12
	units["small_gross"] = 120
	units["gross"] = 144
	units["great_gross"] = 1728
	return units
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	return map[string]int{}
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	_, is_unit := units[unit]
	if !is_unit {
		return false
	} else {
		bill[item] += units[unit]
		return true
	}
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	_, is_unit := units[unit]
	_, is_in_bill := bill[item]
	if !is_unit || !is_in_bill {
		return false
	} else {
		new_quantity := bill[item] - units[unit]
		if new_quantity < 0 {
			return false
		} else if new_quantity == 0 {
			delete(bill, item)
			return true
		} else {
			bill[item] = new_quantity
			return true
		}
	}
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	_, is_in_bill := bill[item]
	if !is_in_bill {
		return 0, false
	} else {
		return bill[item], true
	}
}
