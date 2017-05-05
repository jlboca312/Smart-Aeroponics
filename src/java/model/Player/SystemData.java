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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jedrickboca
 */
public class SystemData {

    public static int getNumRows(DbConn dbc, String user_id, String sql, String systemId) {
        int size = 0;

        try {
            PreparedStatement stmt = null;
            ResultSet results = null;

            stmt = dbc.getConn().prepareStatement(sql);

            // this puts user id into sql statement above
            stmt.setString(1, user_id);
            stmt.setString(2, systemId);

            //execute query
            results = stmt.executeQuery();

            while (results.next()) {
                size++;
            }

            //close conns
            results.close();
            stmt.close();

            return size;

        } catch (SQLException ex) {
            Logger.getLogger(SystemData.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public static int getNumRows2(DbConn dbc, String user_id, String sql) {
        int size = 0;

        try {
            PreparedStatement stmt = null;
            ResultSet results = null;

            stmt = dbc.getConn().prepareStatement(sql);

            // this puts user id into sql statement above
            stmt.setString(1, user_id);

            //execute query
            results = stmt.executeQuery();

            while (results.next()) {
                size++;
            }

            //close conns
            results.close();
            stmt.close();

            return size;

        } catch (SQLException ex) {
            Logger.getLogger(SystemData.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public static StringSystemData[] retrieve(DbConn dbc, String user_id, String systemId) {

        String temp = "SELECT system_status_log_hourly_id, air_temp, water_temp, humidity, water_level, light_on_off, date_logged, s.system_id FROM system_status_log_hourly AS sslh, system AS s WHERE sslh.system_id = s.system_id AND s.user_id = ? AND s.system_id = ?";

        //get number of rows of Database
        int numRows = getNumRows(dbc, user_id, temp, systemId);

        StringSystemData sysData[] = new StringSystemData[numRows]; // default constructor sets all fields to "" (empty string)          
        int i = 0;
        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            String sql = "SELECT system_status_log_hourly_id, air_temp, water_temp, humidity, water_level, light_on_off, date_logged, s.system_id FROM system_status_log_hourly AS sslh, system AS s WHERE sslh.system_id = s.system_id AND s.user_id = ? and s.system_id = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts user id into sql statement above 
            stmt.setString(1, user_id);
            stmt.setString(2, systemId);

            results = stmt.executeQuery();

            //HAS TO BE A WHILE LOOP TO SUPPORT MULTIPLE ARUINO SYSTEMS
            while (results.next()) {
                //allocate memory 
                sysData[i] = new StringSystemData();

                sysData[i].system_status_log_hourly_id = results.getObject("system_status_log_hourly_id").toString();
                sysData[i].air_temp = results.getObject("air_temp").toString();
                sysData[i].water_temp = results.getObject("water_temp").toString();
                sysData[i].humidity = results.getObject("humidity").toString();
                sysData[i].water_level = results.getObject("water_level").toString();
                sysData[i].light_on_off = results.getObject("light_on_off").toString();
                sysData[i].date_logged = results.getObject("date_logged").toString();
                sysData[i].system_id = results.getObject("system_id").toString();

                i++;
                //System.out.println("*** 5 fields extracted from result set");
            }

            //close stuff
            results.close();
            stmt.close();
            System.out.println("fuuuck: " +sysData.length);
            
            return sysData;
        } catch (Exception e) {
            sysData[0].errorMsg = "Exception thrown in SystemData.retrieve(): " + e.getMessage();
            return sysData;
        }

    }

    public static String[] getSystems(DbConn dbc, String user_id) {

        String temp = "SELECT system_id FROM system AS s WHERE s.user_id = ?";

        String systems[] = new String[getNumRows2(dbc, user_id, temp)]; // default constructor sets all fields to "" (empty string)          
        int i = 0;
        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "SELECT system_id FROM system AS s WHERE s.user_id = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts user id into sql statement above 
            stmt.setString(1, user_id);

            results = stmt.executeQuery();

            //HAS TO BE A WHILE LOOP TO SUPPORT MULTIPLE ARUINO SYSTEMS
            while (results.next()) {

                systems[i] = results.getObject("system_id").toString();
                i++;
                //System.out.println("*** 5 fields extracted from result set");
            }

            //close stuff
            results.close();
            stmt.close();

            return systems;
        } catch (Exception e) {
            systems[0] = "Exception thrown in SystemData.getSystems(): " + e.getMessage();
            return systems;
        }
    }

    //for sending system information to the arduino, gets called by updateUserSettings.jsp which is JSON response
    public static StringArduinoData retrieveArduino(String systemId, DbConn dbc) {
        StringArduinoData arduino = new StringArduinoData();
        PreparedStatement stmt = null;
        ResultSet results = null;

        try {

            String sql = "SELECT maint_mode, light, mist, mist_interval_on, mist_interval_off, light_interval, light_interval_start, take_pic"
                    + " FROM system"
                    + " WHERE system_id = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            stmt.setString(1, systemId);
            results = stmt.executeQuery();
        } catch (Exception e) {
            arduino.errorMsg = "Exception thrown in SystemData.retrieveArduino(): " + e.getMessage();
            return arduino;
        }

        try {
            if (results.next()) {

                if (results.getObject("maint_mode") != null) {
                    arduino.maint_mode = results.getObject("maint_mode").toString();
                }
                if (results.getObject("light") != null) {
                    arduino.light = results.getObject("light").toString();
                }
                if (results.getObject("mist") != null) {
                    arduino.mist = results.getObject("mist").toString();
                }
                if (results.getObject("mist_interval_on") != null) {
                    arduino.mist_interval_on = results.getObject("mist_interval_on").toString();
                }
                if (results.getObject("mist_interval_off") != null) {
                    arduino.mist_interval_off = results.getObject("mist_interval_off").toString();
                }
                if (results.getObject("light_interval") != null) {
                    arduino.light_interval = results.getObject("light_interval").toString();
                }
                if (results.getObject("light_interval_start") != null) {
                    arduino.light_interval_start = results.getObject("light_interval_start").toString();
                }
                if (results.getObject("take_pic") != null) {
                    arduino.take_pic = results.getObject("take_pic").toString();
                }

                /*arduino.system_id = results.getObject("system_id").toString();
                arduino.system_ip = results.getObject("system_ip").toString();
                arduino.register_date = results.getObject("register_date").toString();
                arduino.user_id = results.getObject("user_id").toString();*/
            }

            //close stuff
            results.close();
            stmt.close();

            return arduino;
        } catch (Exception e) {
            arduino.errorMsg = "Exception thrown in SystemData.retrieveArduino(): " + e.getMessage();
            return arduino;
        }
    }

    //when user hits take picture button, the take_pic field in the DB will be set to 1 for ten seconds
    //will return the string "1" if successful
    public static String takePicture(String pictureValue, String systemId, DbConn dbc) {
        PreparedStatement stmt = null;
        String msg = "";

        try {

            String sql = "UPDATE system SET take_pic = ? WHERE system_id = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            stmt.setString(1, pictureValue);
            stmt.setString(2, systemId);

            //execute sql statement
            int numRows = stmt.executeUpdate();

            //ERROR CHECKING
            if (numRows == 1) {
                msg = "1"; // This means SUCCESS. Let the JSP page decide how to tell this to the user.
            } else {
                // probably never get here unless you forgot your WHERE clause and did a bulk sql update.
                msg = numRows + " records were modified when exactly 1 was expected.";
            }

            return msg;

        } catch (Exception e) {
            msg = "Exception thrown in SystemData.takePicture(): " + e.getMessage();
            return msg;
        }

    }

    public static String revertPictureInDB(String systemId, DbConn dbc) {
        PreparedStatement stmt2 = null;
        String msg = "";

        try {           

            //revert take_pic back to 0 after ten seconds
            String sql2 = "UPDATE system SET take_pic = 0 WHERE system_id = ?";

            stmt2 = dbc.getConn().prepareStatement(sql2);
            stmt2.setString(1, systemId);

            //execute sql statement
            int numRows2 = stmt2.executeUpdate();

            if (numRows2 == 1) {
                msg = "1"; //meaning success
            } else {
                msg = "In reverting take_pic back to 0, " + numRows2 + " records were modified when exactly 1 was expected.";
            }

            return msg;
        } catch (Exception e) {
            msg = "Exception thrown in SystemData.takePicture(): " + e.getMessage();
            return msg;
        }
    }

}
