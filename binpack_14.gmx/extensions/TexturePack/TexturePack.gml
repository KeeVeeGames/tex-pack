#define tex_page_init
// Generated at 2020-05-03 10:40:13 (230ms) for v1.4.1804+
//{ prototypes
globalvar mq_tex_entry; mq_tex_entry = [undefined, /* 1:x */0, /* 2:y */0, /* 3:width */0, /* 4:height */0, /* 5:orig_x */0, /* 6:orig_y */0, /* 7:a */undefined, /* 8:b */undefined, /* 9:custom */undefined];
globalvar mq_tex_page; mq_tex_page = [undefined, /* 1:width */0, /* 2:height */0, /* 3:root */undefined, /* 4:sprite */undefined, /* 5:sprites */undefined, /* 6:surface */undefined, /* 7:custom */undefined];
globalvar mq_tex_sprite; mq_tex_sprite = [undefined, /* 1:images */undefined, /* 2:count */0, /* 3:sprite */undefined, /* 4:custom */undefined];
globalvar mq_tex_std_haxe_class; mq_tex_std_haxe_class = [undefined, /* 1:marker */undefined, /* 2:index */0, /* 3:name */undefined, /* 4:superClass */undefined, /* 5:constructor */undefined];
//}
//{ metatype
globalvar tex_std_haxe_type_markerValue; tex_std_haxe_type_markerValue = [];
globalvar mt_tex_entry; mt_tex_entry = tex_std_haxe_class_create(7, "tex_entry");
globalvar mt_tex_page; mt_tex_page = tex_std_haxe_class_create(8, "tex_page");
globalvar mt_tex_sprite; mt_tex_sprite = tex_std_haxe_class_create(9, "tex_sprite");
globalvar mt_tex_std_haxe_class; mt_tex_std_haxe_class = tex_std_haxe_class_create(11, "tex_std_haxe_class");
//}

//{ tex_entry

#define tex_entry_create
// tex_entry_create(l_x:real, l_y:real, w:real, h:real)
var this = [mt_tex_entry];
array_copy(this, 1, mq_tex_entry, 1, 9);
this[@9/* custom */] = undefined;
this[@8/* b */] = undefined;
this[@7/* a */] = undefined;
this[@6/* orig_y */] = 0;
this[@5/* orig_x */] = 0;
this[@1/* x */] = argument[0];
this[@2/* y */] = argument[1];
this[@3/* width */] = argument[2];
this[@4/* height */] = argument[3];
return this;

#define tex_entry_insert
// tex_entry_insert(this:tex_entry, w:real, h:real, ox:real, oy:real)->TexEntry
var this = argument[0], w = argument[1], h = argument[2], ox = argument[3], oy = argument[4];
if (this[7/* a */] != undefined || this[8/* b */] != undefined) {
	var q;
	if (this[7/* a */] != undefined) {
		q = tex_entry_insert(this[7/* a */], w, h, ox, oy);
		if (q != undefined) return q;
	}
	if (this[8/* b */] != undefined) {
		q = tex_entry_insert(this[8/* b */], w, h, ox, oy);
		if (q != undefined) return q;
	}
	return undefined;
}
if (w > this[3/* width */]) return undefined;
if (h > this[4/* height */]) return undefined;
var qw = this[3/* width */] - w;
var qh = this[4/* height */] - h;
if (qw <= qh) {
	this[@7/* a */] = tex_entry_create(this[1/* x */] + w, this[2/* y */], qw, h);
	this[@8/* b */] = tex_entry_create(this[1/* x */], this[2/* y */] + h, this[3/* width */], qh);
} else {
	this[@7/* a */] = tex_entry_create(this[1/* x */], this[2/* y */] + h, w, qh);
	this[@8/* b */] = tex_entry_create(this[1/* x */] + w, this[2/* y */], qw, this[4/* height */]);
}
this[@3/* width */] = w;
this[@4/* height */] = h;
this[@5/* orig_x */] = ox;
this[@6/* orig_y */] = oy;
return this;

//}

//{ tex_page

#define tex_page_create
// tex_page_create(w:int, h:int)
var this = [mt_tex_page];
array_copy(this, 1, mq_tex_page, 1, 7);
var w = argument[0], h = argument[1];
this[@7/* custom */] = undefined;
this[@5/* sprites */] = [];
this[@4/* sprite */] = -1;
this[@1/* width */] = w;
this[@2/* height */] = h;
this[@3/* root */] = tex_entry_create(0, 0, w, h);
this[@6/* surface */] = surface_create(w, h);
surface_set_target(this[6/* surface */]);
draw_clear_alpha(0, 0);
surface_reset_target();
return this;

#define tex_page_destroy
// tex_page_destroy(this:tex_page)
var this = argument[0];
if (this[4/* sprite */] != -1) {
	sprite_delete(this[4/* sprite */]);
	this[@4/* sprite */] = -1;
	var _g = 0;
	var _g1 = this[5/* sprites */];
	while (_g < array_length_1d(_g1)) {
		var qs = _g1[_g];
		++_g;
		var i = 0;
		for (var _g11 = qs[2/* count */]; i < _g11; ++i) {
			tex_std_haxe_boot_wset(qs[1/* images */], i, undefined);
		}
	}
}
if (this[6/* surface */] != -1) {
	surface_free(this[6/* surface */]);
	this[@6/* surface */] = -1;
}

