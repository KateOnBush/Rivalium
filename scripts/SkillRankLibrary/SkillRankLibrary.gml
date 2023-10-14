#macro RankTierList global.__rank_tier_list

RankTierList = [

	"Unranked",
	"Novice",
	"Titanium",
	"Gold",
	"Platinum",
	"Amber",
	"Diamond",
	"Sentinel",
	"Mercenary",
	"Grand Rival"	

]

function rank_number_to_name(n) {

	return RankTierList[n];

}

function skill_tier_get_max_xp(tier) {

	return round(2000 * sqrt(tier) * log10(tier + 1));

}

function rank_division(tier, rating){

	if tier == 0 return "N/A"

	var _t = tier - 1;

	rating -= min(_t, 6) * 500;
	_t -= min(_t, 6);

	while(_t > 1) {
		rating -= 400;
		_t--;
	}
	
	if (tier > 6) return rating < 200 ? "B" : "A"
	else return rating < 150 ? "B" : (rating < 350 ? "M" : "A");

}