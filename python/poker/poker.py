from collections import Counter

RANKING_MAP ={
    "straight_flush": 0,
    "four": 1,
    "full": 2,
    "flush": 3,
    "straight": 4,
    "three": 5,
    "two": 6,
    "one": 7,
    "high": 8,
}
RANKS = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
RANKS_ORDER = { rank: idx for idx, rank in enumerate(RANKS) }

def best_hands(hands):
    print("RANKS_ORDER:", RANKS_ORDER)
    rankings = []
    hands_splitted = []
    for hand_idx, hand in enumerate(hands):
        ranks = [h[:-1] for h in hand.split(" ")]
        if sorted(ranks) == ['2', '3', '4', '5', "A"]:
            ranks[ranks.index("A")] = "a"
        suits = [h[-1] for h in hand.split(" ")]
        ranks_counter = Counter(ranks)
        suits_counter = Counter(suits)
        hands_splitted.append({
            "ranks": ranks,
            "suits": suits,
            "ranks_counter": ranks_counter,
            "suits_counter": suits_counter,
            "ranks_order": sorted([RANKS_ORDER[rank] for rank in ranks_counter.keys()], reverse=True),
        })
        if len(set(suits)) == 1 and "".join(sorted(ranks, key=lambda r: RANKS_ORDER[r])) in "".join(RANKS):
            rankings.append(RANKING_MAP["straight_flush"])
            continue
        if 4 in ranks_counter.values():
            rankings.append(RANKING_MAP["four"])
            hands_splitted[hand_idx]["ranks_order"] = sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 4], reverse=True) 
            hands_splitted[hand_idx]["ranks_order"] += sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value != 4], reverse=True)
            continue
        if sorted(ranks_counter.values()) == [2, 3]:
            rankings.append(RANKING_MAP["full"])
            hands_splitted[hand_idx]["ranks_order"] = sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 3], reverse=True) 
            hands_splitted[hand_idx]["ranks_order"] += sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 2], reverse=True)
            continue
        if list(suits_counter.values()) == [5]:
            rankings.append(RANKING_MAP["flush"])
            continue
        if "".join(sorted(ranks, key=lambda r: RANKS_ORDER[r])) in "".join(RANKS):
            rankings.append(RANKING_MAP["straight"])
            continue
        if 3 in ranks_counter.values():
            rankings.append(RANKING_MAP["three"])
            hands_splitted[hand_idx]["ranks_order"] = sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 3], reverse=True) 
            hands_splitted[hand_idx]["ranks_order"] += sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value != 3], reverse=True)
            continue
        if sorted(ranks_counter.values()) == [1, 2, 2]:
            rankings.append(RANKING_MAP["two"])
            hands_splitted[hand_idx]["ranks_order"] = sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 2], reverse=True) 
            hands_splitted[hand_idx]["ranks_order"] += sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value != 2], reverse=True)
            continue
        if 2 in ranks_counter.values():
            rankings.append(RANKING_MAP["one"])
            hands_splitted[hand_idx]["ranks_order"] = sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value == 2], reverse=True)
            hands_splitted[hand_idx]["ranks_order"] += sorted([RANKS_ORDER[key] for key, value in ranks_counter.items() if value != 2], reverse=True)
            continue
        rankings.append(RANKING_MAP["high"])

    possible_hands = [idx for idx, hand in enumerate(rankings) if hand == min(rankings)]
    possible_hands_rank_order = [hands_splitted[idx]["ranks_order"] for idx in possible_hands]
    output = [hand for idx, hand in enumerate(possible_hands) if possible_hands_rank_order[idx] == max(possible_hands_rank_order)]

    return [hands[idx] for idx in output]

        