#define tex_page_add
// tex_page_add(this:tex_page, fname:string, imgNumb:int, ox:real, oy:real)->TexSprite
var this = argument[0], imgNumb = argument[2];
if (this[4/* sprite */] != -1) show_error("This texture page is already finalized", false);
var spr = sprite_add(argument[1], imgNumb, false, false, 0, 0);
if (spr == -1) return undefined;
var sw = sprite_get_width(spr);
var sh = sprite_get_height(spr);
var qs = tex_sprite_create(imgNumb);
draw_set_blend_mode_ext(bm_one, bm_zero);
surface_set_target(this[6/* surface */]);
var i = 0;
for (var _g1 = imgNumb; i < _g1; ++i) {
	var qe = tex_entry_insert(this[3/* root */], sw, sh, argument[3], argument[4]);
	tex_std_haxe_boot_wset(qs[1/* images */], i, qe);
	if (qe != undefined) draw_sprite(spr, 0, qe[1/* x */], qe[2/* y */]);
}
draw_set_blend_mode(bm_normal);
surface_reset_target();
sprite_delete(spr);
tex_std_haxe_boot_wset(this[5/* sprites */], array_length_1d(this[5/* sprites */]), qs);
return qs;

#define tex_page_finalize
// tex_page_finalize(this:tex_page)
var this = argument[0];
if (this[4/* sprite */] != -1) show_error("This texture page is already finalized", false);
var _this = this[6/* surface */];
this[@4/* sprite */] = sprite_create_from_surface(_this, 0, 0, surface_get_width(_this), surface_get_height(_this), false, false, 0, 0);
var i = 0;
for (var _g1 = array_length_1d(this[5/* sprites */]); i < _g1; ++i) {
	var qs = tex_std_haxe_boot_wget(this[5/* sprites */], i);
	qs[@3/* sprite */] = this[4/* sprite */];
}
surface_free(this[6/* surface */]);

//}

//{ tex_sprite

#define tex_sprite_create
// tex_sprite_create(count:int)
var this = [mt_tex_sprite];
array_copy(this, 1, mq_tex_sprite, 1, 4);
var count = argument[0];
this[@4/* custom */] = undefined;
this[@3/* sprite */] = -1;
this[@2/* count */] = count;
this[@1/* images */] = array_create(count, undefined);
return this;

#define tex_sprite_draw
// tex_sprite_draw(this:tex_sprite, subimg:real, l_x:real, l_y:real)
var this = argument[0];
var i = (argument[1] | 0) % this[2/* count */];
if (i < 0) i += this[2/* count */];
var e = tex_std_haxe_boot_wget(this[1/* images */], i);
if (e == undefined) return 0;
draw_sprite_part(this[3/* sprite */], 0, e[1/* x */], e[2/* y */], e[3/* width */], e[4/* height */], argument[2] - e[5/* orig_x */], argument[3] - e[6/* orig_y */]);

#define tex_sprite_draw_ext
// tex_sprite_draw_ext(this:tex_sprite, subimg:real, l_x:real, l_y:real, scaleX:real, scaleY:real, rot:real, col:Color, alpha:real)
var this = argument[0], scaleX = argument[4], scaleY = argument[5], rot = argument[6], col = argument[7];
var i = (argument[1] | 0) % this[2/* count */];
if (i < 0) i += this[2/* count */];
var e = tex_std_haxe_boot_wget(this[1/* images */], i);
if (e == undefined) return 0;
var rx = lengthdir_x(1, rot);
var ry = lengthdir_y(1, rot);
var ox = -e[5/* orig_x */] * scaleX;
var oy = -e[6/* orig_y */] * scaleY;
draw_sprite_general(this[3/* sprite */], 0, e[1/* x */], e[2/* y */], e[3/* width */], e[4/* height */], argument[2] + rx * ox - ry * oy, argument[3] + ry * ox + rx * oy, scaleX, scaleY, rot, col, col, col, col, argument[8]);

//}

//{ tex_std.haxe.class

#define tex_std_haxe_class_create
// tex_std_haxe_class_create(l_id:int, name:string, ?l_constructor:dynamic)
var this = ["mt_tex_std_haxe_class"];
array_copy(this, 1, mq_tex_std_haxe_class, 1, 5);
var l_constructor;
if (argument_count > 2) l_constructor = argument[2]; else l_constructor = undefined;
this[@4/* superClass */] = undefined;
this[@1/* marker */] = tex_std_haxe_type_markerValue;
this[@2/* index */] = argument[0];
this[@3/* name */] = argument[1];
this[@5/* constructor */] = l_constructor;
return this;

//}

//{ tex_std.haxe.boot

#define tex_std_haxe_boot_wget
// tex_std_haxe_boot_wget(arr:array<T>, index:int)->T
var arr = argument[0], index = argument[1];
return arr[index];

#define tex_std_haxe_boot_wset
// tex_std_haxe_boot_wset(arr:array<T>, index:int, value:T)
var arr = argument[0], index = argument[1];
arr[@index] = argument[2];

//}