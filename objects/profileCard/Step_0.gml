/// @description Insert description here
// You can write your code in this editor

user = UserData;

username = struct_get_key_failsafe(user, "username") ?? "N/A";
iconindex = struct_get_key_failsafe(user, "wardrobe.selectedIcon") ?? 0;

skilltier = struct_get_key_failsafe(user, "skill.tier") ?? 1;
skillxp = struct_get_key_failsafe(user, "skill.xp") ?? 0;
skillxpmax = skill_tier_get_max_xp(skilltier);

ranktier = struct_get_key_failsafe(user, "rank.tier") ?? 0;
rankrating = struct_get_key_failsafe(user, "rank.rating") ?? 0;

gold = struct_get_key_failsafe(user, "currency.gold") ?? 0;
amethyst = struct_get_key_failsafe(user, "currency.amethyst") ?? 0;
rivalite = struct_get_key_failsafe(user, "currency.rivalite") ?? 0;