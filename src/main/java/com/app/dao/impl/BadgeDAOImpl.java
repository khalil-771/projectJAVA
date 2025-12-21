package com.app.dao.impl;

import com.app.dao.BadgeDAO;
import com.app.model.Badge;
import com.app.model.UserBadge;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BadgeDAOImpl implements BadgeDAO {

    @Override
    public List<Badge> findAll() {
        List<Badge> badges = new ArrayList<>();
        String sql = "SELECT * FROM badges ORDER BY badge_type, id";

        try (Connection conn = DatabaseConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                badges.add(mapResultSetToBadge(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return badges;
    }

    @Override
    public Optional<Badge> findById(int badgeId) {
        String sql = "SELECT * FROM badges WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, badgeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSetToBadge(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public Optional<Badge> findByName(String name) {
        String sql = "SELECT * FROM badges WHERE name = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSetToBadge(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<UserBadge> findUserBadges(int userId) {
        List<UserBadge> userBadges = new ArrayList<>();
        String sql = "SELECT ub.*, b.* FROM user_badges ub " +
                "JOIN badges b ON ub.badge_id = b.id " +
                "WHERE ub.user_id = ? ORDER BY ub.earned_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserBadge userBadge = new UserBadge();
                userBadge.setId(rs.getInt("ub.id"));
                userBadge.setUserId(rs.getInt("user_id"));
                userBadge.setBadgeId(rs.getInt("badge_id"));
                userBadge.setEarnedAt(rs.getTimestamp("earned_at"));

                // Map badge details
                Badge badge = new Badge();
                badge.setId(rs.getInt("b.id"));
                badge.setName(rs.getString("name"));
                badge.setDescription(rs.getString("description"));
                badge.setIconPath(rs.getString("icon_path"));
                badge.setBadgeType(Badge.BadgeType.valueOf(rs.getString("badge_type")));
                badge.setPointsReward(rs.getInt("points_reward"));
                badge.setRuleCondition(rs.getString("rule_condition"));

                userBadge.setBadge(badge);
                userBadges.add(userBadge);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBadges;
    }

    @Override
    public boolean userHasBadge(int userId, int badgeId) {
        String sql = "SELECT COUNT(*) FROM user_badges WHERE user_id = ? AND badge_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, badgeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean awardBadge(int userId, int badgeId) {
        // Check if already has badge
        if (userHasBadge(userId, badgeId)) {
            return false;
        }

        String sql = "INSERT INTO user_badges (user_id, badge_id) VALUES (?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, badgeId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int getUserBadgeCount(int userId) {
        String sql = "SELECT COUNT(*) FROM user_badges WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean createBadge(Badge badge) {
        String sql = "INSERT INTO badges (name, description, icon_path, badge_type, points_reward, rule_condition) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, badge.getName());
            stmt.setString(2, badge.getDescription());
            stmt.setString(3, badge.getIconPath());
            stmt.setString(4, badge.getBadgeType().name());
            stmt.setInt(5, badge.getPointsReward());
            stmt.setString(6, badge.getRuleCondition());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    badge.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Badge mapResultSetToBadge(ResultSet rs) throws SQLException {
        Badge badge = new Badge();
        badge.setId(rs.getInt("id"));
        badge.setName(rs.getString("name"));
        badge.setDescription(rs.getString("description"));
        badge.setIconPath(rs.getString("icon_path"));
        badge.setBadgeType(Badge.BadgeType.valueOf(rs.getString("badge_type")));
        badge.setPointsReward(rs.getInt("points_reward"));
        badge.setRuleCondition(rs.getString("rule_condition"));
        badge.setCreatedAt(rs.getTimestamp("created_at"));
        return badge;
    }
}
