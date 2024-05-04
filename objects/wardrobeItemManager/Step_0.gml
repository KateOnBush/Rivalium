/// @description Insert description here
// You can write your code in this editor

if (mainPageManager.wardrobe_blend < 0.99) {
	with(wardrobeItem) {
		instance_destroy();
	}
	currentPage = -1;
	exit;
}

if currentPage != wardrobeManager.currentPage {
	
	with(wardrobeItem) {
		instance_destroy();
	}

	currentPage = wardrobeManager.currentPage;

	var items = undefined;

	switch(currentPage) {
		case WardrobePages.RIVAL: {
			items = struct_get_key_failsafe(userdata_get_self(), "inventory.characters");
			break;
		}
		case WardrobePages.AVATAR: {
			items = struct_get_key_failsafe(userdata_get_self(), "inventory.icons");
			break;
		}
	}
	
	if (!is_array(items)) exit;
	
	var dist = (bbox_right - bbox_left)/4, acc = 0, currentY = bbox_top;
	for(var i = 0; i < array_length(items); i++) {
		var currentItem = items[i];
		var createdItem = instance_create_layer(bbox_left + dist * acc + dist/2, currentY + dist/2, layer, wardrobeItem);
		acc++;
		if (acc == 4) currentY += dist;
		createdItem.itemId = currentItem;
		createdItem.type = currentPage;
	}

}