package com.app.model;

import java.util.ArrayList;
import java.util.List;

public class Course {
    private int id;
    private String title;
    private String description;
    private String languageTag;
    private boolean isActive;
    
    // Using a list to hold chapters for hierarchy
    private List<Chapter> chapters = new ArrayList<>();

    public Course() {}

    public Course(int id, String title, String description, String languageTag) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.languageTag = languageTag;
        this.isActive = true;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLanguageTag() { return languageTag; }
    public void setLanguageTag(String languageTag) { this.languageTag = languageTag; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public List<Chapter> getChapters() { return chapters; }
    public void setChapters(List<Chapter> chapters) { this.chapters = chapters; }
    public void addChapter(Chapter chapter) { this.chapters.add(chapter); }
    
    @Override
    public String toString() { return title; }
}
