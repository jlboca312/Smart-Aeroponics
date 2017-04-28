/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

/**
 *
 * @author Michael
 */
public class StringArduinoData {
    
    public String system_id = "";
    public String system_ip = "";
    public String register_date = "";
    public String light_interval_start = "";
    public String light_interval = "";
    public String mist_interval_on = "";
    public String mist_interval_off = "";
    public String maint_mode = "";
    public String light = "";
    public String mist = "";
    public String take_pic = "";
    public String user_id = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.
    
    public int getCharacterCount(){
        String S = this.system_id + this.system_ip + this.register_date + this.light_interval_start + this.light_interval + this.mist_interval_on + this.mist_interval_off + this.maint_mode + this.light + this.mist + this.take_pic + this.user_id;
        
        return S.length();
    }
    
    public String toString() {
        return "system_id:" + this.system_id
                + ", system_ip:" + this.system_ip
                + ", register_date:" + this.register_date
                + ", light_interval_start:" + this.light_interval_start
                + ", light_interval:" + this.light_interval
                + ", mist_interval_on:" + this.mist_interval_on
                + ", mist_interval_off:" + this.mist_interval_off
                + ", maint_mode:" + this.maint_mode
                + ", light:" + this.light
                + ", mist:" + this.mist
                + ", take_pic:" + this.take_pic
                + ", user_id:" + this.user_id
                + ", errorMsg:" + this.errorMsg;
    }
}
