/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

import model.Tournament.*;
import dbUtils.*;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

/**
 *
 * @author jedrickboca
 */
public class DbMods {

    public static StringData insert(StringData input, DbConn dbc) {
        StringData errorMsgs = new StringData();
        errorMsgs = validate(input);

        if (errorMsgs.getCharacterCount() > 0) {  // at least one field has an error, don't go any further.
            errorMsgs.errorMsg = "Try again and enter the required fields.";
            return errorMsgs;
        } else { //all fields pass validation


            /* PREPARE INITIAL SQL STATEMENT */
            String sql = "INSERT INTO user (user_name, email, first_name, last_name, phone_number, password, role_id) "
                    + "values (?,?,?,?,?,?,2)";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            /* FILL IN THOSE QUESTION MARKS */
            stmt.setString(1, input.user_name);
            stmt.setString(2, input.email);
            stmt.setString(3, input.first_name);
            stmt.setString(4, input.last_name);
            stmt.setLong(5, ValidationUtils.longConversion(input.phone_number));
            stmt.setString(6, input.password);

            //execute sql statement
            int numRows = stmt.executeUpdate();

            /* CREATES ENTRY IN SYSTEM TABLE*/
 /* PREPARE INITIAL SQL STATEMENT */
            String sql2 = "INSERT INTO system (system_ip, register_date, light_interval_start, light_interval, mist_interval_start, mist_interval, user_id) VALUES(?, sysdate(), CURRENT_TIMESTAMP, 8.0, CURRENT_TIMESTAMP, 8.0,  (SELECT MAX(user_id) from user))";

            PrepStatement stmt2 = new PrepStatement(dbc, sql2);

            //fill in question marks
            stmt2.setString(1, input.system_ip);

            //execute sql statement
            int numRows2 = stmt2.executeUpdate();

            /* FILLS IN QUESTION MARK FOR THE SELECT TAG INPUT*/
            //if role name input is not empty and not equal 0 ,indicating not 'Select Role Name'
            /* if ((input.roleName.length() != 0) && !(input.roleName.equals("0"))) {
                stmt.setString(5, input.roleName);
            }*/
            /**
             * SQL STATEMENT EXECUTED executeUpdate() returns # of rows altered
             * or successfully added
             */
            errorMsgs.errorMsg = stmt.getErrorMsg();

            if (errorMsgs.errorMsg.length() == 0) { //return empty string if all is gooood, else return dem errors

                if (numRows == 1) {
                    errorMsgs.errorMsg = ""; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
                } else {
                    // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                    errorMsgs.errorMsg = numRows + " records were inserted when exactly 1 was expected.";
                }

                if (numRows2 == 1) {
                    errorMsgs.errorMsg = ""; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
                } else {
                    // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                    errorMsgs.errorMsg = numRows2 + " records were inserted when exactly 1 was expected.fuck";
                }
            }

        }

        /* if returning empty string then SUCCESS!!! */
        return errorMsgs;
    }

    public static StringArduinoData send(StringArduinoData input, String system_id, DbConn dbc) {
        StringArduinoData errorMsgs = new StringArduinoData();
        //errorMsgs = validate(input);

        if (errorMsgs.getCharacterCount() > 0) {  // at least one field has an error, don't go any further.
            errorMsgs.errorMsg = "Try again and enter the required fields.";
            return errorMsgs;
        } else { //all fields pass validation


            /* PREPARE INITIAL SQL STATEMENT */
            String sql = "UPDATE system"
                    + " SET light_interval_start = ?, light_interval = ?, mist_interval_on = ?, mist_interval_off = ?"
                    + " WHERE system_id = ?";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            /* FILL IN THOSE QUESTION MARKS */
            stmt.setString(1, input.light_interval_start);
            stmt.setString(2, input.light_interval);
            stmt.setString(3, input.mist_interval_on);
            stmt.setString(4, input.mist_interval_off);
            stmt.setInt(5, ValidationUtils.integerConversion(system_id));

            //execute sql statement
            int numRows = stmt.executeUpdate();
            
            //INSERTING INTO LOG TABLE
            
            String sql2 = "INSERT INTO system_command_log (date, log_info, system_id) VALUES(sysdate(), ?, ?)";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt2 = new PrepStatement(dbc, sql2);

            /* FILL IN THOSE QUESTION MARKS */
            stmt2.setString(1, "Updated the fucking shit.");
            stmt2.setInt(2, ValidationUtils.integerConversion(system_id));

            //execute sql statement
            int numRows2 = stmt2.executeUpdate();

           

            errorMsgs.errorMsg = stmt.getErrorMsg();

            if (errorMsgs.errorMsg.length() == 0) { //return empty string if all is gooood, else return dem errors

                if (numRows == 1) {
                    errorMsgs.errorMsg = ""; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
                } else {
                    // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                    errorMsgs.errorMsg = numRows + " records were inserted when exactly 1 was expected.";
                }
                
                if (numRows2 == 1) {
                    errorMsgs.errorMsg = ""; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
                } else {
                    // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                    errorMsgs.errorMsg = numRows2 + " records were inserted when exactly 1 was expected.";
                }

            }

        }

        return errorMsgs;
    }

