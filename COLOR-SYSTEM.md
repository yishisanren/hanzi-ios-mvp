# 声笔 ToneStroke 色彩系统

> 版本：v1.0 · 日期：2026-06-06  
> 基础色锁定自 PRD §8，扩展为完整设计 token 体系  
> 适用：iOS App 工程（SwiftUI + CSS 原型）

---

## 1. 基础色（PRD 锁定，不可改）

| 名称 | 色值 | 用途 |
|------|------|------|
| 主墨黑 | `#141414` | 正文、汉字主体、主线条 |
| 朱砂红 | `#D93A2E` | 主要行动、声调标记、当前笔画反馈 |
| 宣纸白 | `#F6F1E6` | 主背景、大面积留白 |
| 暖灰 | `#A8A099` | 辅助色、次级元素 |

---

## 2. 完整 Token 体系（Light Mode）

### 背景层

| Token | 色值 | 用途 |
|-------|------|------|
| `--bg-primary` | `#F6F1E6` | 宣纸白，主背景 |
| `--bg-secondary` | `#EEE8DA` | 卡片 / 列表底，宣纸白略深 |
| `--bg-tertiary` | `#E5DDCB` | 输入框 / 练习格底，更深一层 |

### 文字层

| Token | 色值 | 用途 |
|-------|------|------|
| `--ink-primary` | `#141414` | 主墨黑，正文 / 汉字主体 |
| `--ink-secondary` | `#55504B` | 次级文字，副标题 / 拼音 |
| `--ink-tertiary` | `#7E766D` | 占位符 / 提示文字 |

### 强调 / 行动色

| Token | 色值 | 用途 |
|-------|------|------|
| `--accent-primary` | `#D93A2E` | 朱砂红，主按钮 / 声调 / 当前笔画 |
| `--accent-hover` | `#C43328` | hover / 高亮态 |
| `--accent-pressed` | `#AD2C22` | 按下态 |

### 线条 / 分隔

| Token | 色值 | 用途 |
|-------|------|------|
| `--stroke-grid` | `#C8C0B6` | 练习格线，暖灰更淡 |
| `--stroke-divider` | `#E0DAD0` | 分隔线，极淡 |
| `--stroke-grid-accent` | `#D93A2E` | 朱砂红格线，当前练习格高亮 |

### 状态色

| Token | 色值 | 用途 |
|-------|------|------|
| `--state-success` | `#588157` | 练习完成 / 正确 |
| `--state-warning` | `#A86532` | 提示信息 |
| `--state-error` | `#C62828` | 错误笔画 / 输入错误 |

### 阴影

| Token | 值 | 用途 |
|-------|-----|------|
| `--shadow-card` | `0 2px 8px rgba(20,20,20,0.08)` | 卡片阴影 |
| `--shadow-modal` | `0 8px 32px rgba(20,20,20,0.16)` | Modal / Sheet 阴影 |

---

## 3. 完整 Token 体系（Dark Mode）

### 映射规则（参考 PRD §13）

| 基础色 | 映射方向 |
|--------|----------|
| 主墨黑 `#141414` | → 宣纸白 `#F6F1E6`（作为前景文字） |
| 宣纸白 `#F6F1E6` | → 深灰 `#1A1A1A`（作为背景） |
| 朱砂红 `#D93A2E` | **不变**（强调色双模式可见） |
| 暖灰 `#A8A099` | → `#5C5550`（练习格线） |

### 背景层

| Token | 色值 | 用途 |
|-------|------|------|
| `--bg-primary` | `#1A1A1A` | 深灰主背景 |
| `--bg-secondary` | `#242424` | 卡片底，略浅 |
| `--bg-tertiary` | `#2C2C2C` | 输入框 / 练习格底 |

### 文字层

| Token | 色值 | 用途 |
|-------|------|------|
| `--ink-primary` | `#F6F1E6` | 宣纸白，正文 |
| `--ink-secondary` | `#C8C0B6` | 次级文字，偏淡 |
| `--ink-tertiary` | `#8A8278` | 占位符 / 提示 |

