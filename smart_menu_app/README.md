# SmartMenu App

SmartMenu 是一个本地料理配方管理应用。V1.0 聚焦于一个核心能力：

> 在编辑配方时，用户修改一个参与比例计算的食材用量，保存后系统自动按比例重算其他参与计算的食材。

当前已完成 M1、M2、M3、M4、M5、M6 六个阶段，具体包括：

- Flutter 工程初始化
- Riverpod / go_router / Drift / Freezed / Decimal 依赖接入
- 分层目录结构
- 应用入口、路由和页面骨架
- 基础代码生成与静态检查配置
- `freezed` 领域模型与值对象
- Drift 数据库连接与代码生成
- `recipes`、`ingredients`、`cooking_steps` 表结构
- 配方、食材、步骤 DAO
- 配方仓储实现与数据映射
- 基于事务的整配方写入能力
- Decimal 解析、格式化与取整工具
- 配方保存校验与业务异常
- 新建、编辑保存、列表、详情、搜索、删除核心用例
- 编辑保存时的动态比例计算规则
- 列表、详情、新建、编辑页面与交互组件
- 核心计算、校验、仓储与数据库集成测试
- SQLite 外键约束与级联删除校验
- 基础页面联调与文档收尾
- Android 端 SQLite 启动链路修复，使用仓库内 `third_party/sqlite/` 源码本地编译
- 配方基础信息精简改造，移除分类与备注字段
- 详情页食材展示精简为名字、类型、用量、单位
- 新建/编辑页移除显式“调整基准”控件，改为修改可计算食材后自动联动重算

## 当前能力范围

当前工程已经具备：

- 可运行的 Flutter 应用骨架
- 配方、食材、步骤的数据持久化基础设施
- 配方列表查询、名称搜索、详情查询、保存、删除所需的数据访问接口
- 新建配方时仅校验与保存原始数据
- 编辑配方保存时自动识别比例变更并重算其他可计算食材
- “适量 / 少许 / 若干” 等描述性用量自动视为不可计算食材
- 配方列表页搜索、空状态、删除确认与详情跳转
- 配方详情页精简基础信息、食材与步骤展示、编辑入口
- 新建/编辑页共享表单、底部操作栏、保存反馈与食材联动重算交互

## 目录结构

```text
lib/
├── app/
├── core/
├── data/
├── domain/
└── presentation/
```

## 本地开发命令

```bash
flutter pub get
flutter run
dart run build_runner build
flutter analyze
flutter test
```

其中 Android 构建会直接使用仓库内的 `third_party/sqlite/sqlite-amalgamation-3500200/sqlite3.c`
生成本地 SQLite 动态库，不再依赖外网下载预编译二进制。

## PowerShell 脚本

仓库内提供了便于本地使用的脚本：

```powershell
./tool/build.ps1 pub-get
./tool/build.ps1 codegen
./tool/build.ps1 analyze
./tool/build.ps1 test
```

## 本次验证

已完成以下检查：

- `flutter analyze`
- `rg` 扫描确认 `Recipe` 的 `category/description` 读写链路已移除，仅保留数据库迁移语句
- 详情页与编辑页相关 Widget 测试已补充，覆盖精简展示与自动联动重算场景

当前环境缺少 Windows 本地 C 编译链，`flutter test` 会在 `sqlite3` native assets 构建阶段失败，因此本轮未能在本机完成自动化测试执行。
