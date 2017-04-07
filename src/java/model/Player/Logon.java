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

    public static StringData find(DbConn dbc, String user_name, String salt) {
        StringData foundUser = new StringData(); // default constructor sets all fields to "" (empty string) 
        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "select user_id, user_name, email, first_name, last_name, phone_number, salt, role_id, password_id from user where user_name = ? and salt = ?";
                    

            PreparedStatement stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts the user's input (from variable emailAddress) into the 1st question mark of the sql statement above. 
            stmt.setString(1, user_name);
            // System.out.println("*** email address substituted into the sql");

            // this puts the user's input (from variable userPwd) into the 2nd question mark of the sql statement above. 
            stmt.setString(2, salt);
            // System.out.println("*** pwd substituted into the sql");
            

            ResultSet results = stmt.executeQuery();
            // System.out.println("*** query executed");

            // since the email address is required (in database) to be unique, we don't need a while loop like we did 
            // for the display data lab. An "if" statement is better for this purpose.
            if (results.next()) {
                //System.out.println("*** record selected");
                //foundPlayer.playerId = (int) results.getObject("player_id");
                foundUser.userId = results.getObject("user_id").toString();
                //foundUser.user_name = results.getObject("user_name").toString(); // we can take this from input parameter instead of db. 
                foundUser.user_name = user_name;
                foundUser.email = results.getObject("email").toString();
                //foundPlayer.playerName = FormatUtils.formatStringTd(results.getObject("player_name"));
                foundUser.first_name = results.getObject("first_name").toString();
                foundUser.last_name = results.getObject("last_name").toString();
                foundUser.phone_number = results.getObject("phone_number").toString();
                foundUser.salt = results.getObject("salt").toString();
                foundUser.role_id = results.getObject("role_id").toString();
                foundUser.password_id = results.getObject("password_id").toString();
                //foundPlayer.pswd = FormatUtils.formatStringTd(results.getObject("pswd"));
                
                //System.out.println("*** 5 fields extracted from result set");
                return foundUser;
            } else {
                return null; // means player not found with given credentials.
            }
        } catch (Exception e) {
            foundUser.errorMsg = "Exception thrown in Logon.find(): " + e.getMessage();
            return foundUser;
        }
    }

}