    /* Fills the error messages if user entered them in incorrectly*/
    public static StringData validate(StringData input) {
        StringData errorMsgs = new StringData();

        /* VALIDATION */
        //errorMsgs.playerId = ValidationUtils.stringValidationMsg(input.playerId, 45, true); //only for updateUser.jsp
        errorMsgs.user_name = ValidationUtils.stringValidationMsg(input.user_name, 30, true);
        errorMsgs.email = ValidationUtils.stringValidationMsg(input.email, 45, true);
        errorMsgs.first_name = ValidationUtils.stringValidationMsg(input.first_name, 45, true);
        errorMsgs.last_name = ValidationUtils.stringValidationMsg(input.last_name, 45, true);
        errorMsgs.phone_number = ValidationUtils.stringValidationMsg(input.phone_number, 45, true);
        errorMsgs.password = ValidationUtils.stringValidationMsg(input.password, 45, true);

        /* DO FOREIGN KEYS??*/

 /* Skill level can be null so don't need this validation*/
        //errorMsgs.skillLevel = ValidationUtils.stringValidationMsg(input.skillLevel, true);
        return errorMsgs;
    }

    /* Fills the error messages if user entered them in incorrectly*/
 /*public static StringArduinoData validate(StringArduinoData input) {
        StringArduinoData errorMsgs = new StringData();

        // VALIDATION 
        //errorMsgs.playerId = ValidationUtils.stringValidationMsg(input.playerId, 45, true); //only for updateUser.jsp
        errorMsgs.user_name = ValidationUtils.stringValidationMsg(input.user_name, 30, true);
        errorMsgs.email = ValidationUtils.stringValidationMsg(input.email, 45, true);
        errorMsgs.first_name = ValidationUtils.stringValidationMsg(input.first_name, 45, true);
        errorMsgs.last_name = ValidationUtils.stringValidationMsg(input.last_name, 45, true);
        errorMsgs.phone_number = ValidationUtils.stringValidationMsg(input.phone_number, 45, true);
        errorMsgs.password = ValidationUtils.stringValidationMsg(input.password, 45, true);

        //DO FOREIGN KEYS??

  //Skill level can be null so don't need this validation
        //errorMsgs.skillLevel = ValidationUtils.stringValidationMsg(input.skillLevel, true);
        return errorMsgs;
    }*/

 /*public static StringData update(StringData input, DbConn dbc) {
        StringData errorMsgs = new StringData();
        errorMsgs = validate(input);

        if (errorMsgs.getCharacterCount() > 0) {  // at least one field has an error, don't go any further.
            errorMsgs.errorMsg = "Try again and enter the required fields.";
            return errorMsgs;
        } else { //all fields pass validation

            // PREPARE INITIAL SQL STATEMENT 
            String sql = "UPDATE Player SET player_name=?, email_address=?, pswd=?, skill_level=?, user_role_id=?  WHERE player_id=?";

            //USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS
            PrepStatement stmt = new PrepStatement(dbc, sql);

            stmt.setString(1, input.playerName);
            stmt.setString(2, input.emailAddress);
            stmt.setString(3, input.pswd);
            stmt.setBigDecimal(4, ValidationUtils.decimalConversion(input.skillLevel));
            stmt.setString(5, input.roleName);
            stmt.setString(6, input.playerId);

            
             //SQL STATEMENT EXECUTED executeUpdate() returns # of rows altered
             //or successfully added
             
            int numRows = stmt.executeUpdate();

            errorMsgs.errorMsg = stmt.getErrorMsg();

            if (errorMsgs.errorMsg.length() == 0) { //return empty string if all is gooood, else return dem errors

                if (numRows == 1) {
                    errorMsgs.errorMsg = ""; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
                } else {
                    // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                    errorMsgs.errorMsg = numRows + " records were inserted when exactly 1 was expected.";
                }
            }

        }
        // if returning empty string then SUCCESS!!! 
        return errorMsgs;

    }

    public static String delete(String primaryKey, DbConn dbc) {
        String message = "";
        String errorMsg = "";

        String sql = "DELETE FROM Player where player_id=?";

        PrepStatement stmt = new PrepStatement(dbc, sql);

        stmt.setString(1, primaryKey); // replace 1st (& only) ?

        int numRows = stmt.executeUpdate(); // run the delete SQL

        errorMsg = stmt.getErrorMsg();

        if (errorMsg.length() == 0) {

            if (numRows == 1) { // number of rows affected
                message += "Record number " + primaryKey + " was sucessfully deleted.";
            } else {
                message += "Trying to delete deleting record number " + primaryKey
                        + ", but " + numRows + " records were deleted.<br/><br/>";
            }

        } else {
            message = "Could not delete player " + primaryKey + " ...This player is registered for a tournament.";
        }

        return message;
    }*/
}
