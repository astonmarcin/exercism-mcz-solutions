def response(hey_bob):
    is_silence = hey_bob.isspace() or not hey_bob
    is_question = hey_bob.strip().endswith("?")
    is_yell = hey_bob.isupper() and not is_silence
    if is_yell and is_question:
        return "Calm down, I know what I'm doing!"
    if is_question:
        return "Sure."
    if is_yell:
        return "Whoa, chill out!"
    if is_silence:
        return "Fine. Be that way!"
    return "Whatever."