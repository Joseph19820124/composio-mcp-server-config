# MCP Server Configuration Guide

## 概述

本指南将帮助你配置和使用 Composio MCP (Model Context Protocol) Server。MCP 是一个用于连接语言模型和外部工具/数据源的开放协议。

## 服务器信息

- **服务器URL**: `https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e`
- **传输方式**: Server-Sent Events (SSE)
- **协议**: MCP (Model Context Protocol)

## 前置要求

1. **Node.js** (版本 18 或更高)
2. **Claude Desktop** 或支持 MCP 的客户端
3. **Composio API 密钥** (如果需要)

## 配置步骤

### 1. 安装 MCP 客户端

```bash
npm install -g @modelcontextprotocol/cli
```

### 2. 配置 Claude Desktop

在 Claude Desktop 中配置 MCP server，编辑配置文件：

**macOS 路径**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows 路径**: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "composio": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-composio"
      ],
      "env": {
        "COMPOSIO_API_KEY": "your_composio_api_key_here"
      }
    }
  }
}
```

### 3. 使用 SSE 传输方式

如果你想直接连接到提供的服务器端点：

```json
{
  "mcpServers": {
    "composio-remote": {
      "command": "mcp-client",
      "args": [
        "--transport", "sse",
        "--url", "https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e?transport=sse"
      ]
    }
  }
}
```

### 4. 环境变量配置

创建 `.env` 文件来管理敏感信息：

```bash
# Composio API 配置
COMPOSIO_API_KEY=your_composio_api_key
COMPOSIO_BASE_URL=https://backend.composio.dev/api

# MCP Server 配置
MCP_SERVER_URL=https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e
MCP_TRANSPORT=sse
```

## 可用功能

Composio MCP Server 通常提供以下功能：

### 1. 应用集成
- **GitHub**: 代码仓库管理、PR 创建、Issue 跟踪
- **Gmail**: 邮件发送、收件箱管理
- **Google Calendar**: 事件创建、日程管理
- **Slack**: 消息发送、频道管理
- **Notion**: 页面创建、数据库操作

### 2. 工具调用
- 执行复杂的API调用
- 数据检索和处理
- 自动化工作流程

### 3. 身份验证
- OAuth 2.0 集成
- API 密钥管理
- 安全的凭据存储

## 使用示例

### 连接测试

```bash
# 测试服务器连接
curl -X GET "https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e/health" \
  -H "Accept: text/event-stream"
```

### 在 Claude 中使用

配置完成后，你可以在 Claude 中执行以下操作：

```
请帮我检查 GitHub 上的最新 pull requests
```

```
发送一封邮件给团队成员关于明天的会议
```

```
在我的 Google Calendar 中创建一个下周一的提醒
```

## 故障排除

### 常见问题

1. **连接失败**
   - 检查网络连接
   - 验证服务器URL是否正确
   - 确认API密钥有效

2. **权限错误**
   - 检查 Composio API 密钥权限
   - 验证应用授权状态

3. **配置问题**
   - 检查 JSON 配置文件语法
   - 验证环境变量设置

### 调试模式

启用详细日志记录：

```json
{
  "mcpServers": {
    "composio": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-composio",
        "--verbose"
      ],
      "env": {
        "COMPOSIO_API_KEY": "your_api_key",
        "DEBUG": "mcp:*"
      }
    }
  }
}
```

## 安全注意事项

1. **API 密钥安全**
   - 不要在代码中硬编码 API 密钥
   - 使用环境变量或安全的密钥管理系统

2. **网络安全**
   - 确保使用 HTTPS 连接
   - 验证服务器证书

3. **权限管理**
   - 仅授予必要的最小权限
   - 定期轮换 API 密钥

## 更新和维护

### 定期任务

1. **更新依赖包**
   ```bash
   npm update @modelcontextprotocol/server-composio
   ```

2. **检查服务器状态**
   ```bash
   curl -I https://mcp.composio.dev/composio/server/1139f902-0ed8-45db-b662-9a0d8a34016e
   ```

3. **清理日志文件**
   - 定期清理调试日志
   - 监控磁盘空间使用

## 资源链接

- [MCP 官方文档](https://modelcontextprotocol.io/)
- [Composio 文档](https://docs.composio.dev/)
- [Claude Desktop 配置指南](https://docs.anthropic.com/)

## 支持和反馈

如果遇到问题或需要帮助：

1. 检查官方文档
2. 查看 GitHub Issues
3. 联系 Composio 支持团队

---

**注意**: 请确保在生产环境中使用时遵循所有安全最佳实践，并定期更新配置以保持最新的安全标准。