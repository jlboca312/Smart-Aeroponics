package model.Tournament;

import dbUtils.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dbUtils.FormatUtils;

public class Search {

    public static StringData findById(DbConn dbc, String id) {
        StringData foundTournament = new StringData();

        if (id == null) {
            foundTournament.errorMsg = "cannot search for tournament with null tournament id";
            System.out.println("**** Error in model.Tournament.Search.FindById: " + foundTournament.errorMsg);
            return foundTournament;
        }

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {

            String sql = "SELECT tournament_name, event_date, tournament_desc FROM Tournament WHERE tournament_id=?";
            
            stmt = dbc.getConn().prepareStatement(sql);
            
            // this puts the user's input (from variable tournament_name)
            // into the 1st question mark of the sql statement above.
            stmt.setString(1, id);
            
            results = stmt.executeQuery();
            
            // since the tournament_name is required (in database) to be unique, 
            // we don't need a while loop like we did for the display data lab - just if statement
            if (results.next()) {
                foundTournament.tournamentID = id; // id is the tournament id we searched for
                foundTournament.tournamentName = FormatUtils.objectToString(results.getObject("tournament_name"));     
                foundTournament.eventDate = FormatUtils.objectToString(FormatUtils.formatDate(results.getObject("event_date")));              
                foundTournament.tournamentDesc = FormatUtils.objectToString(results.getObject("tournament_desc"));
                
               
                
                results.close();
                stmt.close();
                return foundTournament;
            } else {
                return null; // means customer not found with given credentials.
            }
 
        } catch (Exception e) {
            foundTournament.errorMsg = "Exception thrown in model.Tournament.Search.findById(): " + e.getMessage();
            System.out.println("**** " + foundTournament.errorMsg);
            return foundTournament;
        }

    }
}
