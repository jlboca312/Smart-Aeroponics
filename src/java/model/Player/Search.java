
package model.Player;

import dbUtils.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dbUtils.FormatUtils;

public class Search {
    
    /*public static StringData findById(DbConn dbc, String id) {
        StringData foundPlayer = new StringData();

        if (id == null) {
            foundPlayer.errorMsg = "cannot search for player with null player id";
            System.out.println("**** Error in model.Player.Search.FindById: " + foundPlayer.errorMsg);
            return foundPlayer;
        }

        PreparedStatement stmt = null;
        ResultSet results = null;

        try {

            String sql = "SELECT player_name, email_address, pswd, skill_level, role_name, U.user_role_id FROM Player as P, User_role as U"
                    + " WHERE P.user_role_id = U.user_role_id and player_id=?";
            
            stmt = dbc.getConn().prepareStatement(sql);
            
            // this puts the user's input (from variable tournament_name)
            // into the 1st question mark of the sql statement above.
            stmt.setString(1, id);
            
            results = stmt.executeQuery();
            
            // since the tournament_name is required (in database) to be unique, 
            // we don't need a while loop like we did for the display data lab - just if statement
            if (results.next()) {
                foundPlayer.playerId = id; // id is the tournament id we searched for
                foundPlayer.playerName = FormatUtils.objectToString(results.getObject("player_name"));
                foundPlayer.emailAddress = FormatUtils.objectToString(results.getObject("email_address"));
                foundPlayer.pswd = FormatUtils.objectToString(results.getObject("pswd"));
                foundPlayer.skillLevel = FormatUtils.objectToString(results.getObject("skill_level"));
                foundPlayer.roleName = FormatUtils.objectToString(results.getObject("U.user_role_id")); 
                
                results.close();
                stmt.close();
                return foundPlayer;
            } else {
                return null; // means customer not found with given credentials.
            }
 
        } catch (Exception e) {
            foundPlayer.errorMsg = "Exception thrown in model.Player.Search.findById(): " + e.getMessage();
            System.out.println("**** " + foundPlayer.errorMsg);
            return foundPlayer;
        }

    }*/
}
