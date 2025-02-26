def encode(message: str, rails):
    message_len = len(message)
    output = ["" for _ in range(rails)]
    rail_no = 0
    rail_direction = 1
    
    for idx in range(message_len):
        ## put the message char into the rail
        output[rail_no] += message[idx]
        ## select the next rail
        rail_no += rail_direction
        if rail_no == 0 or rail_no == rails - 1:
            rail_direction *= -1

    return "".join(output)



def decode(encoded_message, rails):
    message_len = len(encoded_message)
    encoded_message_splitted = []
    chars_in_rail = [0 for _ in range(rails)]
    rail_no = 0
    rail_direction = 1

    ## determine how many chars can be placed in each rails
    for _ in range(message_len):
        chars_in_rail[rail_no] += 1
        rail_no += rail_direction
        if rail_no == 0 or rail_no == rails -1:
            rail_direction *= -1 

    ## split encoded message into rails
    start_char_idx = 0
    for chars_len in chars_in_rail:
        encoded_message_splitted.append(encoded_message[start_char_idx:start_char_idx + chars_len])
        start_char_idx += chars_len
    
    ## peak chars from each rails to output, with rail hop rules
    rail_no = 0
    rail_direction = 1
    output = ""
    for _ in range(message_len):
        output += encoded_message_splitted[rail_no][0]
        encoded_message_splitted[rail_no] = encoded_message_splitted[rail_no][1:]
        rail_no += rail_direction
        if rail_no == 0 or rail_no == rails -1:
            rail_direction *= -1 

    return output