{ config, pkgs, lib, unstable, static, ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
	ids = [ "*" ];
	settings = {
	  main = {
	    capslock = "lettermod(capslock,esc,150,200)";
	    leftshift = "layer(sl)";
	    rightshift = "layer(sr)";
	    space = "lettermod(vimesque,space,150,200)";
	    a = "lettermod(control,a,150,200)";
	    s = "lettermod(shift,s,150,200)";
	    d = "lettermod(alt,d,150,200)";
	    f = "lettermod(meta,f,150,200)";
	    j = "lettermod(meta,j,150,200)";
	    k = "lettermod(rightalt,k,150,200)";
	    l = "lettermod(shift,l,150,200)";
	    ";" = "lettermod(control,;,150,200)";
	    "leftshift+leftmeta+f23" = "layer(copilot)";
	  };

	  "rightalt:G" = {};

	  "sl:S" = {
	    rightshift = "capslock";
	  };

	  "sr:S" = {
	    leftshift = "capslock";
	  };

	  "copilot:C-A-S-M" = {};

	  "capslock:C" = {
	    ";" = "backspace";
	    space = "0";
	    m = "1";
	    "," = "2";
	    "." = "3";
	    j = "4";
	    k = "5";
	    l = "6";
	    u = "7";
	    i = "8";
	    o = "9";
	  };

	  vimesque = {
	    m = "playpause";
	    "." = "nextsong";
	    "," = "previoussong";
	    h = "left";
	    j = "down";
	    k = "up";
	    l = "right";
	    i = "home";
	    a = "end";
	    e = "C-right";
	    w = "C-left";
	    y = "macro(home S-end C-c)";
	    p = "C-v";
	    "/" = "C-f";
	    ";" = "C-A-t";
	    d = "macro(home S-end C-x backspace)";
	    enter = "compose";
	    g = "pageup";
	    f = "pagedown";
	    x = "delete";
	    u = "insert";
	    o = "macro(end enter)";
	    v = "macro(home S-end)";
	  };
	};
      };
      mouse = {
	ids = [ "32c2:0012" ];
	settings = {
	  main = {
	    "leftmouse+rightmouse" = "middlemouse";
	    "mouse1+mouse2" = "toggle(zeta)";
	    mouse1 = "overload(beta,mouse1)";
	    mouse2 = "overload(alpha,mouse2)";
	    middlemouse = "toggle(gamma)";
	  };

	  "alpha:M" = {
	    leftmouse = "C-insert";
	    rightmouse = "S-insert";
	    middlemouse = "M-q";
	  };

	  "beta:S" = {
	    leftmouse = "C-A-o";
	    rightmouse = "M-r";
	    middlemouse = "C-space";
	  };

	  "alpha+beta" = {
	    rightmouse = "M-S-r";
	  };

	  gamma = {
	    mouse1 = "overload(delta,mouse1)";
	    mouse2 = "overload(epsilon,mouse2)";
	  };

	  "delta:C-S" = {
	    leftmouse = "previoussong";
	    rightmouse = "nextsong";
	    mouse2 = "playpause";
	  };

	  "epsilon:M-C-A" = {
	    leftmouse = "mute";
	    rightmouse = "micmute";
	  };

	  zeta = {
	    mouse1 = "overload(eta,mouse1)";
	    mouse2 = "overload(theta,theta2)";
	  };

	  "eta:S" = {};
	  "theta:C" = {};
	};
      };
    };
  };
}
