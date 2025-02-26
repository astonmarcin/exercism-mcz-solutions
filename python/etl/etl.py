def transform(legacy_data):
    return {elem.lower(): key for key, item in legacy_data.items() for elem in item}
