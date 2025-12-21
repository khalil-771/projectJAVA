# E-Learning Platform - Testing Guide

## 🧪 Complete Testing Checklist

### Prerequisites
- ✅ MySQL running (XAMPP or standalone)
- ✅ Application built (`mvn clean install`)
- ✅ Database auto-created on first run

---

## 1. Initial Setup Test

### First Launch
```bash
mvn javafx:run
```

**Expected Console Output:**
```
Checking database initialization...
Database initialization completed.
Running gamification extensions...
Gamification extensions completed.
Admin password updated to 'admin123'
```

✅ **Pass Criteria:**
- No errors in console
- Login screen appears
- Database `elearning_db` created in MySQL

---

## 2. Authentication Tests

### Test 2.1: Admin Login
**Steps:**
1. Enter username: `admin`
2. Enter password: `admin123`
3. Click Login

✅ **Pass:** Main application window opens with navigation sidebar

### Test 2.2: Invalid Login
**Steps:**
1. Enter username: `wrong`
2. Enter password: `wrong`
3. Click Login

✅ **Pass:** Error message "Invalid username or password"

---

## 3. Dashboard Tests

### Test 3.1: Initial Dashboard
**Steps:**
1. Login as admin
2. Click "📊 Dashboard"

✅ **Pass Criteria:**
- Welcome message: "Welcome back, admin the Beginner!"
- Level: 1
- Total XP: 0
- Current Streak: 0 days
- Accuracy: 0%
- 0 Quizzes Completed
- "No badges yet" message

### Test 3.2: Dashboard After Quiz
**Steps:**
1. Complete a quiz (see Quiz Tests)
2. Return to Dashboard

✅ **Pass Criteria:**
- XP increased (60-100+)
- Streak: 1 day
- Accuracy updated
- 1 Quiz Completed
- "First Steps" badge visible

---

## 4. Quiz Tests

### Test 4.1: Take First Quiz
**Steps:**
1. Click on a course (e.g., "HTML Tutorial")
2. Select a quiz
3. Answer questions
4. Click "Submit Quiz"

✅ **Pass Criteria:**
- Score displayed: "Your Score: X% - PASSED! 🎉"
- "+X XP" label appears with animation
- "🏆 New Badges Earned!" section shows
- "• First Steps (+50 XP)" appears
- Console shows: "🏆 Badge earned: First Steps (+50 points)"

### Test 4.2: Perfect Score
**Steps:**
1. Take a quiz
2. Answer ALL questions correctly
3. Submit

✅ **Pass Criteria:**
- Score: 100%
- "+X XP" with bonus points
- "Perfect Score" badge unlocked
- Console: "🏆 Badge earned: Perfect Score (+200 points)"

### Test 4.3: Multiple Quizzes
**Steps:**
1. Complete 10 quizzes

✅ **Pass Criteria:**
- After 10th quiz: "Quiz Enthusiast" badge unlocked
- Total XP: 600-1000+
- Level may increase to 2 or 3

---

## 5. Leaderboard Tests

### Test 5.1: View Leaderboard
**Steps:**
1. Click "🏆 Leaderboard"

✅ **Pass Criteria:**
- Three tabs visible: Daily, Weekly, Global
- Your username appears in table (highlighted in blue)
- Your Rank: #1 (if only user)
- Columns: #, Player, Level, Score, Badges

### Test 5.2: Language Filter
**Steps:**
1. On Leaderboard, select "☕ Java" from dropdown
2. Click Refresh

✅ **Pass Criteria:**
- Table updates
- "Your Rank" updates
- Only Java-specific scores shown

### Test 5.3: Tab Switching
**Steps:**
1. Click "📅 Daily" tab
2. Click "📊 Weekly" tab
3. Click "🌍 Global" tab

✅ **Pass:** Each tab shows data, rank updates

---

## 6. Profile Tests

### Test 6.1: View Profile
**Steps:**
1. Click "👤 Profile"

✅ **Pass Criteria:**
- Username and email displayed
- Level and progress bar shown
- Current/Best streak displayed
- Statistics (quizzes, accuracy) shown
- Badge collection visible (15 total badges)

### Test 6.2: Badge Collection
**Steps:**
1. Scroll to Badge Collection section

✅ **Pass Criteria:**
- Earned badges: Full color, 🏆 icon
- Locked badges: Grayed out, 🔒 icon
- "First Steps" badge is colored (earned)
- Other 14 badges are locked
- Hover shows badge details

---

## 7. Gamification Feature Tests

### Test 7.1: Level Up
**Steps:**
1. Complete quizzes until you earn 100+ XP
2. Check console

✅ **Pass Criteria:**
- Console: "🎉 Level up! You are now level 2 - Beginner"
- Dashboard shows Level 2
- Progress bar resets for next level

### Test 7.2: Streak Tracking
**Steps:**
1. Complete a quiz today
2. Come back tomorrow and complete another quiz

✅ **Pass Criteria:**
- Day 1: Streak = 1 day
- Day 2: Streak = 2 days
- Dashboard shows streak with ⭐ emoji
- After 7 days: 🔥 emoji appears

