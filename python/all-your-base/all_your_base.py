def rebase(input_base, digits, output_base):
    ## error handling
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if any([digit < 0 or digit >= input_base for digit in digits]):
        raise ValueError("all digits must satisfy 0 <= d < input base")
    if output_base < 2:
        raise ValueError("output base must be >= 2")

    ## decode input to base 10
    number = sum([digit * input_base ** idx for idx, digit in enumerate(digits[::-1])])

    ## calculate number in output base
    output = []
    while number:
        number, remainder = divmod(number, output_base)
        output.append(remainder)

    return output[::-1] or [0]
    

