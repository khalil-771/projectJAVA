package com.app.dao;

import com.app.model.Course;
import com.app.model.Chapter;
import com.app.model.Lesson;
import java.util.List;
import java.util.Optional;

public interface CourseDAO {
    List<Course> findAllActiveCourses();

    Optional<Course> findCourseById(int courseId);

    List<Chapter> findChaptersByCourseId(int courseId);

    List<Lesson> findLessonsByChapterId(int chapterId);

    // For hierarchy loading
    Course getFullCourseHierarchy(int courseId);
}
