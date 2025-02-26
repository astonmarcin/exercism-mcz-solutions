import re

math_operators = ['+', '-', '*', '/',]
manip_operators = ['dup', 'drop', 'swap', 'over',]
    

class StackUnderflowError(Exception):
    """Exception raised when Stack is not full.
       message: explanation of the error.
    """
    def __init__(self, message):
        self.message = message

def is_integer(word: str):
    """Checks if input string is an positive or negative integer

    Parameters
    ----------
    name : str
        String to check

    Returns
    ------
    bool
        True is word is positive or negative integer, False if not
    """
    if re.search("^-?[0-9]+$", word):
        return True
    return False

def replace_custom_words(data, custom_operations, result=[]):
    """Replaces custom operation words in imput data (if there is any) based on dict custom_operations

    Parameters
    ----------
    data : list
        input data to check
    custom_operations : dict
        dictionary with custom operation's definition
    result : list
        a var using in recurention to pass output value

    Returns
    ------
    list
        input data with replaced operation if there was any
    """
    if any(d in custom_operations.keys() for d in data):
        tmp = [
            subitem
            for d in data
            for subitem in custom_operations.get(d, [d])
        ]
        result = replace_custom_words(tmp, custom_operations)
    else:
        return data
    return result

def math_operation(data, result=0):
    """Doing math operation with forth valid command

    Parameters
    ----------
    data : list
        input data with numbers and math operations
    result : int
        a var using in recurention to pass output value

    Returns
    ------
    int
        a number which is result of calculations

    Raises
    ------
    StackUnderflowError("Insufficient number of items in stack")
        an error indicates that there is no sufficent numbers to do calculations
    ZeroDivisionError("divide by zero")
        when there is a dividing by zeor try
    """
    for idx, d in enumerate(data):
        operation = d[-1]
        numbers = list(map(int, d[:-1]))
        if len(numbers) < 2:
            raise StackUnderflowError("Insufficient number of items in stack")
        result = numbers[0]
        for number in numbers[1:]:
            if operation == "+":
                result += number
            if operation == "-":
                result -= number
            if operation == "*":
                result *= number
            if operation == "/":
                try:
                    result //= number
                except ZeroDivisionError as e:
                    raise ZeroDivisionError("divide by zero")
        if idx != len(data) - 1:
            del data[0]
            data[0].insert(0, result)
            result = math_operation(data, result)
    return result


def manip_operation(data, result=[]):
    """Doing data manipulations (such as duplication, swap, etc.) with forth valid command

    Parameters
    ----------
    data : list
        input data with numbers and data manipulation operations
    result : list
        a var using in recurention to pass output value

    Returns
    ------
    list
        a list of numbers after data manipulation operations

    Raises
    ------
    StackUnderflowError("Insufficient number of items in stack")
        an error indicates that there is no sufficent numbers to do data manipulations
    """
    for idx, d in enumerate(data):
        operation = d[-1]
        numbers = list(map(int, d[:-1]))
        if len(numbers) < 1 and operation in ["dup", "drop"]:
            raise StackUnderflowError("Insufficient number of items in stack")
        if len(numbers) < 2 and operation in ["swap", "over"]:
            raise StackUnderflowError("Insufficient number of items in stack")
        if operation == "dup":
            result = numbers + [numbers[-1]]
        if operation == "drop":
            result = numbers[:-1]
        if operation == "swap":
            result = numbers[:-2] + [numbers[-1], numbers[-2]]
        if operation == "over":
            result = numbers + [numbers[-2]]
        if idx != len(data) - 1:
            del data[0]
            data[0] = result + data[0]
            result = manip_operation(data, result)
    return result        
    



def evaluate(input_data):
    """main function that implements forth language

    Parameters
    ----------
    input_data : list
        list of forth commands

    Returns
    ------
    list
        a list of numbers after processing it with forth logic

    Raises
    ------
    ValueError
        raised when program detects not implemented or illegal operation
    """
    custom_operations = {}

    for data in input_data:
        data_splitted = [d.lower() for d in data.split(" ")]

        ## custom word definition - process it
        if data_splitted[0] == ":" and data_splitted[-1] == ";":
            name = data_splitted[1]
            body = replace_custom_words(data_splitted[2:-1], custom_operations)
            if is_integer(name):
                raise ValueError("illegal operation")
            if name not in custom_operations.keys():
                ## custom not yet added
                custom_operations[name] = body
            else:
                ## custom in dict, modify it
                custom_operations[name] = [
                    sub_item 
                    for item in body 
                    for sub_item in custom_operations.get(item, [item])
                ]
            continue

        ## if stack has a custom word - replace it with instructions
        data_splitted = replace_custom_words(data_splitted, custom_operations)

        ## stack has a math operation, do calculation
        if any(d in math_operators for d in data_splitted):
            ## extract indexes of math operators
            math_operators_idx = [-1] + [idx for idx, val in enumerate(data_splitted) if val in math_operators]
            ## split all calculation by above indexes
            math = [data_splitted[math_operators_idx[i-1]+1:math_operators_idx[i]+1] for i in range(1,len(math_operators_idx))]
            return [math_operation(math)]
        
        ## stack has manipulation operator, do it
        if any(d in manip_operators for d in data_splitted):
            ## extract indexes of manipulation operators
            manip_operators_idx = [-1] + [idx for idx, val in enumerate(data_splitted) if val in manip_operators]
            ## split all operations by above indexes
            manip = [data_splitted[manip_operators_idx[i-1]+1:manip_operators_idx[i]+1] for i in range(1, len(manip_operators_idx))]
            return manip_operation(manip)

        ## only integers, return them
        if all(is_integer(d) for d in data_splitted):
            return list(map(int, data_splitted))

        ## not matching to anything, throw error
        raise ValueError("undefined operation")