### 强调 / 行动色

| Token | 色值 | 用途 |
|-------|------|------|
| `--accent-primary` | `#D93A2E` | 朱砂红不变 |
| `--accent-hover` | `#E54A3E` | hover 态（暗背景上需更亮） |
| `--accent-pressed` | `#BF2E22` | 按下态 |

### 线条 / 分隔

| Token | 色值 | 用途 |
|-------|------|------|
| `--stroke-grid` | `#5C5550` | 练习格线，暖灰深化 |
| `--stroke-divider` | `#3A3530` | 分隔线 |
| `--stroke-grid-accent` | `#D93A2E` | 当前格高亮 |

### 状态色

| Token | 色值 | 用途 |
|-------|------|------|
| `--state-success` | `#6AAF6A` | 亮绿，暗背景可见 |
| `--state-warning` | `#E0A060` | 亮橙 |
| `--state-error` | `#EF5350` | 亮红 |

### 阴影

| Token | 值 | 用途 |
|-------|-----|------|
| `--shadow-card` | `0 2px 8px rgba(0,0,0,0.40)` | 卡片阴影（暗模式更浓） |
| `--shadow-modal` | `0 8px 32px rgba(0,0,0,0.60)` | Modal 阴影 |

---

## 4. 使用规则

### 4.1 层级原则

```
ink-primary ────── 正文、汉字笔画、标题（最高优先级）
ink-secondary ──── 拼音标注、副标题、说明文字
ink-tertiary ───── 占位符文本、不可用状态信息

bg-primary ─────── 最底层背景
bg-secondary ───── 卡片、列表行
bg-tertiary ────── 输入框、练习格（最上层背景）

accent ─────────── 仅用于行动意图和声调/笔画反馈
state-* ────────── 仅用于练习结果反馈
```

### 4.2 重点色使用约束

- **朱砂红面积 ≤ 15%**：只用于按钮、声调标记、当前笔画高亮。不要大面积填充背景。
- **朱砂红不可做正文**：正文必须用 `ink-primary`（Light: `#141414`, Dark: `#F6F1E6`）。
- **主按钮**：朱砂红填充 + 白字（`#FFFFFF`），WCAG AA 通过（4.57:1）。
- **次要按钮**：描边朱砂红或暖灰，文字用 `accent-primary` 或 `ink-secondary`。

### 4.3 不要这样做（Don'ts）

1. **不要用暖灰做正文**——Light 模式下暖灰 `#A8A099` 在宣纸白上仅 2.29:1，不满足 WCAG AA 最低要求（即使 `#7E766D` 也仅为 Large Text 可用）。正文必须使用 `ink-primary`。
2. **不要让朱砂红面积超过 15%**——过量的红色会导致视觉疲劳，冲淡其作为「行动 / 声调 / 笔画反馈」的信号价值。
3. **不要在 Dark 模式下用纯白 `#FFFFFF` 替代宣纸白 `#F6F1E6`**——宣纸白带暖调（R=246, G=241, B=230），与深灰背景配合更舒适，纯白在暗环境下过于刺眼。

### 4.4 练习格与笔画反馈

| 场景 | 使用 Token |
|------|-----------|
| 默认练习格线 | `--stroke-grid` |
| 当前练习格边框 | `--stroke-grid-accent`（朱砂红） |
| 分隔两个字的画布 | `--stroke-divider` |
| 笔画正确完成 | `--state-success`（浅绿背景或绿勾） |
| 笔画错误 | `--state-error`（红色笔迹或边框） |
| 提示动画 | `--accent-primary`（闪烁或轨迹线） |

---

## 5. Light ↔ Dark 双模式映射表

