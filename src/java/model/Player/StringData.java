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
public class StringData {

    public String userId = "";
    public String user_name = "";
    public String email = "";
    public String first_name = "";
    public String last_name = "";
    public String phone_number = "";
    public String password = "";
    public String role_id = "";
    public String system_ip = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.

    public int getCharacterCount(){
        String S = this.userId + this.user_name + this.email + this.first_name + this.last_name + this.phone_number + this.password + this.role_id + this.system_ip;
        
        return S.length();
    }
    
    public String toString() {
        return "Userr Id:" + this.userId
                + ", user_name:" + this.user_name
                + ", Email Address:" + this.email
                + ", Frist Name:" + this.first_name
                + ", Last Name:" + this.last_name
                + ", Phone Number:" + this.phone_number
                + ", Password:" + this.password
                + ", Role Id:" + this.role_id
                + ", System IP;:" + this.system_ip
                + ", errorMsg:" + this.errorMsg;
    }
    
    

}
