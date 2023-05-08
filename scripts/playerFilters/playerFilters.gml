function Filter(asprite, adepth, aalpha) constructor{

	sprite = asprite;
	depth = adepth;
	alpha = 0;
	maxalpha = aalpha;
	removing = false;

}

function addFilter(filter, depth, maxalpha){

	var f = new Filter(filter, depth, maxalpha);

	if !array_contains_compare(filters, f, function(a, b){ if a.sprite == b.sprite return true; return false;}){
	
		array_push(filters, f);
	
	}
	
	array_sort(filters, function(a, b){ return b.depth - a.depth; })

}

function removeFilter(filter){

	var struct = {filter: filter};
	var ind = array_find_by_function(filters, method(struct, function(a){ return a.sprite == filter; }));
	if ind != -1 filters[ind].removing = true;

}