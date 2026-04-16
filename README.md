# NightcordCursors~
As you have probably guessed, this is an unofficial linux port for the members of N25, known as Nightcord at 25:00, from the rhythm game "HATSUNE MIKU: COLORFUL STAGE!"

The only reason I wanted to do this because of boredom-

## Notes
As of 16th April 2026, Only size `32` is supported for the XCursor version. The Hyprcursors, however, is supported from sizes `32 and above`. Anything below that would just crop the cursors, but to be honest who would be using the cursors at size `10`.

Hopefully the size 64 version of XCursor would be coming out, after I'm done with finals.

## Installation
### Preface:
There are four .tar files, which are the `Hyprcursor and Xcursor` versions of `Static & Animated` cursors, in which it includes the cursors of said members. You'll get it when you get to the [Releases Page](https://github.com/PixieXD/NightcordCursors/releases).

Another thing to know when applying the theme is that the [Cursor Name] has to be the exact name of the folder you moved to the `icons` folder. Eg. : `MizukiHyprcursor_animated` or `KanadeXcursor_static`.

### Moving the contents

1. Head over to the [Releases Page](https://github.com/PixieXD/NightcordCursors/releases) and download the .tar file. Extract it.
2. Move the contents to either `~/.local/share/icons` **(recommended)** or `~/.icons` 

Beyond this would be applying the cursor theme.

### Hyprland
Note that [`hyprcursor`](https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/) may need to be installed. Refer to your local package manager.

There are two ways :

- Set it with `hyprctl` :
```bash
hyprctl setcursor [Cursor Name] [Size]
```

- Set it with environment variables : **(Requires Hyprland to restart to take effect)**
```conf
env = HYPRCURSOR_THEME,[Cursor Name] # Or XCURSOR_THEME if you are using the Xcursor version
env = HYPRCURSOR_SIZE,[Size] # Or XCURSOR_Size, same reason
```

### Other DE/WMs
As stated before, the steps will depend on your DE/WMs. For example, on `KDE Plasma` it can be set through the appearance settings. Refer to your manual.

Although, this is possible by setting up environment variables, simply :
```bash
export XCURSOR_THEME=[Cursor Name]
export XCURSOR_THEME=[Size]
```

this *should* work.

## Special thanks
- [`BLZ_pixel`](https://x.com/blz_pixel) for the creation of the cursors. You rock!!
- [`Lilith_cursors by Hxprlee`](https://github.com/HxprLee/Lilith_cursors/) for the compiler as a reference, and as my previous used cursor :)
- [`win2xcur`](https://github.com/quantum5/win2xcur), [`hyprcursor-util`](https://github.com/hyprwm/hyprcursor/tree/main/hyprcursor-util) and [`imagemagick`](https://github.com/ImageMagick/ImageMagick) for making the port process a "tad bit" easier.
- My sanity for making this.