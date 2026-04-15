printf "Choose either of these.\n\n1-Kanade\n2-Mafuyu\n3-Ena\n4-Mizuki\n5-N25 Miku\n"
read number

if [ "$number" == "1" ]; then
  DIRNAME="Kanade"
  NAME="KanadeXCursor"
elif [ "$number" == "2" ]; then
  DIRNAME="Mafuyu"
  NAME="MafuyuXCursor"
elif [ "$number" == "3" ]; then
  DIRNAME="Ena"
  NAME="EnaXCursor"
elif [ "$number" == "4" ]; then
  DIRNAME="Mizuki"
  NAME="MizukiXCursor"
elif [ "$number" == "5" ]; then
  DIRNAME="N25Miku"
  NAME="N25MikuXCursor"
else
  echo "Invalid input. Exiting..."
  exit
fi

printf "\nAlso create Hyprcursor icons? (true if yes)\n"
read hyprcursorEnable

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

mkdir -p ./$NAME/cursors
cat <<EOF >>./$NAME/index.theme
[Icon Theme]
Name = $NAME
Comment = A Linux port of $DIRNAME's cursor from Nightcord at 25:00.
Inherits = breeze_cursors
EOF

cd ./$DIRNAME/cursor
for cursor in "${set_cursors[@]}"; do
  xcursorgen $cursor.cursor $cursor
  mv $cursor ../../$NAME/cursors
done

cd ../../$NAME/cursors
for cursor in "${set_cursors[@]}"; do
  alias_name="${cursor//-/_}_alias[@]"
  for alias_cursor in "${!alias_name}"; do
    if [ "$alias_cursor" != "$cursor" ]; then
      ln -sf "$cursor" "$alias_cursor"
    fi
  done
done
echo "XCursor created!"

cd ../..
if [ "$hyprcursorEnable" == "true" ]; then
  hyprcursor-util -x $NAME --resize nearest
  hyprcursor-util -c "extracted_$NAME"
  mv theme_Extracted\ Theme "${DIRNAME}Hyprcursor"
  rm -r "extracted_$NAME"
  echo "Hyprcursor created!"
fi

printf "Check the output."
