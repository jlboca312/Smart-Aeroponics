/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

/**
 *
 * @author jedrickboca
 */
public class StringSystemData {
    
    public String system_status_log_hourly_id = "";
    public String air_temp = "";
    public String water_temp = "";
    public String humidity = "";
    public String water_level = "";
    public String light_on_off = "";
    public String date_logged = "";
    public String system_id = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.
    
    public int getCharacterCount(){
        String S = this.system_status_log_hourly_id + this.air_temp + this.water_temp + this.humidity + this.water_level + this.light_on_off + this.date_logged + this.system_id;
        
        return S.length();
    }
    
    public String toString() {
        return "System_status_log_hourly_id:" + this.system_status_log_hourly_id
                + ", air_temp:" + this.air_temp
                + ", water_temp:" + this.water_temp
                + ", humidity:" + this.humidity
                + ", water_level:" + this.water_level
                + ", light_on_off:" + this.light_on_off
                + ", date_logged:" + this.date_logged
                + ", system_id:" + this.system_id
                + ", errorMsg:" + this.errorMsg;
    }
    
}
