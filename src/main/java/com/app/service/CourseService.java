package com.app.service;

import com.app.dao.CourseDAO;
import com.app.dao.impl.CourseDAOImpl;
import com.app.model.Course;

import java.util.List;

public class CourseService {

    private final CourseDAO courseDAO;

    public CourseService() {
        this.courseDAO = new CourseDAOImpl();
    }

    public List<Course> getAllCourses() {
        return courseDAO.findAllActiveCourses();
    }

    public Course getCourseWithContent(int courseId) {
        return courseDAO.getFullCourseHierarchy(courseId);
    }
}
