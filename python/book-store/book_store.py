from collections import Counter

discount = {
    1: 100,
    2: 95,
    3: 90,
    4: 80,
    5: 75
}

def total(basket):
    ## init vars
    unique_books = set(basket)
    basket_counter = Counter(basket)
    total_books = basket_counter.total()
    
    ## finding sums - take the total number of books and decompose it to every possible sums with numbers <1, 5>
    all_sums=set()
    def find_sums(current_sum, current_numbers, max_number):
        if current_sum == total_books:
            all_sums.add(tuple(sorted(current_numbers, reverse=True)))
            return all_sums
        for i in range(1, max_number + 1):
            if current_sum + i <= total_books:
                find_sums(current_sum + i, current_numbers + [i], max_number)
        return all_sums
    find_sums(0, [], len(unique_books))

    ## calculate cost for every possible combinations depending on sums
    costs = []
    for sum in all_sums:
        cost = 0
        basket_counter_copy = basket_counter.copy()
        is_sum_valid = True
        for number in sum:
            ## also check if the sum is valid - check if is possible agains books in a basket
            for i, _ in basket_counter_copy.most_common(number):
                basket_counter_copy[i] -= 1
            if any(amount < 0 for amount in basket_counter_copy.values()):
                is_sum_valid = False
            ## calculate the cost...
            cost += number * 800 * discount[number]
        ## ...and append it to output if valid
        if is_sum_valid:
            costs.append(cost)

    ## lastly - print the minimal cost
    return min(costs) // 100