### Test 7.3: Accuracy Tracking
**Steps:**
1. Complete quiz with 80% score
2. Complete quiz with 90% score
3. Check Dashboard

✅ **Pass:** Accuracy shows average (e.g., 85%)

---

## 8. Badge Unlock Tests

### Test 8.1: Achievement Badges
| Badge | Condition | Test |
|-------|-----------|------|
| First Steps | 1 quiz | ✅ Complete 1 quiz |
| Quiz Enthusiast | 10 quizzes | ✅ Complete 10 quizzes |
| Perfect Score | 100% score | ✅ Get 100% on any quiz |

### Test 8.2: Streak Badges
| Badge | Condition | Test |
|-------|-----------|------|
| Streak Master | 7-day streak | ✅ Play 7 consecutive days |

### Test 8.3: Level Badges
| Badge | Condition | Test |
|-------|-----------|------|
| Level 5 | Reach level 5 | ✅ Earn ~400 XP |
| Level 10 | Reach level 10 | ✅ Earn ~1500 XP |

---

## 9. Admin Panel Tests

### Test 9.1: Access Admin Panel
**Steps:**
1. Login as admin
2. Navigate to admin section (if accessible)

✅ **Pass:** Admin panel loads with tabs

### Test 9.2: View Badges
**Steps:**
1. Click "🏆 Badges" tab

✅ **Pass:** All 15 badges listed in table

---

## 10. Database Tests

### Test 10.1: Check User Stats
```sql
USE elearning_db;
SELECT * FROM user_stats WHERE user_id = 1;
```

✅ **Pass:** Row exists with points, level, streak data

### Test 10.2: Check Badges
```sql
SELECT * FROM user_badges WHERE user_id = 1;
```

✅ **Pass:** Shows earned badges (at least "First Steps")

### Test 10.3: Check Leaderboard
```sql
SELECT * FROM user_stats ORDER BY total_points DESC;
```

✅ **Pass:** Users ranked by points

---

## 11. Performance Tests

### Test 11.1: Load Time
**Steps:**
1. Measure time from launch to login screen

✅ **Pass:** < 5 seconds

### Test 11.2: Dashboard Load
**Steps:**
1. Click Dashboard, measure load time

✅ **Pass:** < 2 seconds

### Test 11.3: Leaderboard Load
**Steps:**
1. Click Leaderboard with 100+ users

✅ **Pass:** < 3 seconds

---

## 12. Edge Case Tests

### Test 12.1: Empty Quiz
**Steps:**
1. Submit quiz without answering

✅ **Pass:** Score = 0%, minimum 10 XP awarded

### Test 12.2: Duplicate Badge
**Steps:**
1. Manually try to award same badge twice

✅ **Pass:** Badge not duplicated (database constraint)

### Test 12.3: Negative Points
**Steps:**
1. Check if points can go negative

✅ **Pass:** Minimum 10 points per quiz

---

## 13. UI/UX Tests

### Test 13.1: Animations
**Steps:**
1. Complete quiz, watch animations

✅ **Pass Criteria:**
- Points label fades in and scales
- Badge notification slides down
- Smooth transitions

### Test 13.2: Responsive Layout
**Steps:**
1. Resize window

✅ **Pass:** Layout adapts, no overlapping elements

### Test 13.3: Navigation
**Steps:**
1. Click all navigation buttons

✅ **Pass:** All pages load without errors

---

## 14. Integration Tests

### Test 14.1: Quiz → Stats → Leaderboard
**Steps:**
1. Complete quiz
2. Check Dashboard (stats updated)
3. Check Leaderboard (rank updated)

✅ **Pass:** All data consistent

### Test 14.2: Badge → Points → Level
**Steps:**
1. Earn badge
2. Check points increased
3. Check if level increased

✅ **Pass:** Badge points added to total

---

## 15. Regression Tests

After any code changes, re-run:
- ✅ Login test
- ✅ Dashboard load test
- ✅ Quiz submission test
- ✅ Badge unlock test
- ✅ Leaderboard display test

---

## Test Results Template

```
Date: ___________
Tester: ___________

| Test ID | Test Name | Status | Notes |
|---------|-----------|--------|-------|
| 2.1 | Admin Login | ✅ PASS | |
| 3.1 | Initial Dashboard | ✅ PASS | |
| 4.1 | First Quiz | ✅ PASS | |
| 5.1 | Leaderboard | ✅ PASS | |
| 6.1 | Profile | ✅ PASS | |
| 7.1 | Level Up | ✅ PASS | |
| 8.1 | Badge Unlock | ✅ PASS | |

Overall Status: ✅ PASS / ❌ FAIL
```

---

## Automated Testing (Future)

### Unit Tests
```bash
mvn test
```

### Integration Tests
```bash
mvn verify
```

---

## Bug Reporting Template

```
**Bug Title:** 
**Severity:** Critical / High / Medium / Low
**Steps to Reproduce:**
1. 
2. 
3. 

**Expected Result:**

**Actual Result:**

**Screenshots:**

**Environment:**
- OS: 
- Java Version: 
- MySQL Version: 
```

---

**Happy Testing!** 🧪✅

Report any issues and let's make this platform perfect!
