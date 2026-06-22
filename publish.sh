#!/usr/bin/env bash
# 一键更新 selection guide 预览站
# 用法:  ./publish.sh  [可选的提交说明]
# 站点:  https://marketing-cyber.github.io/selection-guide/

set -euo pipefail
cd "$(dirname "$0")"

MSG="${*:-update selection guide}"

# 没改动就别白跑
if git diff --quiet && git diff --cached --quiet && [ -z "$(git status --porcelain)" ]; then
  echo "✋ 没有改动,无需更新。"
  exit 0
fi

echo "📦 提交改动: $MSG"
git add -A
git -c user.email="marketing@wellforces.com" -c user.name="marketing-cyber" \
    commit -q -m "$MSG"

echo "🚀 推送到 GitHub..."
git push -q origin main

echo "✅ 已推送。GitHub Pages 约 1~2 分钟后自动更新。"
echo "🔗 https://marketing-cyber.github.io/selection-guide/"
