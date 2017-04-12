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


    public static int getNumRows(DbConn dbc, String user_id) {
        int size = 0;
        
        try {
            PreparedStatement stmt = null;
            ResultSet results = null;
            
            String sql = "SELECT system_status_log_hourly_id, air_temp, water_temp, humidity, water_level, light_on_off, date_logged, s.system_id FROM system_status_log_hourly AS sslh, system AS s WHERE sslh.system_id = s.system_id AND s.user_id = ?";
            
            stmt = dbc.getConn().prepareStatement(sql);            
            
            // this puts user id into sql statement above
            stmt.setString(1, user_id);
            
            //execute query
            results = stmt.executeQuery();
            
            while(results.next()){
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

    public static StringSystemData[] retrieve(DbConn dbc, String user_id) {

        //get number of rows of Database
        int numRows = getNumRows(dbc, user_id);
        
        StringSystemData sysData[] = new StringSystemData[numRows]; // default constructor sets all fields to "" (empty string)          
        int i = 0;
        PreparedStatement stmt = null;
        ResultSet results = null;

        try {
            //String sql = "select customer_id, credit_limit from customer where email_address = ? and pwd = ?";
            String sql = "SELECT system_status_log_hourly_id, air_temp, water_temp, humidity, water_level, light_on_off, date_logged, s.system_id FROM system_status_log_hourly AS sslh, system AS s WHERE sslh.system_id = s.system_id AND s.user_id = ?";

            stmt = dbc.getConn().prepareStatement(sql);
            // System.out.println("*** statement prepared- no sql compile errors");

            // this puts user id into sql statement above 
            stmt.setString(1, user_id);

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

            return sysData;
        } catch (Exception e) {
            sysData[0].errorMsg = "Exception thrown in SystemData.retrieve(): " + e.getMessage();
            return sysData;
        }

    }

}
