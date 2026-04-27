# cursors
set_cursors=("not-allowed" "default" "row-resize" "col-resize" "nw-resize" "ne-resize" "crosshair" "all-scroll" "pencil" "help" "pointer" "text" "wait" "progress" "up-arrow" "man")

# Alias for set_cursors
not_allowed_alias=("X_cursor" "no-drop" "dnd-no-drop")
default_alias=("arrow" "left_ptr" "right_ptr" "dnd-move" "dnd-copy" "dnd-link")
row_resize_alias=("based_arrow_down" "bottom_side" "bottom_tee" "double_arrow" "sb_down_arrow" "sb_up_arrow" "sb_v_double_arrow" "top_side" "top_tee" "n-resize" "s-resize" "ns-resize")
col_resize_alias=("left_side" "right_side" "right_tee" "sb_h_double_arrow" "sb_left_arrow" "sb_right_arrow" "e-resize" "w-resize" "ew-resize")
nw_resize_alias=("bottom_right_corner" "lr_angle" "top_left_arrow" "top_left_corner" "ul_angle" "se-resize" "nwse-resize")
ne_resize_alias=("bottom_left_corner" "ll_angle" "top_right_corner" "ur_angle" "sw-resize" "nesw-resize")
crosshair_alias=("cross" "cross_reverse" "crosshair" "diamond_cross" "plus" "target" "tcross")
all_scroll_alias=("fleur")
pencil_alias=("spraycan")
help_alias=("question_arrow" "context-menu")
pointer_alias=("hand1" "hand2")
text_alias=("xterm" "vertical-text")
wait_alias=("watch")
up_arrow_alias=("center_ptr")

printf "Choose either of the characters.\n[1]Kanade [2]Mafuyu [3]Ena [4]Mizuki [5]N25 Miku -- "
read -r character

if [ $character == 1 ]; then
  NAME="Kanade"
elif [ $character == 2 ]; then
  NAME="Mafuyu"
elif [ $character == 3 ]; then
  NAME="Ena"
elif [ $character == 4 ]; then
  NAME="Mizuki"
elif [ $character == 5 ]; then
  NAME="N25Miku"
else
  printf "\nInvalid input. Exiting..."
  exit
fi

printf "\nStatic or Animated?\n[1]Static [2]Animated -- "
read -r imgFormat

printf "\nXCursor only?\n[1]Hyprcursor [2]Both -- "
read -r cursorFormat

printf "\nCompress into tar?\n[y]Yes / [n]No -- "
read -r tarCompress

DESCRIPTION="A Linux port of ${NAME}'s cursor from Nightcord at 25:00."

if [ $imgFormat == 1 ]; then
  FORMAT="animated"
elif [ $imgFormat == 2 ]; then
  FORMAT="static"
fi

mkdir -p ./${NAME}Xcursor_${FORMAT}/cursors
cat <<EOF >>./${NAME}Xcursor_${FORMAT}/index.theme
[Icon Theme]
Name = ${NAME}Xcursor_${FORMAT}
Comment = $DESCRIPTION
Inherits = breeze_cursors
EOF

cd ./cursors/${FORMAT}/${NAME}/cursor
for cursor in "${set_cursors[@]}"; do
  xcursorgen $cursor.cursor $cursor
  mv $cursor ../../../../${NAME}Xcursor_${FORMAT}/cursors
done

cd ../../../../${NAME}Xcursor_${FORMAT}/cursors
for cursor in "${set_cursors[@]}"; do
  alias_name="${cursor//-/_}_alias[@]"
  for alias_cursor in "${!alias_name}"; do
    if [ "$alias_cursor" != "$cursor" ]; then
      ln -sf "$cursor" "$alias_cursor"
    fi
  done
done
echo "\nXCursor created...\n"

cd ../..
if [ $imgFormat == 1 ] || [ $imgFormat == 2 ]; then
  hyprcursor-util -x ${NAME}Xcursor_${FORMAT} --resize nearest
  hyprcursor-util -c "extracted_${NAME}Xcursor_${FORMAT}"
  mv theme_Extracted\ Theme "${NAME}Hyprcursor_${FORMAT}"
  rm -r "extracted_${NAME}Xcursor_${FORMAT}"
  cat >./${NAME}Hyprcursor_${FORMAT}/manifest.hl <<EOF
name = ${NAME}Hyprcursor_${FORMAT}
desciption = $DESCRIPTION
version = 0.1
cursors_directory = hyprcursors
EOF
  printf "\nHyprcursor created...\n"
fi

if [ $imgFormat == 1 ]; then
  rm -r ./${NAME}Xcursor_${FORMAT}
  printf "Xcursor Deleted...\n"
fi

if [ "${tarCompress}" == "y" ]; then
  tar -czvf ${NAME}Cursors.tar.gz ./${NAME}*
  rm -r ./${NAME}{X,Hypr}cursor_${FORMAT}
  printf "Created tar archive... Cleaning up..."
fi

printf "\n\nDone! Check the output~"