| Token | Light Mode | Dark Mode | 映射规则 |
|-------|-----------|-----------|----------|
| `--bg-primary` | `#F6F1E6` | `#1A1A1A` | 宣纸白 → 深灰反转 |
| `--bg-secondary` | `#EEE8DA` | `#242424` | 双层递进 |
| `--bg-tertiary` | `#E5DDCB` | `#2C2C2C` | 双层递进 |
| `--ink-primary` | `#141414` | `#F6F1E6` | 墨黑 ↔ 宣纸白反转 |
| `--ink-secondary` | `#55504B` | `#C8C0B6` | 等比反转 |
| `--ink-tertiary` | `#7E766D` | `#8A8278` | 暖灰深化后提亮 |
| `--accent-primary` | `#D93A2E` | `#D93A2E` | **不变** |
| `--accent-hover` | `#C43328` | `#E54A3E` | 暗背景 hover 需更亮 |
| `--accent-pressed` | `#AD2C22` | `#BF2E22` | 暗背景按下略提亮 |
| `--stroke-grid` | `#C8C0B6` | `#5C5550` | 暖灰深化 |
| `--stroke-divider` | `#E0DAD0` | `#3A3530` | 等比深化 |
| `--state-success` | `#588157` | `#6AAF6A` | 暗背景提亮 |
| `--state-warning` | `#A86532` | `#E0A060` | 暗背景提亮 |
| `--state-error` | `#C62828` | `#EF5350` | 暗背景提亮 |
| `--shadow-card` | `rgba(20,20,20,0.08)` | `rgba(0,0,0,0.40)` | 暗模式阴影更浓 |
| `--shadow-modal` | `rgba(20,20,20,0.16)` | `rgba(0,0,0,0.60)` | 暗模式阴影更浓 |

---

## 6. WCAG AA 对比度验证

### 6.1 Light Mode 对比度矩阵

行 = 文字 / 前景色 token · 列 = 背景色 token  
单元格 = 对比度比值 + AA / LG / FAIL

| FG \ BG | `bg-primary` `#F6F1E6` | `bg-secondary` `#EEE8DA` | `bg-tertiary` `#E5DDCB` |
|---------|-----------------------|-------------------------|-------------------------|
| `ink-primary` `#141414` | **16.36:1 ✅ AA** | **15.08:1 ✅ AA** | **13.63:1 ✅ AA** |
| `ink-secondary` `#55504B` | **7.07:1 ✅ AA** | **6.52:1 ✅ AA** | **5.90:1 ✅ AA** |
| `ink-tertiary` `#7E766D` | **3.97:1 ✅ LG** | **3.66:1 ✅ LG** | **3.31:1 ✅ LG** |
| `accent-primary` `#D93A2E` | **4.06:1 ✅ LG** | **3.74:1 ✅ LG** | **3.38:1 ✅ LG** |
| `state-success` `#588157` | **3.97:1 ✅ LG** | **3.66:1 ✅ LG** | **3.31:1 ✅ LG** |
| `state-warning` `#A86532` | **4.08:1 ✅ LG** | **3.76:1 ✅ LG** | **3.40:1 ✅ LG** |
| `state-error` `#C62828` | **4.99:1 ✅ AA** | **4.60:1 ✅ AA** | **4.16:1 ✅ LG** |

> ✅ AA = WCAG AA 正文通过（≥4.5:1）  
> ✅ LG = WCAG AA 大字号通过（≥3:1）  
> 注释：`ink-tertiary`、`accent-primary`、`state-success`、`state-warning` 为大字号 / 装饰性用途，满足大字号 AA 标准。正文层级（`ink-primary`、`ink-secondary`）全部通过 AA 正文标准。

### 6.2 Dark Mode 对比度矩阵

