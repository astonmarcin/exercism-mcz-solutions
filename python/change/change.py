def find_fewest_coins(coins, target):
    if target < 0:
        raise ValueError("target can't be negative")
    if target == 0:
        return []

    min_coins = [float('inf')] * (target + 1)
    min_coins[0] = 0
    coin_used = [-1] * (target + 1)

    for x in range(1, target+1):
        for coin in coins:
            if coin <= target:
                if 1 + min_coins[x - coin] < min_coins[x]:
                    min_coins[x] = 1 + min_coins[x - coin]
                    coin_used[x] = coin

    if min_coins[target] == float('inf'):
        raise ValueError("can't make target with given coins")

    output = []
    while target > 0:
        output.append(coin_used[target])
        target -= coin_used[target]
    
    return output