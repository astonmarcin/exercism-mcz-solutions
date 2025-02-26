def tally(rows):
    score_table = {}
            # MP W  D  L  P
    blank_ = [0, 0, 0, 0, 0]
    
    ## count scores for each teams
    for row in [row.split(";") for row in rows]:
        for team in row[:2]:
            if team not in score_table.keys():
                score_table[team] = [*blank_]
        score_table[row[0]][0] += 1
        score_table[row[1]][0] += 1
        if row[2] == "win":
            score_table[row[0]][1] += 1
            score_table[row[1]][3] += 1
            score_table[row[0]][4] += 3
        elif row[2] == "loss":
            score_table[row[0]][3] += 1
            score_table[row[1]][1] += 1
            score_table[row[1]][4] += 3
        elif row[2] == "draw":
            score_table[row[0]][2] += 1
            score_table[row[1]][2] += 1
            score_table[row[0]][4] += 1
            score_table[row[1]][4] += 1
    
    ## convert dict to list
    score_table_lst = sorted([[team] + score for team, score in score_table.items()])

    ## prepare output
    output = ["Team                           | MP |  W |  D |  L |  P"]
    for line in sorted(score_table_lst, key=lambda x: x[5], reverse=True):     ## output table sorted by points! from greatest to smallest (reverse=True)
        team, *scores = line
        score_str = " | ".join(str(score).rjust(2, " ") for score in scores)
        output.append(f"{team.ljust(30, ' ')} | {score_str}")
    return output
