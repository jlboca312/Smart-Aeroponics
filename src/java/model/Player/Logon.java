/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

import java.util.*;
import dbUtils.DbConn;
import dbUtils.FormatUtils;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author jedrickboca
 */
public class Logon {

    public static StringData find(DbConn dbc, String emailAddress, String userPwd) {
        StringData foundPlayer = new StringData(); // default constructor sets all fields to "" (empty string) 
        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "select player_id, player_name, email_address, pswd from Player as P"
                    + " where email_address = ? and pswd = ? ";

            PreparedStatement stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts the user's input (from variable emailAddress) into the 1st question mark of the sql statement above. 
            stmt.setString(1, emailAddress);
            // System.out.println("*** email address substituted into the sql");

            // this puts the user's input (from variable userPwd) into the 2nd question mark of the sql statement above. 
            stmt.setString(2, userPwd);
            // System.out.println("*** pwd substituted into the sql");

            ResultSet results = stmt.executeQuery();
            // System.out.println("*** query executed");

            // since the email address is required (in database) to be unique, we don't need a while loop like we did 
            // for the display data lab. An "if" statement is better for this purpose.
            if (results.next()) {
                //System.out.println("*** record selected");
                //foundPlayer.playerId = (int) results.getObject("player_id");
                foundPlayer.playerId = results.getObject("player_id").toString();
                foundPlayer.playerName = results.getObject("player_name").toString();
                //foundPlayer.playerName = FormatUtils.formatStringTd(results.getObject("player_name"));
                foundPlayer.emailAddress = emailAddress; // we can take this from input parameter instead of db. 
                //foundPlayer.pswd = FormatUtils.formatStringTd(results.getObject("pswd"));
                foundPlayer.pswd = results.getObject("pswd").toString();
                //System.out.println("*** 5 fields extracted from result set");
                return foundPlayer;
            } else {
                return null; // means player not found with given credentials.
            }
        } catch (Exception e) {
            foundPlayer.errorMsg = "Exception thrown in Logon.find(): " + e.getMessage();
            return foundPlayer;
        }
    }

}
