// ============================================================
//  会读会写 Read & Write — 色彩令牌 SwiftUI Color 扩展
//  SwiftUI Color Extensions with Light/Dark dynamic support
//
//  Requirements: iOS 17+, Swift 5.9+
//  Usage:
//    Text("汉字")         .foregroundStyle(Color.inkPrimary)
//    Button("练习") { }    .tint(Color.accentPrimary)
//    RoundedRectangle(cornerRadius: 10)
//      .fill(Color.bgSecondary)
//      .shadow(color: .black.opacity(0.08), radius: 2, y: 1)
//
//  Version: v1.0  |  2026-06-06
// ============================================================

import SwiftUI

// MARK: - Color Extension

public extension Color {

    // MARK: Backgrounds

    /// 主背景 — Light: 宣纸白 #F6F1E6 / Dark: 深灰 #1A1A1A
    static let bgPrimary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#1A1A1A")!
                : UIColor(hex: "#F6F1E6")!
        }
    )

    /// 卡片 / 列表背景 — Light: #EEE8DA / Dark: #242424
    static let bgSecondary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#242424")!
                : UIColor(hex: "#EEE8DA")!
        }
    )

    /// 输入框 / 练习格背景 — Light: #E5DDCB / Dark: #2C2C2C
    static let bgTertiary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#2C2C2C")!
                : UIColor(hex: "#E5DDCB")!
        }
    )

    // MARK: Ink (Text)

    /// 主文字 / 汉字主体 — Light: 主墨黑 #141414 / Dark: 宣纸白 #F6F1E6
    static let inkPrimary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#F6F1E6")!
                : UIColor(hex: "#141414")!
        }
    )

    /// 次级文字 / 拼音 / 副标题 — Light: #55504B / Dark: #C8C0B6
    static let inkSecondary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#C8C0B6")!
                : UIColor(hex: "#55504B")!
        }
    )

    /// 占位符 / 提示文字 — Light: #7E766D / Dark: #8A8278
    static let inkTertiary: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#8A8278")!
                : UIColor(hex: "#7E766D")!
        }
    )

    // MARK: Accent (Actions / Tones / Current Stroke)

    /// 朱砂红主行动 — Light & Dark: #D93A2E (双模式不变)
    static let accentPrimary: Color = Color(
        uiColor: UIColor(hex: "#D93A2E")!
    )

    /// 朱砂红 hover / 高亮态 — Light: #C43328 / Dark: #E54A3E
    static let accentHover: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#E54A3E")!
                : UIColor(hex: "#C43328")!
        }
    )

    /// 朱砂红按下态 — Light: #AD2C22 / Dark: #BF2E22
    static let accentPressed: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#BF2E22")!
                : UIColor(hex: "#AD2C22")!
        }
    )

    // MARK: Strokes & Dividers

    /// 练习格线 — Light: #C8C0B6 / Dark: #5C5550
    static let strokeGrid: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#5C5550")!
                : UIColor(hex: "#C8C0B6")!
        }
    )

    /// 当前练习格高亮线 — 朱砂红双模式一致 #D93A2E
    static let strokeGridAccent: Color = Color(
        uiColor: UIColor(hex: "#D93A2E")!
    )

    /// 分隔线 — Light: #E0DAD0 / Dark: #3A3530
    static let strokeDivider: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#3A3530")!
                : UIColor(hex: "#E0DAD0")!
        }
    )

    // MARK: State (Practice Feedback)

    /// 练习成功 / 正确 — Light: #588157 / Dark: #6AAF6A
    static let stateSuccess: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#6AAF6A")!
                : UIColor(hex: "#588157")!
        }
    )

    /// 提示信息 — Light: #A86532 / Dark: #E0A060
    static let stateWarning: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#E0A060")!
                : UIColor(hex: "#A86532")!
        }
    )

    /// 错误笔画 / 输入错误 — Light: #C62828 / Dark: #EF5350
    static let stateError: Color = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#EF5350")!
                : UIColor(hex: "#C62828")!
        }
    )
}

// MARK: - Internal Hex Initializer (for this file only)

private extension UIColor {
    /// Initialize UIColor from a hex string like "#RRGGBB".
    /// Returns nil if the string is invalid.
    convenience init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        guard hex.count == 6, let int = UInt64(hex, radix: 16) else {
            return nil
        }
        let r = CGFloat((int >> 16) & 0xFF) / 255.0
        let g = CGFloat((int >> 8) & 0xFF) / 255.0
        let b = CGFloat(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

// MARK: - Previews (iOS 17+)

#Preview("Color Tokens - Light") {
    ColorTokenGrid()
        .preferredColorScheme(.light)
}

#Preview("Color Tokens - Dark") {
    ColorTokenGrid()
        .preferredColorScheme(.dark)
}

private struct ColorTokenGrid: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                section("Backgrounds", tokens: [
                    ("bgPrimary",   Color.bgPrimary),
                    ("bgSecondary", Color.bgSecondary),
                    ("bgTertiary",  Color.bgTertiary),
                ])
                section("Ink", tokens: [
                    ("inkPrimary",   Color.inkPrimary),
                    ("inkSecondary", Color.inkSecondary),
                    ("inkTertiary",  Color.inkTertiary),
                ])
                section("Accent", tokens: [
                    ("accentPrimary",   Color.accentPrimary),
                    ("accentHover",     Color.accentHover),
                    ("accentPressed",   Color.accentPressed),
                ])
                section("Stroke", tokens: [
                    ("strokeGrid",       Color.strokeGrid),
                    ("strokeGridAccent", Color.strokeGridAccent),
                    ("strokeDivider",    Color.strokeDivider),
                ])
                section("State", tokens: [
                    ("stateSuccess", Color.stateSuccess),
                    ("stateWarning", Color.stateWarning),
                    ("stateError",   Color.stateError),
                ])
            }
            .padding()
        }
        .background(Color.bgPrimary)
    }

    func section(_ title: String, tokens: [(name: String, color: Color)]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.inkTertiary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(tokens, id: \.name) { token in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(token.color)
                            .frame(height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.strokeDivider, lineWidth: 1)
                            )
                        Text(token.name)
                            .font(.caption2)
                            .foregroundStyle(Color.inkSecondary)
                    }
                }
            }
        }
    }
}