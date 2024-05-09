/// @description Insert description here
// You can write your code in this editor

if align == -1 baseX = -sprite_width/2;
if align == 0  baseX = 0;
if align == 1 baseX = sprite_width/2;
var displayTarget = baseX;
var loadingW = 16;
var loadingScale = loadingBlend * loadingW/sprite_get_width(loadingSymbol);

if state == TextState.LOADING {

	if align == -1 displayTarget += loadingW * 1.5;
	if align == 0 displayTarget += loadingW * 0.75;

}

angle += 10*dtime;

if displayText != text {
	displayAlpha = dtlerp(displayAlpha, 0, 0.4);
	if (displayAlpha < .001) displayText = text;
} else {
	displayAlpha = dtlerp(displayAlpha, text == "" ? 0 : alpha, .4);	
}

loadingBlend = dtlerp(loadingBlend, state == TextState.LOADING, .2);
successBlend = dtlerp(successBlend, state == TextState.SUCCESS, .2);
errorBlend = dtlerp(errorBlend, state == TextState.ERROR, .2);
displayX = dtlerp(displayX, displayTarget, 0.1);

var halign = fa_left;
if align == 0 halign = fa_center;
if align == 1 halign = fa_right;

var normalAlpha = displayAlpha * (1 - successBlend) * (1 - errorBlend);
var successAlpha = displayAlpha * successBlend * (1 - errorBlend);
var errorAlpha = displayAlpha * (1 - successBlend) * errorBlend;

var normalColor = c_white,
	redColor = #ff6947,
	greenColor = #73fc5b;
	
var sep = string_height("M") + .3,
	w = sprite_width/0.35;

var finalSize = size * .35;

draw_set_font(secondaryFont);
draw_set_valign(fa_middle)
draw_set_halign(halign);
draw_set_alpha(normalAlpha);
draw_set_color(normalColor);
draw_text_ext_transformed(x + displayX, y, displayText, sep, w, finalSize, finalSize, 0);

draw_set_color(greenColor);
draw_set_alpha(successAlpha);
draw_text_ext_transformed(x + displayX, y, displayText, sep, w, finalSize, finalSize, 0);

draw_set_color(redColor);
draw_set_alpha(errorAlpha);
draw_text_ext_transformed(x + displayX, y, displayText, sep, w, finalSize, finalSize, 0);

angle += 10*dtime;

var minW = min(w, string_width(displayText) * finalSize);
var displayLoading = displayTarget - loadingW;
if (align != -1) displayLoading -= minW/2;
if (align == 1) displayLoading -= minW/2;

draw_sprite_ext(loadingSymbol, 0, x + displayLoading, y, loadingScale, loadingScale, angle, normalColor, normalAlpha * loadingBlend)
draw_sprite_ext(loadingSymbol, 0, x + displayLoading, y, loadingScale, loadingScale, angle, greenColor, successAlpha * loadingBlend)
draw_sprite_ext(loadingSymbol, 0, x + displayLoading, y, loadingScale, loadingScale, angle, redColor, errorAlpha * loadingBlend)