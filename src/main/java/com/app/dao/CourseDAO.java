package com.app.dao;

import com.app.model.Course;

import java.util.List;
import java.util.Optional;

public interface CourseDAO {
    List<Course> findAllActiveCourses();

    Optional<Course> findCourseById(int courseId);
}
