package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;


// classes in my project
import dbUtils.*;
import java.math.BigDecimal;
import model.Player.StringData;

public class WebUserView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllUser(String cssTableClass, DbConn dbc, String systemId) {

        // String type could have been used, but StringBuilder is more efficient 
        // in this case where we are just appending
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet results = null;
        try {

            
            //sql string to display just date, log info and system id
            String sql = "SELECT date, log_info, system_id FROM system_command_log AS scl WHERE scl.system_id = ?";
            
            stmt = dbc.getConn().prepareStatement(sql);
            
            stmt.setString(1, systemId);
            
            results = stmt.executeQuery();

            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>Date Logged</th>");
            sb.append("<th style='text-align:center'>Log Info</th>");
            sb.append("<th style='text-align:center'>System ID</th>");

            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatDateTd(results.getObject("date")));
                sb.append(FormatUtils.formatStringTd(results.getObject("log_info")));
                sb.append(FormatUtils.formatIntegerTd(results.getObject("system_id")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllUser(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }

    /*public static String playerListUpdate(String deleteIcon, String deleteFn, String updateIcon, String updateURL,
            String cssClassForTable, DbConn dbc) {
        return playersByNameView(deleteIcon, deleteFn, updateIcon, updateURL, cssClassForTable, dbc);
    }

    public static String playersByName(String cssClassForTable, DbConn dbc) {
        return playersByNameView("", "", "", "", cssClassForTable, dbc);
    }

    private static String playersByNameView(String deleteIcon, String deleteFn,
            String updateIcon, String updateURL, String cssTableClass, DbConn dbc) {

        //ERROR CHECKING
        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if ((deleteIcon == null) || (deleteIcon.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if ((deleteFn == null) || (deleteFn.length() == 0)) {
            return "WebUserSql.listAllUsers() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // String type could have been used, but StringBuilder is more efficient 
        // in this case where we are just appending
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            //sql string for all fields in User table
            
            //sql string for just displaying id, name, email and pswd
            String sql = "select player_id, player_name, email_address, pswd from Player as P, User_role as U "
                    + "where P.user_role_id = U.user_role_id order by player_id, player_name";

            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();

            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>\n");
            sb.append("<tr>");

            if (deleteFn.length() > 0) {
                sb.append("<th style='background-color:transparent;border:none;'> </th>");
            }
            if (updateURL.length() > 0) {
                sb.append("<th style='background-color:transparent;border:none;'> </th>");
            }

            sb.append("<th style='text-align:right'>User ID</th>");
            sb.append("<th style='text-align:center'>User Name</th>");
            sb.append("<th style='text-align:center'>Email Address</th>");
            sb.append("<th style='text-align:center'>Password</th>");
            //sb.append("<th style='text-align:right'>Skill Level</th></th>");
            //sb.append("<th style='text-align:center'>Role Name</th></tr>");

            while (results.next()) {
                sb.append("<tr>");

                String playerId = results.getString("player_id");
                if (deleteFn.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + deleteFn
                            + "(" + playerId + ")'><img src='" + deleteIcon + "'></a> </td>");
                }
                if (updateURL.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + updateURL + "="
                            + playerId + "'><img src='" + updateIcon + "'></a> </td>");
                }

                sb.append("<td style='text-align:right'>" + playerId + "</td>");
                //sb.append(FormatUtils.formatIntegerTd(results.getObject("player_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("player_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("email_address")));
                sb.append(FormatUtils.formatStringTd(results.getObject("pswd")));
                //sb.append(FormatUtils.formatDecimalTd(results.getObject("skill_level")));
                //sb.append(FormatUtils.formatStringTd(results.getObject("role_name")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();

        } catch (Exception e) {
            return "Exception thrown in WebUserSql.playerListUpdate(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }

    }*/
}
