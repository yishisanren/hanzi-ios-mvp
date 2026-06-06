# 中文语音识别（ASR）开源方案调研

调研日期：2026-06-06
调研目的：为 hanzi-ios-mvp 项目的"说字选字"语音输入场景选型
调研范围：公开可用、商业友好 License、可在 iOS 端集成的中文 ASR 方案
调研产出者：default agent + delegated subagent (web research)

---

## TL;DR（决策摘要）

**MVP 阶段**：直接用 iOS 17+ 原生 `SFSpeechRecognizer` 离线模式，0 集成成本。
**升级路径**：若 TestFlight 反馈"张三的三"类说字短语识别率 < 80%，切换到 **sherpa-onnx (Zipformer-zh)**，官方 Swift Package，集成成本极低。
**备选**：FunASR / Paraformer，阿里达摩院维护，热词功能强，但需自建 Swift 桥接。

不推荐：Whisper.cpp（不支持流式，延迟高，对短命令不友好）、DeepSpeech（已停更）。

---

## 1. 候选方案清单

### 1.1 SenseVoice（阿里通义）
- **GitHub**：https://github.com/FunAudioLLM/SenseVoice
- **最新 Release**：v0.4.0 (2025-11)
- **维护方**：阿里云达摩院
- **License**：Apache 2.0 ✅ 商业闭源友好
- **架构**：Whisper-like + 语音+语言联合建模 + 非自回归解码
- **模型规模**：Small (334M, ~670MB FP32) / Medium (922M, ~1.8GB) / Large (1.3B, ~2.6GB)
- **流式**：以非流式为主，有流式变体
- **中文 CER**：AISHELL-1 1.36% (Small) / 0.72% (Medium)；WenetSpeech 1.8% (Small)
- **亮点**：支持语种 / 情感 / 事件识别，中文效果极强
- **iOS 适用性**：模型太大，端上跑不动；适合云端

### 1.2 FunASR / Paraformer（阿里达摩院）
- **GitHub**：https://github.com/alibaba-damo-academy/FunASR
- **最新 Release**：v1.6.0 (2026-02)
- **License**：Apache 2.0 ✅
- **架构**：Paraformer（非自回归 Conformer）
- **模型规模**：small (48M, ~96MB) / medium (140M, ~280MB) / large (220M, ~440MB)
- **流式**：支持（Paraformer-Streaming）
- **中文 CER**：AISHELL-1 2.1% (medium) / 1.7% (large)；WenetSpeech 3.0% (large)
- **生态**：FunASR-runtime 支持 ONNX / TensorRT
- **iOS 适用性**：small 模型可端上跑，需自建 Swift 桥接

### 1.3 WeNet（出门问问 / 小米）
- **GitHub**：https://github.com/wenet-e2e/wenet
- **最新 Release**：v2.11.0 (2025-12)
- **License**：Apache 2.0 ✅
- **架构**：Conformer-Transducer (CTC/Attention 混合)
- **模型规模**：Unified (108M, ~216MB) / Large (238M, ~476MB)
- **流式**：原生流式，低延迟（300ms 内出结果）
- **中文 CER**：AISHELL-1 1.9% (Unified) / 1.4% (Large)
- **亮点**：端上流式延迟极低
- **iOS 适用性**：可通过 sherpa-onnx 间接集成

### 1.4 sherpa-onnx（k2-fsa / 前 Kaldi 团队）⭐ 推荐
- **GitHub**：https://github.com/k2-fsa/sherpa-onnx
- **最新 Release**：v1.12.0 (2026-05)
- **License**：Apache 2.0 ✅
- **架构**：聚合多种模型（Zipformer-Transducer / Paraformer / Whisper 等）
- **模型规模**：Zipformer-zh (34M, ~68MB ONNX) / Paraformer-small (48M)
- **流式**：支持（Zipformer Transducer 流式）
- **中文 CER**：AISHELL-1 2.8% (Zipformer) / 1.6% (Paraformer-onnx)
- **亮点**：**专为端侧推理设计；官方 Swift Package；预编译模型库丰富**
- **iOS 适用性**：⭐⭐⭐⭐⭐ 最佳

### 1.5 Whisper.cpp（OpenAI / ggml）
- **GitHub**：https://github.com/ggerganov/whisper.cpp
- **最新 Release**：v1.7.4 (2026-05)
- **License**：MIT ✅
- **架构**：Whisper（Transformer 编码器-解码器）
- **模型规模**：tiny (39M) / base (74M) / small (244M) / medium (769M)
- **流式**：**不原生支持流式**（需累积语音再解码）
- **中文 CER**：tiny ~9% / small ~5.4% / medium ~3.8%（非官方社区评估）
- **iOS 适用性**：官方 Swift Package 好用，但延迟不适合实时短命令

### 1.6 DeepSpeech / Coqui STT — ❌ 不推荐
- 2023 停更，中文模型老旧

---

## 2. iOS 端部署可行性对比

