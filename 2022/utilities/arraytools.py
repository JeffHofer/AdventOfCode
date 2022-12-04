# Parses a string array to an int array
def parse_to_int_array(string_array):
    return [int(i) for i in string_array]


# Takes a list that represents groupings of values separated by a distinct line
# Returns a list of lists, where each element list represents a group from the original list
def split_segmented_list(list, separator):
    bundled_list = []
    current_list = []
    for i in list:
        if i == separator:
            bundled_list.append(current_list)
            current_list = []
        else:
            current_list.append(i)
    bundled_list.append(current_list)
    return bundled_list


# Takes an int list and returns a list containing the n largest elements, where n is num_of_elements
def find_largest_elements(list, num_of_elements):
    return sorted(list)[-num_of_elements:]
