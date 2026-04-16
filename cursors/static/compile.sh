printf "Choose either of these.\n\n1-Kanade\n2-Mafuyu\n3-Ena\n4-Mizuki\n5-N25 Miku\n"
read number

if [ "$number" == "1" ]; then
  DIRNAME="Kanade"
  NAME="KanadeXcursor"
elif [ "$number" == "2" ]; then
  DIRNAME="Mafuyu"
  NAME="MafuyuXcursor"
elif [ "$number" == "3" ]; then
  DIRNAME="Ena"
  NAME="EnaXcursor"
elif [ "$number" == "4" ]; then
  DIRNAME="Mizuki"
  NAME="MizukiXcursor"
elif [ "$number" == "5" ]; then
  DIRNAME="N25Miku"
  NAME="N25MikuXcursor"
else
  echo "Invalid input. Exiting..."
  exit
fi

printf "\nAlso create Hyprcursor icons? (true if yes)\n"
read hyprcursorEnable

DESCRIPTION="A Linux port of $DIRNAME's cursor from Nightcord at 25:00."

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

mkdir -p ./${NAME}_static/cursors
cat <<EOF >>./${NAME}_static/index.theme
[Icon Theme]
Name = ${NAME}_static
Comment = $DESCRIPTION
Inherits = breeze_cursors
EOF

cd ./$DIRNAME/cursor
for cursor in "${set_cursors[@]}"; do
  xcursorgen $cursor.cursor $cursor
  mv $cursor ../../${NAME}_static/cursors
done

cd ../../${NAME}_static/cursors
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
  hyprcursor-util -x ${NAME}_static --resize nearest
  hyprcursor-util -c "extracted_${NAME}_static"
  mv theme_Extracted\ Theme "${DIRNAME}Hyprcursor_static"
  rm -r "extracted_${NAME}_static"
  cat > ./${DIRNAME}Hyprcursor_static/manifest.hl << EOF
name = ${DIRNAME}Hyprcursor_static
desciption = $DESCRIPTION
version = 0.1
cursors_directory = hyprcursors
EOF
  echo "Hyprcursor created!"
fi

echo "Check the output."
