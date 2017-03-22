package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import dbUtils.*;
import java.math.BigDecimal;

public class WebOtherView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllOther(String cssTableClass, DbConn dbc) {

        // String type could have been used, but StringBuilder is more efficient 
        // in this case where we are just appending
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "select tournament_id, tournament_name, event_date, tournament_desc from Tournament order by tournament_id, tournament_name";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:right'>Tournament ID</th>");
            sb.append("<th style='text-align:center'>Tournament Name</th>");
            sb.append("<th style='text-align:center'>Event Date</th>");
            sb.append("<th style='text-align:center'>Tournament Description</th></tr>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatIntegerTd(results.getObject("tournament_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_name")));
                sb.append(FormatUtils.formatDateTd(results.getObject("event_date")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_desc")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllOther(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }

    public static String tournamentListUpdate(String deleteIcon, String deleteFn, String updateIcon, String updateURL,
            String cssClassForTable, DbConn dbc) {
        return tournamentsByNameView(deleteIcon, deleteFn, updateIcon, updateURL, cssClassForTable, dbc);
    }

    public static String tournamentsByName(String cssClassForTable, DbConn dbc) {
        return tournamentsByNameView("", "", "", "", cssClassForTable, dbc);
    }

    private static String tournamentsByNameView(String deleteIcon, String deleteFn,
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
            String sql = "select tournament_id, tournament_name, event_date, tournament_desc from Tournament order by tournament_id, tournament_name";

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
            
            sb.append("<th style='text-align:right'>Tournament ID</th>");
            sb.append("<th style='text-align:center'>Tournament Name</th>");
            sb.append("<th style='text-align:center'>Event Date</th>");
            sb.append("<th style='text-align:center'>Tournament Description</th></tr>");

            while (results.next()) {
                
                
                sb.append("<tr>");

                String tournamentId = results.getString("tournament_id");
                if (deleteFn.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + deleteFn
                            + "(" + tournamentId + ")'><img src='" + deleteIcon + "'></a> </td>");
                }
                if (updateURL.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + updateURL + "="
                            + tournamentId + "'><img src='" + updateIcon + "'></a> </td>");
                }
                
                
                sb.append("<td style='text-align:right'>" + tournamentId + "</td>");
                //sb.append(FormatUtils.formatIntegerTd(results.getObject("tournament_id")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_name")));
                sb.append(FormatUtils.formatDateTd(results.getObject("event_date")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_desc")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();

        } catch (Exception e) {
            return "Exception thrown in WebUserSql.tournamentListUpdate(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }

    }
}
