"""Functions to keep track and alter inventory."""


def create_inventory(items):
    """Create a dict that tracks the amount (count) of each element on the `items` list.

    :param items: list - list of items to create an inventory from.
    :return: dict - the inventory dictionary.
    """

    return {item: items.count(item) for item in items}



def add_items(inventory, items):
    """Add or increment items in inventory using elements from the items `list`.

    :param inventory: dict - dictionary of existing inventory.
    :param items: list - list of items to update the inventory with.
    :return: dict - the inventory updated with the new items.
    """

    new_items = create_inventory(items)
    
    ## readable way
    #output = {}
    #for item in set(inventory.keys()).union(new_items.keys()):
    #    output[item] = inventory.get(item, 0) + new_items.get(item,0)
    #return output

    ## one liner
    return {item: inventory.get(item, 0) + new_items.get(item, 0) for item in set(inventory.keys()).union(new_items.keys())}


def decrement_items(inventory, items):
    """Decrement items in inventory using elements from the `items` list.

    :param inventory: dict - inventory dictionary.
    :param items: list - list of items to decrement from the inventory.
    :return: dict - updated inventory with items decremented.
    """

    new_items = create_inventory(items)
    
    ## readable way
    #output = {}
    #for item in inventory.keys():
    #    difference = inventory.get(item, 0) - new_items.get(item,0)
    #    if difference >= 0:
    #        output[item] = difference
    #    else:
    #        output[item] = 0
    #return output

    ## one liner
    return {item: inventory.get(item, 0) - new_items.get(item, 0)  if inventory.get(item, 0) - new_items.get(item, 0) >= 0 else 0 for item in inventory.keys()}


def remove_item(inventory: dict, item):
    """Remove item from inventory if it matches `item` string.

    :param inventory: dict - inventory dictionary.
    :param item: str - item to remove from the inventory.
    :return: dict - updated inventory with item removed. Current inventory if item does not match.
    """

    ## readable way
    #inventory.pop(item, 0)
    #return inventory

    ## one liner
    return {name: amount for name, amount in inventory.items() if name != item}


def list_inventory(inventory):
    """Create a list containing only available (item_name, item_count > 0) pairs in inventory.

    :param inventory: dict - an inventory dictionary.
    :return: list of tuples - list of key, value pairs from the inventory dictionary.
    """

    return [(name, amount) for name, amount in inventory.items() if amount > 0]