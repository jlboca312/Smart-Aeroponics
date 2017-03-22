/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Tournament;

import dbUtils.*;
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
            String sql = "INSERT INTO Tournament (tournament_name, event_date, tournament_desc) "
                    + "values (?,?,?)";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            /* FILL IN THOSE QUESTION MARKS */
            stmt.setString(1, input.tournamentName);
            stmt.setDate(2, ValidationUtils.dateConversion(input.eventDate)); //convert string to java.sql.Date using Sally's dateConversion method
            stmt.setString(3, input.tournamentDesc);

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
        //errorMsgs.tournamentID = ValidationUtils.stringValidationMsg(input.tournamentID, 45, true); //only for updateTournament.jsp
        errorMsgs.tournamentName = ValidationUtils.stringValidationMsg(input.tournamentName, 45, true);
        errorMsgs.eventDate = ValidationUtils.dateValidationMsg(input.eventDate, true);

        /* Tournament Description can be null so don't need this validation*/
        //errorMsgs.tournamentDesc = ValidationUtils.stringValidationMsg(input.tournamentDesc, 100, true);
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
            String sql = "UPDATE Tournament SET tournament_name=?, event_date=?, tournament_desc=? WHERE tournament_id=?";

            /* USING SALLY'S WRAPPER PREPAREDSTATEMENT CLASS*/
            PrepStatement stmt = new PrepStatement(dbc, sql);

            stmt.setString(1, input.tournamentName);
            stmt.setDate(2, ValidationUtils.dateConversion(input.eventDate));
            stmt.setString(3, input.tournamentDesc);
            stmt.setString(4, input.tournamentID);

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

        String sql = "DELETE FROM Tournament where tournament_id=?";
        
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
            message = "Could not delete tournament " + primaryKey+ " ...There are players registered for this tournament.";
        }
        
        return message;
    }
   

}
