# Vtoray代理服务器

用于PaaS平台的 VToRay 代理服务器Docker镜像。

## 🚀 PaaS平台部署

### 环境变量

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| `UUID` | 客户端标识 | `a6a45391-31fe-4bdd-828c-51f02c943dce` |
| `WS_PATH` | WebSocket路径 | `/ws-vserver` |
| `PORT` | 服务器端口 | `8080` |

### 安全特性

- ✅ 非root用户运行
- ✅ 日志完全屏蔽
- ✅ 关键词规避
- ✅ 环境变量配置

## 📁 文件说明

- `Dockerfile` - Docker构建配置
- `start.sh` - 启动脚本，使用envsubst处理配置模板
- `config.template.json` - 配置文件模板，包含环境变量占位符
- `.dockerignore` - Docker构建忽略文件