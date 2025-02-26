import re

def answer(question: str):
    ## define initial vars
    numbers = []
    operations = []
    operations_dict = {
        "plus": "+",
        "minus": "-",
        "multipliedby": "*",
        "dividedby": "/",
    }

    ## parse input
    answer_list = question.replace('multiplied by', 'multipliedby').replace('divided by', 'dividedby').replace('?', ' ?').split()

    ## extract math operations
    for idx in range(3, len(answer_list)-1, 2):
        if answer_list[idx] in ["plus", "minus", "multipliedby", "dividedby"]:
            operations.append(operations_dict[answer_list[idx]])
        elif re.fullmatch(r'^[-0-9]+$', answer_list[idx]):
            raise ValueError("syntax error")
        else:
            raise ValueError("unknown operation")
    
    ## extract numbers
    for idx in range(2, len(answer_list)-1, 2):
        if re.fullmatch(r'^[-0-9]+$', answer_list[idx]):
            numbers.append(answer_list[idx])
        else:
            raise ValueError("syntax error")

    ## error check 
    if len(numbers) != len(operations)+1:
        raise ValueError("syntax error")
    
    ## prepare return
    output = numbers[0]
    del numbers[0]
    for idx in range(len(operations)):
        output = eval(str(output) + str(operations[idx]) + str(numbers[idx]))
    return int(output)

