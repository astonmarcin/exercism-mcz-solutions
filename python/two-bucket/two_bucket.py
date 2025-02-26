bucket_names = ["one", "two"]
GOAL = {bucket_names[idx]: idx for idx in [0,1]}

def measure(bucket_one, bucket_two, goal, start_bucket):
    sizes = [bucket_one, bucket_two]
    goal_idx = GOAL[start_bucket]
    buckets = [0,0]
    invalid = f"{[sizes[goal_idx ^ 1] if goal_idx ^ 1 == idx else 0 for idx in range(2)]}"
    print(invalid, sizes)

    def fill(buckets, idx):
        buckets[idx] = sizes[idx]
        return buckets
    def empty(buckets, idx):
        buckets[idx] = 0
        return buckets
    def from_bucket_to_bucket(buckets, idx):
        amount = min(sizes[idx] - buckets[idx], buckets[idx ^ 1])
        buckets[idx] += amount
        buckets[idx ^ 1] -= amount
        return buckets

    ## first step is always fill the start bucket
    buckets = fill(buckets[:], goal_idx)
    count = 1

    to_check = []
    checked = set()

    while goal not in buckets:
        state = f"{buckets}"
        if state != invalid and state not in checked:
            checked.add(state)
            cnt = count + 1
            for idx in [0, 1]:
                if buckets[idx] != 0:
                    to_check.append([empty(buckets[:], idx), cnt])
                if buckets[idx] != sizes[idx]:
                    to_check.append([fill(buckets[:], idx), cnt])
                    to_check.append([from_bucket_to_bucket(buckets[:], idx), cnt])
        if len(to_check) == 0:
            raise ValueError("The example is not solvable.")
        buckets, count = to_check.pop(0)

    goal_idx = buckets.index(goal)
    return (count, bucket_names[goal_idx], buckets[goal_idx ^ 1])