| FG \ BG | `bg-primary` `#1A1A1A` | `bg-secondary` `#242424` | `bg-tertiary` `#2C2C2C` |
|---------|-----------------------|-------------------------|-------------------------|
| `ink-primary` `#F6F1E6` | **15.45:1 ✅ AA** | **13.78:1 ✅ AA** | **12.40:1 ✅ AA** |
| `ink-secondary` `#C8C0B6` | **9.67:1 ✅ AA** | **8.63:1 ✅ AA** | **7.76:1 ✅ AA** |
| `ink-tertiary` `#8A8278` | **4.60:1 ✅ AA** | **4.10:1 ✅ LG** | **3.69:1 ✅ LG** |
| `accent-primary` `#D93A2E` | **3.81:1 ✅ LG** | **3.40:1 ✅ LG** | **3.06:1 ✅ LG** |
| `state-success` `#6AAF6A` | **6.59:1 ✅ AA** | **5.88:1 ✅ AA** | **5.29:1 ✅ AA** |
| `state-warning` `#E0A060` | **7.76:1 ✅ AA** | **6.92:1 ✅ AA** | **6.23:1 ✅ AA** |
| `state-error` `#EF5350` | **4.99:1 ✅ AA** | **4.45:1 ✅ LG** | **4.01:1 ✅ LG** |

> Dark 模式所有组合均通过 WCAG AA（正文或大字号）。`accent-primary` 在 `bg-tertiary` 上 3.06:1，恰好通过大字号标准。

### 6.3 关键按钮对比度验证

| 组合 | 对比度 | 判定 | 说明 |
|------|--------|------|------|
| 白字 `#FFFFFF` 在朱砂红 `#D93A2E` | **4.57:1** | ✅ AA 正文 | 主按钮可用 |
| 朱砂红 `#D93A2E` 在宣纸白 `#F6F1E6` | **4.06:1** | ✅ LG 大字号 | 可做描边按钮或大号提示文字 |
| 朱砂红 `#D93A2E` 在深灰 `#1A1A1A` | **3.81:1** | ✅ LG 大字号 | Dark 模式大号强调文字 |

### 6.4 对比度验证方法

WCAG 2.1 相对亮度公式：
```
L = 0.2126 × R_lin + 0.7152 × G_lin + 0.0722 × B_lin

其中 C_lin = (C_srgb / 255)^2.2 近似，精确公式：
C_lin = (C_srgb/255 + 0.055) / 1.055) ^ 2.4  若 C_srgb/255 > 0.04045
C_lin = (C_srgb/255) / 12.92                 若 C_srgb/255 ≤ 0.04045

对比度 = (Lighter + 0.05) / (Darker + 0.05)
```

---

## 7. 文件引用

| 文件 | 用途 |
|------|------|
| `tokens/tokens.css` | CSS 自定义属性，HTML 原型直接引用 |
| `tokens/Colors.swift` | SwiftUI Color 扩展，iOS 工程直接引用 |
| `tokens/color-preview.html` | 可视化色板预览，支持 Light / Dark 切换 |

---

## 附录 A：更多 Don'ts

4. **不要在状态色上再加透明度**——`state-success` / `state-error` / `state-warning` 已经是专门调较的色值，再加透明度会导致对比度下降。如需透明叠加层，使用 `bg-{level}` + 独立状态图标。
5. **不要用 `stroke-grid` 做正文背景**——`#C8C0B6` 是练习格线色，作为背景时与其上的文字对比度不足。练习格文字始终使用 `ink-primary`。
6. **Dark 模式不要降低朱砂红饱和度**——朱砂红 `#D93A2E` 在暗背景上已经 3.81:1，再降低饱和度会跌破 3:1。如果感觉太亮，减小使用面积而非调整色值。

## 附录 B：Color Token 结构总览

```
Color System
├── Background (bg-*)
│   ├── bg-primary    → 主背景
│   ├── bg-secondary  → 卡片/列表
│   └── bg-tertiary   → 输入框/练习格
├── Ink (ink-*)       ← 文字层
│   ├── ink-primary   → 正文
│   ├── ink-secondary → 副标题/拼音
│   └── ink-tertiary  → 占位符
├── Accent (accent-*) ← 行动/强调
│   ├── accent-primary
│   ├── accent-hover
│   └── accent-pressed
├── Stroke (stroke-*) ← 线条/网格
│   ├── stroke-grid
│   ├── stroke-grid-accent
│   └── stroke-divider
├── State (state-*)   ← 反馈
│   ├── state-success
│   ├── state-warning
│   └── state-error
└── Shadow (shadow-*) ← 空间层次
    ├── shadow-card
    └── shadow-modal
```