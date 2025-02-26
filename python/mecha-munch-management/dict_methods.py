"""Functions to manage a users shopping cart items."""


def add_item(current_cart: dict, items_to_add):
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    return {item: current_cart.get(item, 0) + items_to_add.count(item) for item in list(current_cart.keys()) + list(items_to_add)}


def read_notes(notes):
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    return {key: 1 for key in notes}


def update_recipes(ideas: dict, recipe_updates: dict):
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: dict - dictionary with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    return {recipe: update for recipe, update in tuple(ideas.items()) + recipe_updates }


def sort_entries(cart: dict):
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


def send_to_store(cart, aisle_mapping):
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    return dict(sorted({item: [cart[item]] + aisle_mapping[item] for item in cart.keys()}.items(), reverse=True))


def update_store_inventory(fulfillment_cart, store_inventory):
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """

    return {item: ["Out of Stock" if (new_amount := store_inventory[item][0] - fulfillment_cart.get(item, [0])[0]) <= 0 else new_amount] + store_inventory[item][1:] for item in store_inventory.keys() }
