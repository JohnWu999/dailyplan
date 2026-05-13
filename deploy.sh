#!/bin/bash
# deploy.sh - 殷殷日课部署脚本
# 用法: ./deploy.sh

set -e

cd /home/agentuser/Workspace/dailyplan

echo "📦 正在部署到 118 服务器..."

# 1. Git add + commit
git add -A
git commit -m "$1" || echo "Nothing to commit"

# 2. Push to GitHub
git push origin main

# 3. Rsync to 118 server
rsync -avz --progress \
  -e "ssh -i /home/agentuser/.hermes/keys/leonardo.pem" \
  --exclude='deploy.sh' \
  --exclude='.git*' \
  ./index.html \
  root@118.25.80.19:/var/www/parent-workshop/yinyin-daily/

echo "✅ 部署完成! http://118.25.80.19/yy/"
