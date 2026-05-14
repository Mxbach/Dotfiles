#!/usr/bin/env bash
# Claude Code statusLine command

input=$(cat)

# --- Directory ---
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
display_dir="${cwd/#$HOME/\~}"

# --- Git info ---
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
                 || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    git_dirty=$(git -C "$cwd" --no-optional-locks status --porcelain --ignore-submodules=dirty 2>/dev/null)
    [ -n "$git_dirty" ] && git_branch="${git_branch}*"
fi

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // ""')

# --- Context usage ---
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# --- Session usage (5-hour rate limit) ---
usage_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

# --- Build status line ---
parts=("$display_dir")

[ -n "$git_branch" ] && parts+=("[$git_branch]")
[ -n "$model" ]      && parts+=("$model")

if [ -n "$ctx_pct" ]; then
    parts+=("ctx:$(printf "%.0f" "$ctx_pct")%")
fi

if [ -n "$usage_pct" ]; then
    parts+=("usage:$(printf "%.0f" "$usage_pct")%")
fi

result=""
for part in "${parts[@]}"; do
    [ -z "$result" ] && result="$part" || result="$result  |  $part"
done

printf "%s" "$result"
