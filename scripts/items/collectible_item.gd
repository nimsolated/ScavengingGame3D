class_name CollectibleItem extends Item

enum RARITY {COMMON = 0, UNCOMMON, RARE, EPIC, LEGENDARY, MYTHICAL}
@export var itemValue: int = 0
@export_range(0, 64, 1) var itemCount: int = 0
