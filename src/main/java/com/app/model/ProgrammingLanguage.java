package com.app.model;

public enum ProgrammingLanguage {
    JAVA("Java", "java", "☕"),
    PYTHON("Python", "python", "🐍"),
    CPP("C++", "cpp", "⚙️"),
    C("C", "c", "🔧"),
    HTML("HTML", "html", "🌐"),
    CSS("CSS", "css", "🎨"),
    JAVASCRIPT("JavaScript", "js", "⚡"),
    SQL("SQL", "sql", "🗄️"),
    KOTLIN("Kotlin", "kotlin", "🅺"),
    PHP("PHP", "php", "🐘"),
    CSHARP("C#", "csharp", "#️⃣"),
    RUBY("Ruby", "ruby", "💎"),
    SWIFT("Swift", "swift", "🦅"),
    GO("Go", "go", "🐹");

    private final String displayName;
    private final String tag;
    private final String emoji;

    ProgrammingLanguage(String displayName, String tag, String emoji) {
        this.displayName = displayName;
        this.tag = tag;
        this.emoji = emoji;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getTag() {
        return tag;
    }

    public String getEmoji() {
        return emoji;
    }

    public static ProgrammingLanguage fromTag(String tag) {
        for (ProgrammingLanguage lang : values()) {
            if (lang.tag.equalsIgnoreCase(tag)) {
                return lang;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return emoji + " " + displayName;
    }
}
