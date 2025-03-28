def remove_keys(json_item, keys):
    for key in keys:
        json_item.pop(key, None)
    return json_item
