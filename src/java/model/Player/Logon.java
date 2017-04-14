/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

import java.util.*;
import dbUtils.DbConn;
import dbUtils.FormatUtils;
import java.security.Key;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author jedrickboca
 */
public class Logon {

    public static StringData find(DbConn dbc, String user_name, String password) throws Exception {

        StringData foundUser = new StringData(); // default constructor sets all fields to "" (empty string) 
        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "select user_id, user_name, email, first_name, last_name, phone_number, password, role_id from user where user_name = ? and password = ?";

            PreparedStatement stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts the user's input (from variable emailAddress) into the 1st question mark of the sql statement above. 
            stmt.setString(1, user_name);
            // System.out.println("*** email address substituted into the sql");

            // this puts the user's input (from variable userPwd) into the 2nd question mark of the sql statement above. 
            stmt.setString(2, encrypt(password));
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
                foundUser.password = results.getObject("password").toString();
                foundUser.role_id = results.getObject("role_id").toString();

                return foundUser;
                //throw new Exception("FUCK");
            } else {
                return null; // means player not found with given credentials.
            }

        } catch (Exception e) {
            foundUser.errorMsg = "Exception thrown in Logon.find(): " + e.getMessage();
            return foundUser;
        }

    }
    
    public static String findFirstSystem(DbConn dbc, String user_id) throws Exception {

        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "SELECT system_id FROM system AS s WHERE s.user_id = ? LIMIT 1";

            PreparedStatement stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts the user's input (from variable emailAddress) into the 1st question mark of the sql statement above. 
            stmt.setString(1, user_id);

            ResultSet results = stmt.executeQuery();
            // System.out.println("*** query executed");

            // since the email address is required (in database) to be unique, we don't need a while loop like we did 
            // for the display data lab. An "if" statement is better for this purpose.
            if (results.next()) {
                //System.out.println("*** record selected");
                //foundPlayer.playerId = (int) results.getObject("player_id");
                throw new Exception(results.getObject("system_ip").toString());
                //return results.getObject("system_ip").toString();
                //throw new Exception("FUCK");
            } else {
                return null; // means player not found with given credentials.
            }

        } catch (Exception e) {
            return "Exception thrown in Logon.findFirstSystem(): " + e.getMessage();
        }

    }

    public static String encrypt(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }
}
