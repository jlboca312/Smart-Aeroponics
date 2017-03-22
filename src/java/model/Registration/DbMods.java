/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Registration;

import model.Player.*;
import model.Tournament.*;
import dbUtils.*;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

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
            String sql = "INSERT INTO Registration (donation, special_needs, event_type, player_id, tournament_id) "
                    + "values (?,?,?,?,?)";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            /* FILL IN THOSE QUESTION MARKS */
            stmt.setBigDecimal(1, ValidationUtils.decimalConversion(input.donation));
            /* FIX THIS LATER FOR ONE DECIMAL POINT OR IS IT GOOD??*/
            stmt.setString(2, input.specialNeeds);
            stmt.setString(3, input.eventType);

            /* FILLS IN QUESTION MARK FOR THE SELECT TAG INPUTs*/
            //if player name input is not empty and not equal 0 ,indicating not 'Select Player'
            if ((input.playerName.length() != 0) && !(input.playerName.equals("0"))) {
                stmt.setString(4, input.playerName);
            }
            //if tournament name input is not empty and not equal 0 ,indicating not 'Select Tournament'
            if ((input.tournamentName.length() != 0) && !(input.tournamentName.equals("0"))) {
                stmt.setString(5, input.tournamentName);
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
        //errorMsgs.registrationId = ValidationUtils.stringValidationMsg(input.registrationId, 45, true); //only for updateAssoc.jsp
        errorMsgs.eventType = ValidationUtils.stringValidationMsg(input.eventType, 45, true);
        errorMsgs.donation = ValidationUtils.decimalValidationMsg(input.donation, true);

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
            String sql = "UPDATE Registration SET player_id=?, tournament_id=?, event_type=?, donation=?, special_needs=?"
                    + " WHERE registration_id=?";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            stmt.setString(1, input.playerName);
            stmt.setString(2, input.tournamentName);
            stmt.setString(3, input.eventType);
            stmt.setString(4, input.donation);
            stmt.setString(5, input.specialNeeds);
            stmt.setString(6, input.registrationId);

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

        String sql = "DELETE FROM Registration where registration_id=?";

        PrepStatement stmt = new PrepStatement(dbc, sql);

        stmt.setString(1, primaryKey); // replace 1st (& only) ?

        int numRows = stmt.executeUpdate(); // run the delete SQL

        errorMsg = stmt.getErrorMsg();

        if (errorMsg.length() == 0) {
            
            if (numRows == 1) { // number of rows affected
                message += "Record number " + primaryKey + " was sucessfully deleted.";
            } else {
                message += "Trying to delete deleting record number " + primaryKey
                        + ", but " + numRows + " records were deleted.";
            }
            
        } else {
            message = "Could not delete registration " + primaryKey;
        }
        
        return message;

        
    }

}
