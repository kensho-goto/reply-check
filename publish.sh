#!/bin/zsh
# 返信の見比べページを kensho-goto の GitHub Pages に公開する（1回だけ）
set -e
cd "$(dirname "$0")"
T=$(env -u GITHUB_TOKEN gh auth token -u kensho-goto)
GH_TOKEN=$T gh repo create kensho-goto/reply-check --public --description "返信の見比べアンケート（試作）" >/dev/null
git remote add origin https://github.com/kensho-goto/reply-check.git 2>/dev/null || true
git -c credential.helper= -c "credential.helper=!f(){ echo username=kensho-goto; echo password=$T; }; f" push -q -u origin main
GH_TOKEN=$T gh api -X POST repos/kensho-goto/reply-check/pages -f "source[branch]=main" -f "source[path]=/" >/dev/null
echo "公開しました（1〜2分で開けます）: https://kensho-goto.github.io/reply-check/"