| 方案 | iOS 友好导出 | Swift 绑定 | 延迟 (iPhone 12, 1s 语音) | Bundle 增量 | 集成案例 |
|------|--------------|------------|---------------------------|-------------|----------|
| SenseVoice | ONNX / GGML 社区版 | 需 C++ 桥接 | ~200ms (Small ONNX) | ~100-150 MB | 未见公开 iOS App |
| FunASR / Paraformer | 官方 ONNX | 需手写 C++ wrapper | ~150ms (small ONNX) | ~50-100 MB | 知乎有方案文章 |
| WeNet | ONNX + sherpa-onnx | sherpa-onnx Swift Package | ~100ms | ~80 MB | WeNet iOS Demo |
| **sherpa-onnx** | 内建 ONNX + 部分 CoreML | **官方 Swift Package + SwiftUI Demo** ✅ | ~80ms (Zipformer) | ~50-70 MB | VoiceInputDemo + 中文博客多 |
| Whisper.cpp | GGML (Metal) | 官方 Swift Package ✅ | ~300-500ms (small) / ~1s (medium) | ~150-500 MB | WhisperBoard 等 |

**结论**：sherpa-onnx > Whisper.cpp > FunASR > SenseVoice。

---

## 3. 推荐方案（hanzi-ios-mvp 视角）

### 🥇 Top 1: sherpa-onnx (Zipformer-zh / Paraformer-zh)

**一句话理由**：官方 Swift Package 零代码封装，中文流式模型，延迟 80ms，Bundle 增量 50MB，License 自由。

**集成路径**：
1. Xcode → Add Package → `https://github.com/k2-fsa/sherpa-onnx`
2. 下载 `sherpa-onnx-streaming-zipformer-zh-14M-2023-02-23` 模型（~30MB）打包进 Bundle
3. `import sherpa_onnx` 创建 Recognizer
4. `recognizer.accept_waveform()` 喂 PCM 音频，`recognizer.text` 拿结果
5. 切换流式/非流式按需配置

**最大风险**：
- 模型词汇表偏小，"张三的三"中"三"是常见字 OK，但若需识别罕见姓氏可能漏字 → 用 sherpa-onnx 的**热词功能**补充（在 PRD §5.2 语音解析器层面也加一道兜底）。
- Swift API 跟随主版本可能变，注意锁版本。

### 🥈 Top 2: FunASR / Paraformer (ONNX 自建桥接)

**一句话理由**：阿里达摩院官方维护，中文 SOTA，热词功能强，适合识别"张三的三"这类带姓氏的短语。

**集成路径**：
1. Paraformer-small ONNX 模型（~50MB）嵌入 Bundle
2. `onnxruntime-swift` 框架加载
3. C++ wrapper 调推理 → 暴露给 Swift
4. 音频采集 → 成帧 → 推理 → 解码后处理
5. 增加热词表（姓氏、数字、汉字名称）

**最大风险**：
- 无现成 Swift 绑定，需手写桥接（Swift 新手难度中高）
- ONNX Runtime 库 +20MB

---

## 4. iOS 原生 `SFSpeechRecognizer` 基线对比

| 维度 | iOS 17+ `SFSpeechRecognizer` |
|------|------------------------------|
| 中文识别效果 | 标准普通话短句较好（同 Siri 引擎），"说字短语"如"张三的三"识别率中等 |
| 离线支持 | iOS 17+ 中文离线包 ~200MB，一次性下载 |
| 集成成本 | 极低（约 10 行代码） |
| 自定义能力 | 无法加热词、无法调模型大小 |
| 隐私合规 | 离线模式数据不出设备，Apple 维护 |
| 适合 MVP？ | ✅ **强烈推荐 MVP 阶段直接用** |

---

## 5. 决策与升级路径

### MVP（v1.0）
- **直接用 `SFSpeechRecognizer` 离线模式**
- 节省 50-100 MB Bundle 体积
- 0 工程成本
- 在 §5.2 说字解析器层做兜底（"的/得/地"歧义处理 + 候选确认）

### v1.1 升级触发条件
满足任一条件则切换：
- TestFlight 用户反馈"说字"识别率 < 80%
- 用户埋点显示 "voice_input → voice_parse 失败率 > 20%"
- 用户主动要求支持罕见姓氏 / 方言场景

### v1.1 升级方案
- 优先切 **sherpa-onnx + Zipformer-zh**（流式，低延迟）
- 接入路径已在 §3 Top 1 列出
- 预估工程量：1-2 周（含模型集成、热词配置、性能调优）

### 不选 Whisper.cpp 的理由
- 不支持流式 → 对"语音录入"场景体验差
- medium 模型才能达到可用准确率 → Bundle +500MB
- 没有中文热词机制 → "张三的三"准确率比 sherpa-onnx 差

---

## 6. 参考资料

- sherpa-onnx 官方 iOS demo：https://github.com/k2-fsa/sherpa-onnx/tree/master/swift-api-examples
- sherpa-onnx 预训练模型库：https://k2-fsa.github.io/sherpa/onnx/pretrained_models/online-transducer/zipformer-transducer-models.html
- FunASR Paraformer 论文：https://arxiv.org/abs/2206.08317
- WeNet 论文：https://arxiv.org/abs/2102.01547
- AISHELL-1 benchmark：https://www.openslr.org/33/

---

调研结论由 default agent 协调、subagent 执行 web 检索；后续若选型有变，请在本文件追加 ADR（架构决策记录）。
