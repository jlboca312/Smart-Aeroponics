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
import java.util.HashSet;
import java.util.Set;

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
            String sql = "INSERT INTO Player (player_name, email_address, pswd, skill_level, user_role_id) "
                    + "values (?,?,?,?,?)";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            /* FILL IN THOSE QUESTION MARKS */
            stmt.setString(1, input.playerName);
            stmt.setString(2, input.emailAddress);
            stmt.setString(3, input.pswd);
            stmt.setBigDecimal(4, ValidationUtils.decimalConversion(input.skillLevel));
            /* FIX THIS LATER FOR ONE DECIMAL POINT OR IS IT GOOD??*/

 /* FILLS IN QUESTION MARK FOR THE SELECT TAG INPUT*/
            //if role name input is not empty and not equal 0 ,indicating not 'Select Role Name'
            if ((input.roleName.length() != 0) && !(input.roleName.equals("0"))) {
                stmt.setString(5, input.roleName);
            }

            /**
             * SQL STATEMENT EXECUTED executeUpdate() returns # of rows altered
             * or successfully added
             */
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

        /* if returning empty string then SUCCESS!!! */
        return errorMsgs;
    }

    /* Fills the error messages if user entered them in incorrectly*/
    public static StringData validate(StringData input) {
        StringData errorMsgs = new StringData();

        /* VALIDATION */
        //errorMsgs.playerId = ValidationUtils.stringValidationMsg(input.playerId, 45, true); //only for updateUser.jsp
        errorMsgs.playerName = ValidationUtils.stringValidationMsg(input.playerName, 30, true);
        errorMsgs.emailAddress = ValidationUtils.stringValidationMsg(input.emailAddress, 45, true);
        errorMsgs.pswd = ValidationUtils.stringValidationMsg(input.pswd, 45, true);

        /* Skill level can be null so don't need this validation*/
        //errorMsgs.skillLevel = ValidationUtils.stringValidationMsg(input.skillLevel, true);
        return errorMsgs;
    }

    public static StringData update(StringData input, DbConn dbc) {
        StringData errorMsgs = new StringData();
        errorMsgs = validate(input);

        if (errorMsgs.getCharacterCount() > 0) {  // at least one field has an error, don't go any further.
            errorMsgs.errorMsg = "Try again and enter the required fields.";
            return errorMsgs;
        } else { //all fields pass validation

            /* PREPARE INITIAL SQL STATEMENT */
            String sql = "UPDATE Player SET player_name=?, email_address=?, pswd=?, skill_level=?, user_role_id=?  WHERE player_id=?";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            stmt.setString(1, input.playerName);
            stmt.setString(2, input.emailAddress);
            stmt.setString(3, input.pswd);
            stmt.setBigDecimal(4, ValidationUtils.decimalConversion(input.skillLevel));
            stmt.setString(5, input.roleName);
            stmt.setString(6, input.playerId);

            /**
             * SQL STATEMENT EXECUTED executeUpdate() returns # of rows altered
             * or successfully added
             */
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
        /* if returning empty string then SUCCESS!!! */
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
    }
}
