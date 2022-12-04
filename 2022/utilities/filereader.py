def read_input_file(filename, split = False):
    path = f"inputs/{filename}"
    f = open(path, "r")
    return f.read().splitlines() if split else f.read()

