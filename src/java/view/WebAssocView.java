package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import dbUtils.*;
import model.Registration.*;
import java.math.BigDecimal;

public class WebAssocView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllAssoc(String cssTableClass, DbConn dbc) {

        // String type could have been used, but StringBuilder is more efficient 
        // in this case where we are just appending
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "select player_name, tournament_name, event_type, donation, special_needs"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id"
                    + " order by player_name, tournament_name";
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:center'>Player Name</th>");
            sb.append("<th style='text-align:center'>Tournament Name</th>");
            sb.append("<th style='text-align:center'>Event Type</th>");
            sb.append("<th style='text-align:left'>Donation</th>");
            sb.append("<th style='text-align:center'>Special Needs</th>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatStringTd(results.getObject("player_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("event_type")));
                sb.append(FormatUtils.formatDollarTd(results.getObject("donation")));
                sb.append(FormatUtils.formatStringTd(results.getObject("special_needs")));

                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllAssoc(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }

    public static String search(String cssTableClass, DbConn dbc, String playerID, String tournamentID, String lowDonation, String highDonation) {
        StringBuilder sb = new StringBuilder();

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            /* SQL statement to be executed */
            String sql = "select player_name, tournament_name, event_type, donation, special_needs"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id";

            /* APPENDING THE SQL STATEMENT TO INCLUDE CONDITIONS TO WHERE CLAUSE*/
            //if playerID is not empty and not equal 0, indicating not 'Select Player'
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                sql += " and P.player_id = ?";
            }
            //if tournamentID is not empty and not equal 0, indicating not 'Select Tournament'
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                sql += " and T.tournament_id = ?";
            }
            //if lowFee is not empty
            if (lowDonation.length() != 0) {
                sql += " and R.donation between ?";
            }
            //if highFee is not empty
            if (highDonation.length() != 0) {
                sql += " and ?";
            }

            /* PREPARE THE SQL STATEMENT */
            stmt = dbc.getConn().prepareStatement(sql);

            /* REPLACING THE ?s*/
            int count = 1; //to keep track of the questions marks being replaced
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                stmt.setString(count, playerID);
                count++;
            }
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                stmt.setString(count, tournamentID);
                count++;
            }
            if (lowDonation.length() != 0) {
                stmt.setString(count, lowDonation);
                count++;
            }
            if (highDonation.length() != 0) {
                stmt.setString(count, highDonation);
                count++;
            }

            /* EXECUTE THE STATEMENT TO GET RESULT SET */
            results = stmt.executeQuery();

            /* CREATION OF THE TABLE IS HERE*/
            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:center'>Player Name</th>");
            sb.append("<th style='text-align:center'>Tournament Name</th>");
            sb.append("<th style='text-align:center'>Event Type</th>");
            sb.append("<th style='text-align:left'>Donation</th>");
            sb.append("<th style='text-align:center'>Special Needs</th>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatStringTd(results.getObject("player_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("event_type")));
                sb.append(FormatUtils.formatDollarTd(results.getObject("donation")));
                sb.append(FormatUtils.formatStringTd(results.getObject("special_needs")));

                sb.append("</tr>\n");
            }
            sb.append("</table>");

            /* CLOSE THE CONNECTIONS*/
            results.close();
            stmt.close();

            return sb.toString();

        } catch (Exception e) {
            return "Exception thrown in WebUserSql.listAllAssoc(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();

        }
    }

    private static EnhancedStringData dbRowToStringData(ResultSet results) {

        EnhancedStringData sd = new EnhancedStringData();

        try {

            sd.playerName = FormatUtils.formatString(results.getObject("player_name"));
            sd.tournamentName = FormatUtils.formatString(results.getObject("tournament_name"));
            sd.eventType = FormatUtils.formatString(results.getObject("event_type"));
            sd.donation = FormatUtils.formatDecimal(results.getObject("donation"));
            sd.specialNeeds = FormatUtils.formatString(results.getObject("special_needs"));

        } catch (Exception e) {
            sd.errorMsg = "Error in WebAssocView.dbRowToStringData: " + e.getMessage();
        }
        return sd;
    }

    public static StringDataList searchJSON(String cssTableClass, DbConn dbc, String playerID, String tournamentID, String lowDonation, String highDonation) {

        EnhancedStringData foundReg = null;
        StringDataList regList = new StringDataList(0);

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            //get amount of registrations that will be in JSON list
            /* SQL statement to be executed */
            String sql = "select count(*) as numRegistrations"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id";

            /* APPENDING THE SQL STATEMENT TO INCLUDE CONDITIONS TO WHERE CLAUSE*/
            //if playerID is not empty and not equal 0, indicating not 'Select Player'
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                sql += " and P.player_id = ?";
            }
            //if tournamentID is not empty and not equal 0, indicating not 'Select Tournament'
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                sql += " and T.tournament_id = ?";
            }
            //if lowFee is not empty
            if (lowDonation.length() != 0) {
                sql += " and R.donation between ?";
            }
            //if highFee is not empty
            if (highDonation.length() != 0) {
                sql += " and ?";
            }

            /* PREPARE THE SQL STATEMENT */
            stmt = dbc.getConn().prepareStatement(sql);

            /* REPLACING THE ?s*/
            int count = 1; //to keep track of the questions marks being replaced
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                stmt.setString(count, playerID);
                count++;
            }
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                stmt.setString(count, tournamentID);
                count++;
            }
            if (lowDonation.length() != 0) {
                stmt.setString(count, lowDonation);
                count++;
            }
            if (highDonation.length() != 0) {
                stmt.setString(count, highDonation);
                count++;
            }

            /* EXECUTE THE STATEMENT TO GET RESULT SET */
            results = stmt.executeQuery();

            //puts number of registrations in the constructor fo the StringDataList class to create array of enhanced string data
            if (results.next()) {
                int num = results.getInt("numRegistrations");
                regList = new StringDataList(num);
                System.out.println("***** num registrations is " + num);
            }

            //now add each registration to the list of registrations
            /* SQL statement to be executed */
            sql = "select player_name, tournament_name, event_type, donation, special_needs"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id";

            /* APPENDING THE SQL STATEMENT TO INCLUDE CONDITIONS TO WHERE CLAUSE*/
            //if playerID is not empty and not equal 0, indicating not 'Select Player'
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                sql += " and P.player_id = ?";
            }
            //if tournamentID is not empty and not equal 0, indicating not 'Select Tournament'
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                sql += " and T.tournament_id = ?";
            }
            //if lowFee is not empty
            if (lowDonation.length() != 0) {
                sql += " and R.donation between ?";
            }
            //if highFee is not empty
            if (highDonation.length() != 0) {
                sql += " and ?";
            }

            /* PREPARE THE SQL STATEMENT */
            stmt = dbc.getConn().prepareStatement(sql);

            /* REPLACING THE ?s*/
            count = 1; //to keep track of the questions marks being replaced
            if ((playerID.length() != 0) && !(playerID.equals("0"))) {
                stmt.setString(count, playerID);
                count++;
            }
            if ((tournamentID.length() != 0) && !(tournamentID.equals("0"))) {
                stmt.setString(count, tournamentID);
                count++;
            }
            if (lowDonation.length() != 0) {
                stmt.setString(count, lowDonation);
                count++;
            }
            if (highDonation.length() != 0) {
                stmt.setString(count, highDonation);
                count++;
            }

            /* EXECUTE THE STATEMENT TO GET RESULT SET */
            results = stmt.executeQuery();

            while (results.next()) {

                foundReg = dbRowToStringData(results);
                regList.addRegistration(foundReg);

            }
        } catch (Exception e) {
            foundReg.errorMsg = "Exception thrown in WebUserSql.listAllAssoc(): " + e.getMessage()
                    + "<br/> partial output: <br/>";

            return regList;

        }

        return regList;
    }

    public static String registrationListUpdate(String deleteIcon, String deleteFn, String updateIcon, String updateURL,
            String cssClassForTable, DbConn dbc) {
        return registrationsByNameView(deleteIcon, deleteFn, updateIcon, updateURL, cssClassForTable, dbc);
    }

    public static String registrationsByName(String cssClassForTable, DbConn dbc) {
        return registrationsByNameView("", "", "", "", cssClassForTable, dbc);
    }

    private static String registrationsByNameView(String deleteIcon, String deleteFn,
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
            String sql = "select registration_id, player_name, tournament_name, event_type, donation, special_needs"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id";

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

            sb.append("<th style='text-align:center'>Player Name</th>");
            sb.append("<th style='text-align:center'>Tournament Name</th>");
            sb.append("<th style='text-align:center'>Event Type</th>");
            sb.append("<th style='text-align:left'>Donation</th>");
            sb.append("<th style='text-align:center'>Special Needs</th>");

            while (results.next()) {
                sb.append("<tr>");

                String registrationId = results.getString("registration_id");
                if (deleteFn.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + deleteFn
                            + "(" + registrationId + ")'><img src='" + deleteIcon + "'></a> </td>");
                }
                if (updateURL.length() > 0) {
                    sb.append("<td style='background-color:transparent;border:none;'><a href='" + updateURL + "="
                            + registrationId + "'><img src='" + updateIcon + "'></a> </td>");
                }

                //sb.append("<td style='text-align:right'>" + registrationId + "</td>");
                sb.append(FormatUtils.formatStringTd(results.getObject("player_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("tournament_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("event_type")));
                sb.append(FormatUtils.formatDollarTd(results.getObject("donation")));
                sb.append(FormatUtils.formatStringTd(results.getObject("special_needs")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            return sb.toString();

        } catch (Exception e) {
            return "Exception thrown in WebUserSql.registrationListUpdate(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }

    }
}
