# The PublicBodyCategories structure works like this:
# [
#   "Main category name",
#       [ "tag_to_use_as_category", "Sub category title", "sentence that can describes things in this subcategory" ],
#       [ "another_tag", "Second sub category title", "another descriptive sentence for things in this subcategory"],
#   "Another main category name",
#       [ "another_tag_2", "Another sub category title", "another descriptive sentence"]
# ])
#
# DO NOT EDIT THIS FILE! It should be overridden in a custom theme.
# See doc/THEMES.md for more info

PublicBodyCategories.add(:he, [
    "תחומים",
        [ "security", "חוץ ובטחון", "חוץ ובטחון" ],
        [ "law", "חוק ומשפט", "חוק ומשפט"],
        [ "economy", "כלכלה", "כלכלה"],
        [ "transportation", "תחבורה ותשתיות", "תחבורה ותשתיות"],
        [ "education", "תרבות וחינוך", "תרבות וחינוך"],
        [ "religion", "דת", "דת"],
        [ "communication", "תקשורת", "תקשורת"],
        [ "welfare", "רווחה וחברה", "רווחה וחברה"],
        [ "health", "בריאות", "בריאות"],
        [ "environment", "מדע וסביבה", "מדע וסביבה"],
        [ "government", "ממשל", "ממשל"],
    "אזורים",
        [ "north", "צפון", "צפון"],
        [ "center", "מרכז", "מרכז"],
        [ "south", "דרום", "דרום"]
])
