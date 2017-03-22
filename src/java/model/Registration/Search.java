
package model.Registration;

import dbUtils.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dbUtils.FormatUtils;

public class Search {
    
    public static StringData findById(DbConn dbc, String id) {
        StringData foundReg = new StringData();

        if (id == null) {
            foundReg.errorMsg = "cannot search for registration with null registration id";
            System.out.println("**** Error in model.Registration.Search.FindById: " + foundReg.errorMsg);
            return foundReg;
        }

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {

            String sql = "select registration_id, player_name, tournament_name, event_type, donation, special_needs, P.player_id, T.tournament_id"
                    + " from Player as P, Registration as R, Tournament as T"
                    + " where P.player_id = R.player_id and T.tournament_id = R.tournament_id and registration_id=?";
            
                    
            stmt = dbc.getConn().prepareStatement(sql);
            

            stmt.setString(1, id);
            
            results = stmt.executeQuery();
            
            // since the tournament_name is required (in database) to be unique, 
            // we don't need a while loop like we did for the display data lab - just if statement
            if (results.next()) {
                foundReg.registrationId = id; // id is the tournament id we searched for
                foundReg.playerName = FormatUtils.objectToString(results.getObject("P.player_id"));
                foundReg.tournamentName = FormatUtils.objectToString(results.getObject("T.tournament_id"));
                foundReg.eventType = FormatUtils.objectToString(results.getObject("event_type"));
                foundReg.donation = FormatUtils.objectToString(results.getObject("donation"));
                foundReg.specialNeeds = FormatUtils.objectToString(results.getObject("special_needs"));
                
                results.close();
                stmt.close();
                return foundReg;
            } else {
                return null; // means customer not found with given credentials.
            }
 
        } catch (Exception e) {
            foundReg.errorMsg = "Exception thrown in model.Registration.Search.findById(): " + e.getMessage();
            System.out.println("**** " + foundReg.errorMsg);
            return foundReg;
        }

    }

}
