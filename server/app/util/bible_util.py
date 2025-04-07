import re

def remove_keys(json_item, keys):
    for key in keys:
        json_item.pop(key, None)
    return json_item

def text_to_html(text):
    text = re.sub(r"\[(\d+)\]", r"<sup>\1</sup>", text)

    sections = text.split("\n")
    for i in range(len(sections)):
        section_text = sections[i].strip()
        sections[i] = r"<p>" + section_text + r"</p>"

    return ''.join(sections)