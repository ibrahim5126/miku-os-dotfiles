USER_NAME_JP="${MIKU_USER_NAME_JP:-イブラヒム}"
USER_NAME_EN="${MIKU_USER_NAME_EN:-Ibrahim}"

# ===== MIKU TERMINAL PERSONALITY =====
MIKU_GREETS=(
  "「 こんにちは！おかえりなさい、${USER_NAME_JP}様！」 (Welcome back, ${USER_NAME_EN}-san!)"
  "「 今日も一緒に頑張りましょう！」 (Let's do our best today!)"
  "「 デバッグの時間だ！」 (Debugging time!)"
  "「 コーヒーブレイク要りますか？」 (Need a coffee break?)"
  "「 バグを潰しに行きましょう！」 (Let's go squash some bugs!)"
  "「 今日は何を作りますか？」 (What are we building today?)"
)

# Pick a random greeting
RANDOM_GREET="${MIKU_GREETS[$RANDOM % ${#MIKU_GREETS[@]}]}"
echo -e "\e[96m${RANDOM_GREET}\e[0m"

# Extract Japanese text inside 「 」 and voice it
JP_GREET=$(echo "$RANDOM_GREET" | sed -n 's/.*「 *\([^」]*\) *」.*/\1/p')
~/.local/bin/miku_speak.sh "$JP_GREET"

command_not_found_handle() {
    echo -e "\e[95m「 え？そんなコマンド知らない...${USER_NAME_JP}様、確認してください」\e[0m"
    echo "(Eh? I don't know that command... please double-check, ${USER_NAME_EN}-san)"
    ~/.local/bin/miku_speak.sh "え？そんなコマンド知らない、${USER_NAME_JP}様、確認してください"
    return 127
}

command_not_found_handler() {
    command_not_found_handle
}

exit() {
    if [ -z "$MIKU_EXIT_CONFIRM" ]; then
        echo -e "\e[96m「 本当に帰りますか？もう一度 exit と入力してください」\e[0m"
        echo "(Are you sure you want to leave? Type exit again to confirm)"
        ~/.local/bin/miku_speak.sh "本当に帰りますか？もう一度エグジットと入力してください"
        export MIKU_EXIT_CONFIRM=1
    else
        echo -e "\e[96m「 またね、${USER_NAME_JP}様！」\e[0m (See you again, ${USER_NAME_EN}-san!)"
        ~/.local/bin/miku_speak.sh "またね、${USER_NAME_JP}様！"
        sleep 1.2
        builtin exit
    fi
}
# ===== END MIKU TERMINAL PERSONALITY =====
