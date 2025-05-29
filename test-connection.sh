#!/bin/bash

# 测试 MCP 服务器连接
echo "正在测试 Composio MCP Server 连接..."

# 设置服务器 URL
SERVER_URL="https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e"

# 测试基本连接
echo "1. 测试基本连接:"
curl -I "$SERVER_URL" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ 服务器可达"
else
    echo "❌ 服务器不可达"
fi

# 测试 SSE 端点
echo "\n2. 测试 SSE 传输:"
curl -X GET "$SERVER_URL?transport=sse" \
  -H "Accept: text/event-stream" \
  -H "Cache-Control: no-cache" \
  --max-time 5 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ SSE 传输正常"
else
    echo "❌ SSE 传输异常"
fi

echo "\n测试完成。"