package com.app.dao.impl;

import com.app.dao.CourseDAO;
import com.app.model.Course;
import com.app.model.Chapter;
import com.app.model.Lesson;
import com.app.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CourseDAOImpl implements CourseDAO {

    @Override
    public List<Course> findAllActiveCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses WHERE is_active = 1";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setLanguageTag(rs.getString("language_tag"));
                c.setActive(rs.getBoolean("is_active"));
                courses.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    @Override
    public Optional<Course> findCourseById(int courseId) {
        String sql = "SELECT * FROM courses WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Course c = new Course();
                    c.setId(rs.getInt("id"));
                    c.setTitle(rs.getString("title"));
                    c.setDescription(rs.getString("description"));
                    c.setLanguageTag(rs.getString("language_tag"));
                    c.setActive(rs.getBoolean("is_active"));
                    return Optional.of(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<Chapter> findChaptersByCourseId(int courseId) {
        List<Chapter> chapters = new ArrayList<>();
        String sql = "SELECT * FROM chapters WHERE course_id = ? ORDER BY order_index";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Chapter c = new Chapter();
                    c.setId(rs.getInt("id"));
                    c.setCourseId(rs.getInt("course_id"));
                    c.setTitle(rs.getString("title"));
                    c.setOrderIndex(rs.getInt("order_index"));
                    chapters.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return chapters;
    }

    @Override
    public List<Lesson> findLessonsByChapterId(int chapterId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM lessons WHERE chapter_id = ? ORDER BY order_index";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, chapterId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Lesson l = new Lesson();
                    l.setId(rs.getInt("id"));
                    l.setChapterId(rs.getInt("chapter_id"));
                    l.setTitle(rs.getString("title"));
                    l.setContentHtml(rs.getString("content_html"));
                    l.setExampleCode(rs.getString("example_code"));
                    l.setOrderIndex(rs.getInt("order_index"));
                    lessons.add(l);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lessons;
    }

    @Override
    public Course getFullCourseHierarchy(int courseId) {
        Optional<Course> courseOpt = findCourseById(courseId);
        if (courseOpt.isEmpty())
            return null;

        Course course = courseOpt.get();
        List<Chapter> chapters = findChaptersByCourseId(courseId);

        for (Chapter chapter : chapters) {
            List<Lesson> lessons = findLessonsByChapterId(chapter.getId());
            chapter.setLessons(lessons);
            course.addChapter(chapter);
        }

        return course;
    }
}
